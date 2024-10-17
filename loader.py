import os
import requests
from dotenv import load_dotenv
from langchain_community.graphs import Neo4jGraph
import streamlit as st
from streamlit.logger import get_logger
from chains import load_embedding_model
from utils import create_constraints, create_vector_index
from PIL import Image
from stqdm import stqdm
import streamlit_authenticator as stauth
import yaml
from yaml.loader import SafeLoader

load_dotenv(".env")

url = os.getenv("NEO4J_URI")
username = os.getenv("NEO4J_USERNAME")
password = os.getenv("NEO4J_PASSWORD")
database = os.getenv("NEO4J_DATABASE")
ollama_base_url = os.getenv("OLLAMA_BASE_URL")
embedding_model_name = os.getenv("EMBEDDING_MODEL")
# Remapping for Langchain Neo4j integration
os.environ["NEO4J_URL"] = url

logger = get_logger(__name__)

embeddings, dimension = load_embedding_model(
    embedding_model_name, config={"ollama_base_url": ollama_base_url}, logger=logger
)

neo4j_graph = Neo4jGraph(url=url, database=database, username=username, password=password)

create_constraints(neo4j_graph)
create_vector_index(neo4j_graph, dimension)

def calculate_embeddings():

    preparation_query = os.getenv("PREPARATION_QUERY")
    if preparation_query is not None:
        neo4j_graph.query(preparation_query)

    q = f"MATCH (n:{os.environ['LABEL']}) RETURN n.{os.environ['PROPERTY_IDENTIFIER']} AS guid, n.{os.environ['PROPERTY_TEXT']} AS text"
    logger.info("query to run: " + q)
    result = neo4j_graph.query(q)
    logger.info("before embeddings")

    result = [ {"guid": x["guid"], "text": embeddings.embed_query(x["text"])} for x in stqdm(result) ] 
    logger.info(f"after embeddings {len(result)}")

    logger.info("before applying to db")
    import_query = f"""
    UNWIND $data AS x
    CALL {{
        WITH x
        MATCH (a:{os.environ['LABEL']} {{{os.environ['PROPERTY_IDENTIFIER']}: x.guid}}) 
        SET a.{os.environ['PROPERTY_EMBEDDING']} = x.text
    }} IN TRANSACTIONS OF 1000 ROWS
    """
    neo4j_graph.query(import_query, {"data": result})
    logger.info("after applying to db")

# Streamlit
# def get_tag() -> str:
#     input_text = st.text_input(
#         "Which tag questions do you want to import?", value="neo4j"
#     )
#     return input_text


# def get_pages():
#     col1, col2 = st.columns(2)
#     with col1:
#         num_pages = st.number_input(
#             "Number of pages (100 questions per page)", step=1, min_value=1
#         )
#     with col2:
#         start_page = st.number_input("Start page", step=1, min_value=1)
#     st.caption("Only questions with answers will be imported.")
#     return (int(num_pages), int(start_page))


def render_page():

    with open('.auth.yaml') as file:
        config = yaml.load(file, Loader=SafeLoader)

    authenticator = stauth.Authenticate(
        config['credentials'],
        config['cookie']['name'],
        config['cookie']['key'],
        config['cookie']['expiry_days']
    )

    try:
        authenticator.login()
    except stauth.utilities.exceptions.LoginError as e:
        st.error(e)

    if st.session_state['authentication_status']:
        authenticator.logout()
        st.write(f'Welcome *{st.session_state["name"]}*')
        
        datamodel_image = Image.open("./images/datamodel.png")
        st.header("Create Embeddings")
        st.subheader(f"For all nodes with label {os.environ['LABEL']} an embedding will be created")
        st.caption("Go to http://localhost:7474/ to explore the graph.")

        # user_input = get_tag()
        # num_pages, start_page = get_pages()

        if st.button("Run", type="primary"):
            with st.spinner("Loading... This might take some time."):
                try:
                    calculate_embeddings()
                    st.success("Import successful", icon="✅")
                    st.caption("Data model")
                    st.image(datamodel_image)
                    st.caption("Go to http://localhost:7474/ to interact with the database")
                except Exception as e:
                    st.error(f"Error: {e}", icon="🚨")
        # with st.expander("Highly ranked questions rather than tags?"):
        #     if st.button("Import highly ranked questions"):
        #         with st.spinner("Loading... This might take a minute or two."):
        #             try:
        #                 load_high_score_so_data()
        #                 st.success("Import successful", icon="✅")
        #             except Exception as e:
        #                 st.error(f"Error: {e}", icon="🚨")


    elif st.session_state['authentication_status'] is False:
        st.error('Username/password is incorrect')
    elif st.session_state['authentication_status'] is None:
        st.warning('Please enter your username and password')


   
render_page()
