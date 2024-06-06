import os
import requests
from dotenv import load_dotenv
from langchain_community.graphs import Neo4jGraph
import streamlit as st
from streamlit.logger import get_logger
from chains import load_embedding_model
from utils import create_constraints, create_vector_index
from PIL import Image

load_dotenv(".env")

url = os.getenv("NEO4J_URI")
username = os.getenv("NEO4J_USERNAME")
password = os.getenv("NEO4J_PASSWORD")
ollama_base_url = os.getenv("OLLAMA_BASE_URL")
embedding_model_name = os.getenv("EMBEDDING_MODEL")
# Remapping for Langchain Neo4j integration
os.environ["NEO4J_URL"] = url

logger = get_logger(__name__)

embeddings, dimension = load_embedding_model(
    embedding_model_name, config={"ollama_base_url": ollama_base_url}, logger=logger
)

neo4j_graph = Neo4jGraph(url=url, username=username, password=password)

create_constraints(neo4j_graph)
create_vector_index(neo4j_graph, dimension)

def calculate_embeddings():
    neo4j_graph.query("match (t:Text{type:'abstract'}) set t:Abstract")

    result = neo4j_graph.query("MATCH (n:Abstract) RETURN n.guid AS guid , n.text AS text")
    logger.info(result)
    result = list(map(lambda x: {"guid": x["guid"], "text": embeddings.embed_query(x["text"])}, result))

    logger.info(result)

    import_query = """
    UNWIND $data AS x
    MATCH (a:Abstract {guid: x.guid}) 
    SET a.embedding = x.text
    """
    neo4j_graph.query(import_query, {"data": result})


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
    datamodel_image = Image.open("./images/datamodel.png")
    st.header("Create Embeddings")
    st.subheader("For all nodes with label Abstract an embedding will be created")
    st.caption("Go to http://localhost:7474/ to explore the graph.")

    # user_input = get_tag()
    # num_pages, start_page = get_pages()

    if st.button("Run", type="primary"):
        with st.spinner("Loading... This might take a minute or two."):
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


render_page()
