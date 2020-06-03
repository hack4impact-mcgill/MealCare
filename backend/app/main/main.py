from datetime import timedelta
from functools import lru_cache
from typing import List

from fastapi import Depends, FastAPI, HTTPException
from fastapi.security import OAuth2PasswordRequestForm
from sqlalchemy.orm import Session
from starlette.responses import HTMLResponse
from starlette.status import HTTP_401_UNAUTHORIZED

from . import crud, schemas
from .database import SessionLocal

# APIRouter is equivalent to Flask's blueprint
# It allows us to extend FastAPI Routes
# changed APIRouter to FastAPI for auth purposes -- TODO: restructure this file to include APIRouter later
router = FastAPI()
ACCESS_TOKEN_EXPIRE_MINUTES = 30


def get_db():
    try:
        db = SessionLocal()
        yield db
    finally:
        db.close()


@lru_cache()
def get_settings():
    return schemas.Settings()


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
    {
        "id": "int"
    } 
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
        "decription":"str"
        "tray_collect_id":"int",
    }

    :return: JSON response with created entry
    """
    return crud.create_tray(
        session=session, tray=tray, vendor_id=vendor_id, food_collect_id=food_collect_id
    )


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


@router.post("/add_user", response_model=schemas.User)
def create_user(user: schemas.UserCreate, session: Session = Depends(get_db)):
    """
    Adds a new user to the database - MealCare

    :body:
    {
        "name":"str",
        "username":"str",
        "password":"str",
        "is_vendor":"bool",
        "disabled":"bool"
    }

    :return: JSON response with created entry
    """
    return crud.create_user(session=session, user=user)


@router.post("/token")
async def login_for_access_token(
    session: Session = Depends(get_db),
    form_data: OAuth2PasswordRequestForm = Depends(),
    settings: schemas.Settings = Depends(get_settings),
):
    user = crud.authenticate_user(session, form_data.username, form_data.password)
    if not user:
        raise HTTPException(
            status_code=HTTP_401_UNAUTHORIZED,
            detail="Incorrect username or password",
            headers={"WWW-Authenticate": "Bearer"},
        )
    access_token_expires = timedelta(minutes=ACCESS_TOKEN_EXPIRE_MINUTES)
    access_token = crud.create_access_token(
        data={"sub": user.username},
        expires_delta=access_token_expires,
        SECRET_KEY=settings.secret_key,
        ALGORITHM=settings.algorithm,
    )
    return {"access_token": access_token, "token_type": "bearer"}


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
        db_session_food = crud.create_food(
            session=session, food=food, food_collect_id=food_collect_id
        )
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
