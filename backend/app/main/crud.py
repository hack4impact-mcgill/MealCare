from datetime import datetime, timedelta

import jwt
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


def create_food(session: Session, food: schemas.FoodCreate, food_collect_id: int):
    db_food = models.Food(
        name=food.name,
        weight=food.weight,
        date_produced=food.date_produced,
        expiry_date=food.expiry_date,
        description=food.description,
        category=food.category,
        serving_size=food.serving_size,
        food_collect_id=food_collect_id,
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


def create_tray(
    session: Session, tray: schemas.TrayCreate, vendor_id: int, food_collect_id: int
):
    db_tray = models.Tray(
        **tray.dict(), vendor_id=vendor_id, food_collect_id=food_collect_id
    )
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
    food_collect = (
        session.query(models.FoodCollect)
        .filter(models.FoodCollect.id == food_collect_id)
        .first()
    )
    session.commit()
    session.refresh(food_collect)
    return food_collect


def get_all_food_collect(session: Session):
    return session.query(models.FoodCollect).all()


def update_food_collect(session: Session, food_collect: schemas.FoodCollect):
    session.query(models.FoodCollect).filter(
        models.FoodCollect.id == food_collect.id
    ).update(food_collect)
    session.commit()
    return food_collect


def get_user_with_id(session: Session, user_id: int):
    return session.query(models.User).filter(models.User.id == user_id).first()


def get_user(session: Session, username: str):
    return session.query(models.User).filter(models.User.username == username).first()


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


def get_session_food_items(session: Session, food_collect_id: int):
    return (
        session.query(models.Food)
        .filter(models.Food.food_collect_id == food_collect_id)
        .all()
    )


def create_tray_collect(session: Session, tray_collect: schemas.TrayCollectCreate):
    db_tray_collect = models.TrayCollect(
        pickup_time=tray_collect.pickup_time, vendor_id=tray_collect.vendor_id,
    )
    session.add(db_tray_collect)
    session.commit()
    session.refresh(db_tray_collect)
    return db_tray_collect


def verify_password(plain_password, hashed_password):
    return pwd_context.verify(plain_password, hashed_password)


def authenticate_user(session: Session, username: str, password: str):
    user = get_user(session, username)
    if not user:
        return False
    if not verify_password(password, user.password):
        return False
    return user


def create_access_token(
    *, data: dict, expires_delta: timedelta = None, SECRET_KEY: str, ALGORITHM: str
):
    to_encode = data.copy()
    if expires_delta:
        expire = datetime.utcnow() + expires_delta
    else:
        expire = datetime.utcnow() + timedelta(minutes=15)
    to_encode.update({"exp": expire})
    encoded_jwt = jwt.encode(to_encode, SECRET_KEY, algorithm=ALGORITHM)
    return encoded_jwt
