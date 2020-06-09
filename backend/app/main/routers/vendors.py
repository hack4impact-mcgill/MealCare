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


@router.get("/vendors/", response_model=List[schemas.Vendor])
def read_vendors(skip: int = 0, limit: int = 100, db: Session = Depends(get_db)):
    """
    Gets all vendors from the database - MealCare
    :return: JSON response with get all entries
    """
    vendors = crud.get_vendors(db, skip=skip, limit=limit)
    return vendors


@router.get("/vendors/{vendor_id}", response_model=schemas.Vendor)
def read_user(vendor_id: int, db: Session = Depends(get_db)):
    """
    Gets vendor with input vendor_id from database - MealCare
    :return: JSON response with get entry
    """
    db_vendor = crud.get_vendor(db, vendor_id=vendor_id)
    if db_vendor is None:
        raise HTTPException(status_code=404, detail="Vendor not found")
    return db_vendor
