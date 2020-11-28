from datetime import timedelta
from functools import lru_cache

from fastapi import APIRouter, Depends, HTTPException
from fastapi.security import OAuth2PasswordRequestForm, OAuth2PasswordBearer
from sqlalchemy.orm import Session
from starlette.responses import HTMLResponse

from . import crud, schemas, models
from .database import SessionLocal

router = APIRouter()

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
