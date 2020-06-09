from typing import List

from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session

from .. import crud, schemas
from ..database import SessionLocal

router = APIRouter()


def get_db():
    try:
        db = SessionLocal()
        yield db
    finally:
        db.close()


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
