import enum
from datetime import datetime

from sqlalchemy import (
    Boolean,
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

    # Foreign Keys
    food_collect_id = Column(Integer, ForeignKey("food_collects.id"))

    # Relationships
    food_collect = relationship("FoodCollect")


class Tray(Base):
    __tablename__ = "trays"

    id = Column(Integer, primary_key=True, index=True)
    type = Column(String)
    date_acquired = Column(DateTime, default=datetime.now())
    description = Column(String)

    # Foreign Keys
    vendor_id = Column(Integer, ForeignKey("vendors.id"))
    food_collect_id = Column(Integer, ForeignKey("food_collects.id"))
    tray_collect_id = Column(Integer, ForeignKey("tray_collects.id"))
    tray_return_id = Column(Integer, ForeignKey("tray_returns.id"))

    # Relationships
    vendor = relationship("Vendor", back_populates="trays")
    food_collect = relationship("FoodCollect")
    tray_collect = relationship("TrayCollect")
    tray_return = relationship("TrayReturn")


class FoodCollect(Base):
    __tablename__ = "food_collects"

    id = Column(Integer, primary_key=True, index=True)
    pickup_time = Column(DateTime, nullable=False)

    # Foreign keys
    vendor_id = Column(Integer, ForeignKey("vendors.id"))

    # Relationships
    vendor = relationship("Vendor")


class User(Base):
    __tablename__ = "users"

    id = Column(Integer, primary_key=True, index=True)
    name = Column(String)
    username = Column(String)
    password = Column(String)
    is_vendor = Column(Boolean)
    disabled = Column(Boolean)


class Token(Base):
    __tablename__ = "tokens"

    id = Column(Integer, primary_key=True, index=True)
    access_token = Column(String)
    token_type = Column(String)

class TokenData(Base):
    __tablename__ = "token_data"

    id = Column(Integer, primary_key=True, index=True)
    username = Column(String, nullable=True)


class TrayCollect(Base):
    __tablename__ = "tray_collects"

    id = Column(Integer, primary_key=True, index=True)
    pickup_time = Column(DateTime, nullable=False)

    # Foreign Keys
    vendor_id = Column(Integer, ForeignKey("vendors.id"))

    # Relationships
    trays = relationship("Tray")


class TrayReturn(Base):
    __tablename__ = "tray_returns"

    id = Column(Integer, primary_key=True, index=True)
    return_time = Column(DateTime, nullable=False)

    # Foreign Keys
    vendor_id = Column(Integer, ForeignKey("vendors.id"))

    # Relationships
    trays = relationship("Tray")
