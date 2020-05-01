from fastapi import APIRouter
from pydantic import BaseModel
from starlette.responses import HTMLResponse

from .dbase import *

# APIRouter is equivalent to Flask's blueprint
# It allows us to extend FastAPI Routes
router = APIRouter()


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


# VENDOR REQUEST BODY
class VendorBody(BaseModel):
    name: str
    address: str
    city: str


@router.post("/add_vendor")
def vend(item: VendorBody):
    """
    Adds a new vendor to the database - MealCare

    :body: JSON of the form {name: "str", address: "str", city:"str"}

    :return: JSON response with created entry
    """

    create_vendor(item)
    return item


# FOOD REQUEST BODY
class FoodBody(BaseModel):
    name: str
    weight: float
    date_produced: date
    expiry_date: date = None
    description: str = ""
    category: str
    serving_size: str = ""


@router.post("/add_food")
def food(item: FoodBody):
    """
    Adds a new vendor to the database - MealCare

    :body: JSON of the form 
    {
        "name":"str",
        "weight":int,
        "date_produced":"YYYY-MM-DD",
        "expiry_date":"YYYY-MM-DD",
        "decription":"str",
        "category":"str",
        "serving_size":"str"
    }

    :return: JSON response with created entry
    """
    create_food(item)
    return item
