from fastapi import APIRouter
from starlette.responses import HTMLResponse
from pony.orm import Database

# APIRouter is equivalent to Flask's blueprint
# It allows us to extend FastAPI Routes
router = APIRouter()


# Example function on how to create a db and to connect using pony.orm
def get_db():
    db = Database()
    db.bind(provider="postgres",
            user='mealadmin',
            password='happymeal',
            host='127.0.0.1',
            database='mealcare_dev')
    return db


# Initialize the Database Object
db = get_db()


@router.get("/")
def main():
    """
    Displays MealCare

    :return: HTMLResponse - MealCare
    """

    title = """
    <pre>
.___  ___.  _______     ___       __           ______     ___      .______       _______ 
|   \/   | |   ____|   /   \     |  |         /      |   /   \     |   _  \     |   ____|
|  \  /  | |  |__     /  ^  \    |  |        |  ,----'  /  ^  \    |  |_)  |    |  |__   
|  |\/|  | |   __|   /  /_\  \   |  |        |  |      /  /_\  \   |      /     |   __|  
|  |  |  | |  |____ /  _____  \  |  `----.   |  `----./  _____  \  |  |\  \----.|  |____ 
|__|  |__| |_______/__/     \__\ |_______|    \______/__/     \__\ | _| `._____||_______|
    </pre>                                                                               
    """

    return HTMLResponse(title)


@router.get("/health")
def health():
    """
    Displays a health check

    :return: HTMLResponse - MealCare
    """

    health = "healthy"

    return HTMLResponse(health)
