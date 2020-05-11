import enum
from datetime import datetime

from sqlalchemy import (
    Column,
    Date,
    DateTime,
    Enum,
    ForeignKey,
    Integer,
    Numeric,
    String,
)
from sqlalchemy.orm import relationship

from .database import Base


class Vendor(Base):
    __tablename__ = "vendors"

    id = Column(Integer, primary_key=True, index=True)
    name = Column(String, unique=True)
    address = Column(String)
    city = Column(String)

    trays = relationship("Tray", back_populates="vendor")


class FoodEnum(enum.Enum):
    Vegetables = "Vegetables"
    Fruits = "Fruits"
    Grains = "Grains, Beans and Nuts"
    Meat = "Meat and Poultry"
    Seafood = "Fish and Seafood"
    Dairy = "Dairy Foods"


class Food(Base):
    __tablename__ = "foods"

    id = Column(Integer, primary_key=True, index=True)
    name = Column(String, index=True, nullable=False)
    weight = Column(Numeric, nullable=False)
    date_produced = Column(Date, nullable=False)
    expiry_date = Column(Date)
    description = Column(String)
    category = Column(Enum(FoodEnum), nullable=False)
    serving_size = Column(String)


class Tray(Base):
    __tablename__ = "trays"

    id = Column(Integer, primary_key=True, index=True)
    type = Column(String)
    date_acquired = Column(DateTime, default=datetime.now())
    vendor_id = Column(Integer, ForeignKey("vendors.id"))
    description = Column(String)

    vendor = relationship("Vendor", back_populates="trays")
    # Relationships
    food_collect = relationship("FoodCollect")

    # Foreign keys
    food_collect_id = Column(Integer, ForeignKey("food_collects.id"))


class FoodCollect(Base):
    __tablename__ = "food_collects"

    id = Column(Integer, primary_key=True, index=True)
    pickup_time = Column(DateTime, nullable=False)

    # Foreign keys
    vendor_id = Column(Integer, ForeignKey("vendors.id"))

    # Relationships
    vendor = relationship("Vendor")
