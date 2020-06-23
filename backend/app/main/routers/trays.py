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


@router.post(
    "/vendors/{vendor_id}/{food_collect_id}/add_tray", response_model=schemas.Tray
)
def create_tray_for_vendor(
    vendor_id: int,
    food_collect_id: int,
    tray: schemas.TrayCreate,
    session: Session = Depends(get_db),
):
    """
    Adds a new tray item to the database - MealCare
    :body: JSON of the form
    {
    "type":"str",
    "date_acquired":"YYYY-MM-DD HH:MM:SS.ffffff",
    "vendor":"int",
    "decription":"str",
    "tray_collect_id":"int",
    "tray_return_id":"int",
    }
    :return: JSON response with created entry
    """
    return crud.create_tray(
        session=session, tray=tray, vendor_id=vendor_id, food_collect_id=food_collect_id
    )


@router.post("/add_tray_collect", response_model=schemas.TrayCollect)
def create_tray_collect(
    tray_collect: schemas.TrayCollectCreate, session: Session = Depends(get_db)
):
    """
    Adds a new tray_collect to the database - MealCare
    :body: JSON of the form
    {
    "pickup_time": "datetime", (Format: https://pydantic-docs.helpmanual.io/usage/types/#datetime-types, ex: "2032-04-23T10:20")
    "vendor_id": "int"
    }
    :return: JSON response with created entry
    """
    db_vendor_id = crud.get_vendor_by_id(session, id=tray_collect.vendor_id)
    if db_vendor_id is None:
        raise HTTPException(status_code=404, detail="Vendor not registered")
    return crud.create_tray_collect(session=session, tray_collect=tray_collect)


@router.post("/add_tray_return", response_model=schemas.TrayReturn)
def create_tray_return(
    tray_return: schemas.TrayReturnCreate, session: Session = Depends(get_db)
):
    """
    Adds a new tray_return to the database - MealCare
    :body: JSON of the form
    {
    "return_time": "datetime", (Format: https://pydantic-docs.helpmanual.io/usage/types/#datetime-types, ex: "2032-04-23T10:20")
    "vendor_id": "int"
    }
    :return: JSON response with created entry
    """
    db_vendor_id = crud.get_vendor_by_id(session, id=tray_return.vendor_id)
    if db_vendor_id is None:
        raise HTTPException(status_code=404, detail="Vendor not registered")
    return crud.create_tray_return(session=session, tray_return=tray_return)
