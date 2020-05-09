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
