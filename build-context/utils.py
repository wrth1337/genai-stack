import os

class BaseLogger:
    def __init__(self) -> None:
        self.info = print


def extract_title_and_question(input_string):
    lines = input_string.strip().split("\n")

    title = ""
    question = ""
    is_question = False  # flag to know if we are inside a "Question" block

    for line in lines:
        if line.startswith("Title:"):
            title = line.split("Title: ", 1)[1].strip()
        elif line.startswith("Question:"):
            question = line.split("Question: ", 1)[1].strip()
            is_question = (
                True  # set the flag to True once we encounter a "Question:" line
            )
        elif is_question:
            # if the line does not start with "Question:" but we are inside a "Question" block,
            # then it is a continuation of the question
            question += "\n" + line.strip()

    return title, question


def create_vector_index(driver, dimension: int) -> None:
    try:
        driver.query("CALL db.index.vector.createNodeIndex($index_name, $label, $property_embedding, $dimension, 'cosine')",
            {
                "dimension": dimension,
                "index_name": f"{os.environ['LABEL'].lower()}_index",
                "label": os.environ["LABEL"],
                "property_embedding": os.environ["PROPERTY_EMBEDDING"]
            }
        )
    except:  # Already exists
        pass

def create_constraints(driver):
    # driver.query(
    #     "CREATE CONSTRAINT question_id IF NOT EXISTS FOR (q:Question) REQUIRE (q.id) IS UNIQUE"
    # )
    # driver.query(
    #     "CREATE CONSTRAINT answer_id IF NOT EXISTS FOR (a:Answer) REQUIRE (a.id) IS UNIQUE"
    # )
    # driver.query(
    #     "CREATE CONSTRAINT user_id IF NOT EXISTS FOR (u:User) REQUIRE (u.id) IS UNIQUE"
    # )
    # driver.query(
    #     "CREATE CONSTRAINT tag_name IF NOT EXISTS FOR (t:Tag) REQUIRE (t.name) IS UNIQUE"
    # )
    pass    