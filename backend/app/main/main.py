from datetime import timedelta
from functools import lru_cache

from fastapi import APIRouter, Depends, HTTPException
from fastapi.security import OAuth2PasswordRequestForm
from sqlalchemy.orm import Session
from starlette.responses import HTMLResponse
from starlette.status import HTTP_401_UNAUTHORIZED

from . import crud, schemas
from .database import SessionLocal

router = APIRouter()
ACCESS_TOKEN_EXPIRE_MINUTES = 30


@lru_cache()
def get_settings():
    return schemas.Settings()


def get_db():
    try:
        db = SessionLocal()
        yield db
    finally:
        db.close()


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
    </pre>                                                                              """
    return HTMLResponse(title)


@router.get("/health")
def health():
    """
    Displays a health check
    :return: HTMLResponse - MealCare
    """
    health = "healthy"
    return HTMLResponse(health)


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
