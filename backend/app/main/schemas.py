from datetime import date

from pydantic import BaseModel

from .models import FoodEnum


class VendorBase(BaseModel):
    name: str
    address: str
    city: str


class VendorCreate(VendorBase):
    pass


class Vendor(VendorBase):
    id: int

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

    class Config:
        orm_mode = True
