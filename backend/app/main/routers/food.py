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


@router.post("/add_food/{food_collect_id}", response_model=schemas.Food)
def create_food(
    food_collect_id: int, food: schemas.FoodCreate, session: Session = Depends(get_db)
):
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
    return crud.create_food(session=session, food=food, food_collect_id=food_collect_id)


@router.delete("/remove_food/{food_id}", response_model=int)
def remove_food(food_id, session: Session = Depends(get_db)):
    """
    Remove a food item from the database - MealCare
    :body: JSON of the form
    { "id": "int" }
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
