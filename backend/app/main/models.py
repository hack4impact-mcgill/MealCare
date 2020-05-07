import enum

from sqlalchemy import Column, Date, Enum, Integer, Numeric, String

from .database import Base


class Vendor(Base):
    __tablename__ = "vendors"

    id = Column(Integer, primary_key=True, index=True)
    name = Column(String, unique=True)
    address = Column(String)
    city = Column(String)


class FoodEnum(enum.Enum):
    Vegetables = "Vegetables"
    Fruits = "Fruits"
    Grains = "Grains, Beans and Nuts"
    Meat = "Meat and Poultry"
    Seafood = "Fish and Seafood"
    Dairy = "Dairy Foods"


class Food(Base):
    __tablename__ = "food"

    id = Column(Integer, primary_key=True, index=True)
    name = Column(String)
    weight = Column(Numeric)
    date_produced = Column(Date)
    expiry_date = Column(Date)
    description = Column(String)
    category = Column(Enum(FoodEnum))
    serving_size = Column(String)
