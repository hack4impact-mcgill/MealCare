from sqlalchemy.orm import Session

from . import models, schemas


def get_vendor_by_name(session: Session, name: str):
    return session.query(models.Vendor).filter(models.Vendor.name == name).first()


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
