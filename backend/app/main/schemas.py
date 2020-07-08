from datetime import date, datetime
from typing import List

from pydantic import BaseModel, BaseSettings

from .models import FoodEnum


class Settings(BaseSettings):
    secret_key: str
    algorithm: str

    class Config:
        env_file = ".env"


class TrayBase(BaseModel):
    type: str
    date_acquired: datetime = datetime.now
    description: str = ""
    tray_collect_id: int
    tray_return_id: int


class TrayCreate(TrayBase):
    pass


class Tray(TrayBase):
    id: int
    vendor_id: int
    food_collect_id: int

    class Config:
        orm_mode = True


class VendorBase(BaseModel):
    name: str
    address: str
    city: str


class VendorCreate(VendorBase):
    pass


class Vendor(VendorBase):
    id: int
    trays: List[Tray] = []

    class Config:
        orm_mode = True


class FoodBase(BaseModel):
    name: str
    weight: float
    date_produced: date
    expiry_date: date = None
    description: str = ""
    category: FoodEnum
    serving_size: str = ""


class FoodCreate(FoodBase):
    pass


class Food(FoodBase):
    id: int
    food_collect_id: int

    class Config:
        orm_mode = True


class FoodCollectBase(BaseModel):
    pickup_time: datetime
    vendor_id: int


class FoodCollectCreate(FoodCollectBase):
    pass


class FoodCollect(FoodCollectBase):
    id: int

    class Config:
        orm_mode = True


class UserBase(BaseModel):
    name: str
    username: str
    password: str
    is_vendor: bool
    disabled: bool = True


class UserCreate(UserBase):
    pass


class User(UserBase):
    id: int

    class Config:
        orm_mode = True


class TokenBase(BaseModel):
    access_token: str
    token_type: str


class Token(TokenBase):
    id: int

    class Config:
        orm_mode = True


class TrayCollectBase(BaseModel):
    pickup_time: datetime
    vendor_id: int


class TrayCollectCreate(TrayCollectBase):
    pass


class TrayCollect(TrayCollectBase):
    id: int
    trays: List[Tray] = []

    class Config:
        orm_mode = True


class TrayReturnBase(BaseModel):
    return_time: datetime
    vendor_id: int


class TrayReturnCreate(TrayReturnBase):
    pass


class TrayReturn(TrayReturnBase):
    id: int
    trays: List[Tray] = []

    class Config:
        orm_mode = True
