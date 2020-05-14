from passlib.context import CryptContext
from sqlalchemy.orm import Session

from . import models, schemas


def get_vendor_by_name(session: Session, name: str):
    return session.query(models.Vendor).filter(models.Vendor.name == name).first()


def get_vendor(session: Session, vendor_id: int):
    return session.query(models.Vendor).filter(models.Vendor.id == vendor_id).first()


def get_vendors(session: Session, skip: int = 0, limit: int = 100):
    return session.query(models.Vendor).offset(skip).limit(limit).all()


def get_vendor_by_id(session: Session, id: int):
    return session.query(models.Vendor).filter(models.Vendor.id == id).first()


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


def get_all_food(session: Session):
    return session.query(models.Food).all()


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


def create_food_collect(session: Session, food_collect: schemas.FoodCollectCreate):
    db_food_collect = models.FoodCollect(
        pickup_time=food_collect.pickup_time, vendor_id=food_collect.vendor_id,
    )
    session.add(db_food_collect)
    session.commit()
    session.refresh(db_food_collect)
    return db_food_collect


def remove_food_collect(session: Session, food_collect_id: int):
    session.query(models.FoodCollect).filter(
        models.FoodCollect.id == food_collect_id
    ).delete()
    session.commit()
    return food_collect_id


def get_food_collect(session: Session, food_collect_id: int):
    return (
        session.query(models.FoodCollect)
        .filter(models.FoodCollect.id == food_collect_id)
        .first()
    )


def get_all_food_collect(session: Session):
    return session.query(models.FoodCollect).all()


def update_food_collect(session: Session, food_collect: schemas.FoodCollect):
    session.query(models.FoodCollect).filter(
        models.FoodCollect.id == food_collect.id
    ).update(food_collect)
    session.commit()
    return food_collect


def get_user(session: Session, user_id: int):
    return session.query(models.User).filter(models.User.id == user_id).first()


pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")


def get_password_hash(password):
    return pwd_context.hash(password)


def create_user(session: Session, user: schemas.UserCreate):
    hashed_password = get_password_hash(user.password)
    db_user = models.User(
        name=user.name,
        username=user.username,
        password=hashed_password,
        is_vendor=user.is_vendor,
        disabled=user.disabled,
    )
    session.add(db_user)
    session.commit()
    session.refresh(db_user)
    return db_user


def remove_user(session: Session, user_id: int):
    session.query(models.User).filter(models.User.id == user_id).delete()
    session.commit()
    return user_id
