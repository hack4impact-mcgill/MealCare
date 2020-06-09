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


@router.post("/new_session", response_model=int)
def begin_new_session(
    food_collect: schemas.FoodCollectCreate, session: Session = Depends(get_db)
):
    """
    Adds new food_collect, then returns its id for future operations
    :return: JSON response with id of the created entry
    """
    db_vendor_id = crud.get_vendor_by_id(session, id=food_collect.vendor_id)
    if db_vendor_id is None:
        raise HTTPException(status_code=404, detail="Vendor not registered")
    db_food_collect = crud.create_food_collect(session, food_collect)
    return db_food_collect.id


@router.get(
    "/get_session_food_items/{food_collect_id}", response_model=List[schemas.Food]
)
def get_session_food_items(food_collect_id, session: Session = Depends(get_db)):
    """
    Get session food items from the database - MealCare
    :return: JSON response with get all entries
    """
    db_session_food_items = crud.get_session_food_items(
        session=Session, food_collect_id=food_collect_id
    )
    if not db_session_food_items:
        raise HTTPException(status_code=404, detail="No food_collects")
    return db_session_food_items


@router.post("/add_session_food/{food_collect_id}", response_model=int)
def add_session_food(
    food_collect_id: int,
    trays: List[schemas.TrayCreate],
    food: schemas.FoodCreate,
    session: Session = Depends(get_db),
):
    """
    Add food and trays in the specified food_collect_id given that the food_collect object has been created
    :return: JSON response with id of the food_collect
    """
    db_session_food_collect = crud.get_food_collect(session, food_collect_id)
    if not db_session_food_collect:
        raise HTTPException(status_code=404, detail="NO food_collects")
    else:
        crud.create_food(session=session, food=food, food_collect_id=food_collect_id)
        vendor_id = db_session_food_collect.vendor_id
        for tray in trays:
            db_session_tray = crud.create_tray(
                session=session,
                tray=tray,
                vendor_id=vendor_id,
                food_collect_id=food_collect_id,
            )
            if not db_session_tray:
                raise HTTPException(status_code=500, detail="Could not create tray")
        return food_collect_id
