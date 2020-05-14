from typing import List

from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from starlette.responses import HTMLResponse

from . import crud, schemas
from .database import SessionLocal

# APIRouter is equivalent to Flask's blueprint
# It allows us to extend FastAPI Routes
router = APIRouter()


def get_db():
    try:
        db = SessionLocal()
        yield db
    finally:
        db.close()


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


@router.post("/add_vendor", response_model=schemas.Vendor)
def create_vendor(vendor: schemas.VendorCreate, session: Session = Depends(get_db)):

    """
    Adds a new vendor to the database - MealCare

    :body: JSON of the form {name: "str", address: "str", city:"str"}

    :return: JSON response with created entry
    """

    db_vendor = crud.get_vendor_by_name(session, name=vendor.name)
    if db_vendor:
        raise HTTPException(status_code=400, detail="Vendor already registered")
    return crud.create_vendor(session=session, vendor=vendor)


@router.post("/add_food", response_model=schemas.Food)
def create_food(food: schemas.FoodCreate, session: Session = Depends(get_db)):
    """
    Adds a new food item to the database - MealCare

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
    return crud.create_food(session=session, food=food)


@router.delete("/remove_food/{food_id}", response_model=int)
def remove_food(food_id, session: Session = Depends(get_db)):
    """
    Remove a food item from the database - MealCare
    :body: JSON of the form 
    {
        "id": "int"
    } 
    :return: JSON response with deleted entry
    """
    return crud.remove_food(session=session, food_id=food_id)


@router.get("/get_all_food", response_model=List[schemas.Food])
def get_all_food(session: Session = Depends(get_db)):
    """
    Get all food from the database - MealCare
    :return: JSON response with get all entries
    """

    db_all_food = crud.get_all_food(session)
    if not db_all_food:
        raise HTTPException(status_code=404, detail="No food")
    return db_all_food


@router.get("/vendors/", response_model=List[schemas.Vendor])
def read_vendors(skip: int = 0, limit: int = 100, db: Session = Depends(get_db)):
    vendors = crud.get_vendors(db, skip=skip, limit=limit)
    return vendors


@router.get("/vendors/{vendor_id}", response_model=schemas.Vendor)
def read_user(vendor_id: int, db: Session = Depends(get_db)):
    db_vendor = crud.get_vendor(db, vendor_id=vendor_id)
    if db_vendor is None:
        raise HTTPException(status_code=404, detail="Vendor not found")
    return db_vendor


@router.post("/vendors/{vendor_id}/add_tray", response_model=schemas.Tray)
def create_tray_for_vendor(
    vendor_id: int, tray: schemas.TrayCreate, session: Session = Depends(get_db)
):
    """
    Adds a new tray item to the database - MealCare

    :body: JSON of the form
    {
        "type":"str",
        "date_acquired":"YYYY-MM-DD HH:MM:SS.ffffff",
        "vendor":"int",
        "decription":"str"
    }

    :return: JSON response with created entry
    """
    return crud.create_tray(session=session, tray=tray, vendor_id=vendor_id)


@router.post("/add_food_collect", response_model=schemas.FoodCollect)
def create_food_collect(
    food_collect: schemas.FoodCollectCreate, session: Session = Depends(get_db)
):

    """
    Adds a new food_collect to the database - MealCare

    :body: JSON of the form 
    {
        "pickup_time": "datetime", (Format: https://pydantic-docs.helpmanual.io/usage/types/#datetime-types, ex: "2032-04-23T10:20")
        "vendor_id": "int"
    } 

    :return: JSON response with created entry
    """
    db_vendor_id = crud.get_vendor_by_id(session, id=food_collect.vendor_id)
    if db_vendor_id is None:
        raise HTTPException(status_code=404, detail="Vendor not registered")
    return crud.create_food_collect(session=session, food_collect=food_collect)


@router.delete("/remove_food_collect/{food_collect_id}", response_model=int)
def remove_food_collect(food_collect_id, session: Session = Depends(get_db)):
    """
    Remove a food_collect from the database - MealCare

    :body: JSON of the form 
    {
        "id": "int"
    } 

    :return: JSON response with deleted entry
    """
    return crud.remove_food_collect(session=session, food_collect_id=food_collect_id)


@router.get("/get_food_collect/{food_collect_id}", response_model=schemas.FoodCollect)
def get_food_collect(food_collect_id, session: Session = Depends(get_db)):
    """
    Get a food_collect from the database - MealCare

    :return: JSON response with get entry
    """

    db_food_collect = crud.get_food_collect(session, food_collect_id)
    if not db_food_collect:
        raise HTTPException(status_code=404, detail="No such food_collect_id")
    return db_food_collect


@router.get("/get_all_food_collect", response_model=List[schemas.FoodCollect])
def get_all_food_collect(session: Session = Depends(get_db)):
    """
    Get all food_collect from the database - MealCare

    :return: JSON response with get all entries
    """

    db_all_food_collect = crud.get_all_food_collect(session)
    if not db_all_food_collect:
        raise HTTPException(status_code=404, detail="No food_collects")
    return db_all_food_collect


@router.put("/update_food_collect", response_model=schemas.FoodCollect)
def update_food_collect(
    food_collect: schemas.FoodCollect, session: Session = Depends(get_db)
):
    """
    Update food_collect from the database - MealCare

    :return: JSON response with the updated entry
    """

    db_vendor = crud.get_vendor_by_id(session, id=food_collect.vendor_id)
    if not db_vendor:
        raise HTTPException(status_code=400, detail="No such vendor")

    db_update_food_collect = crud.update_food_collect(session, food_collect)
    if not db_update_food_collect:
        raise HTTPException(status_code=404, detail="No updates")
    return db_update_food_collect


@router.post("/add_user", response_model=schemas.User)
def create_user(user: schemas.UserCreate, session: Session = Depends(get_db)):
    """
    Adds a new user to the database - MealCare

    :body:
    {
        "name":"str",
        "username":"str",
        "password":"str",
        "is_vendor":"bool",
        "disabled":"bool"
    }

    :return: JSON response with created entry
    """
    return crud.create_user(session=session, user=user)
