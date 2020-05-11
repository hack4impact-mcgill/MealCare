from sqlalchemy.orm import Session

from . import models, schemas


def get_vendor_by_name(session: Session, name: str):
    return session.query(models.Vendor).filter(models.Vendor.name == name).first()


def get_vendor(session: Session, vendor_id: int):
    return session.query(models.Vendor).filter(models.Vendor.id == vendor_id).first()


def get_vendors(session: Session, skip: int = 0, limit: int = 100):
    return session.query(models.Vendor).offset(skip).limit(limit).all()


def create_vendor(session: Session, vendor: schemas.VendorCreate):
    db_vendor = models.Vendor(
        name=vendor.name, address=vendor.address, city=vendor.city
    )
    session.add(db_vendor)
    session.commit()
    session.refresh(db_vendor)
    return db_vendor


def remove_vendor(session: Session, vendor_id: int):
    session.query(models.Vendor).filter(models.Vendor.id == vendor_id).delete()
    session.commit()
    return vendor_id


def create_food(session: Session, food: schemas.FoodCreate):
    db_food = models.Food(
        name=food.name,
        weight=food.weight,
        date_produced=food.date_produced,
        expiry_date=food.expiry_date,
        description=food.description,
        category=food.category,
        serving_size=food.serving_size,
    )
    session.add(db_food)
    session.commit()
    session.refresh(db_food)
    return db_food


def remove_food(session: Session, food_id: int):
    session.query(models.Food).filter(models.Food.id == food_id).delete()
    session.commit()
    return food_id


def create_tray(session: Session, tray: schemas.TrayCreate, vendor_id: int):
    db_tray = models.Tray(**tray.dict(), vendor_id=vendor_id)
    session.add(db_tray)
    session.commit()
    session.refresh(db_tray)
    return db_tray


def remove_tray(session: Session, tray_id: int):
    session.query(models.Tray).filter(models.Tray.id == tray_id).delete()
    session.commit()
    return tray_id
