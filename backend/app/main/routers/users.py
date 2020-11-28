from datetime import timedelta
from functools import lru_cache

from jose import jwt, JWTError
from fastapi import APIRouter, Depends, HTTPException
from fastapi.security import OAuth2PasswordRequestForm, OAuth2PasswordBearer
from sqlalchemy.orm import Session
from starlette.responses import HTMLResponse
from starlette.status import HTTP_401_UNAUTHORIZED

from .. import crud, schemas, models
from ..database import SessionLocal

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

oauth2_scheme = OAuth2PasswordBearer(tokenUrl="token")


@router.get("/users/me", response_model=schemas.User)
async def get_current_user(
    session: Session = Depends(get_db),
    token: str = Depends(oauth2_scheme),
    settings: schemas.Settings = Depends(get_settings),
    ):
    credentials_exception = HTTPException(
        status_code=HTTP_401_UNAUTHORIZED,
        detail="Could not validate credentials",
        headers={"WWW-Authenticate": "Bearer"},
    )
    try:
        payload = jwt.decode(token, settings.secret_key, algorithms=settings.algorithm)
        username: str = payload.get("sub")
        if username is None:
            raise credentials_exception
        token_data = models.TokenData(username=username)
    except JWTError:
        raise credentials_exception
    user = crud.get_user(session, username=token_data.username)
    if user is None:
        raise credentials_exception
    return user