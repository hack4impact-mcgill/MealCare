from datetime import date
from decimal import Decimal
from enum import Enum

from pony.orm import Database, Optional, Required, db_session
from pony.orm.dbapiprovider import StrConverter


# ENUM CATEGORY
class Category(Enum):
    Vegetables = "Vegetables"
    Fruits = "Fruits"
    Grains = "Grains, Beans and Nuts"
    Meat = "Meat and Poultry"
    Seafood = "Fish and Seafood"
    Dairy = "Dairy Foods"


# ENUM CONVERTER
# Used in order to integrate Enum datatypes to ponyorm
class EnumConverter(StrConverter):
    def validate(self, val, obj=None):
        if not isinstance(val, Enum):
            raise ValueError("Must be an Enum.  Got {}".format(type(val)))
        return val

    def py2sql(self, val):
        return val.value

    def sql2py(self, value):
        return self.py_type[value]


# DATABASE INITIALIZATION
# Example function on how to create a db and to connect using pony.orm
def get_db():
    db = Database()
    db.bind(
        provider="postgres",
        user="mealadmin",
        password="happymeal",
        host="127.0.0.1",
        database="mealcare_dev",
    )
    db.provider.converter_classes.append((Enum, EnumConverter))
    return db


# Initialize the Database Object
db = get_db()


# MODELS
class Vendor(db.Entity):
    name = Required(str)
    address = Required(str)
    city = Required(str)


class Food(db.Entity):
    name = Required(str)
    weight = Required(Decimal)
    date_produced = Required(date)
    expiry_date = Optional(date)
    description = Optional(str)
    category = Required(Category)
    serving_size = Optional(str)


# GENERATE MAPPING
db.generate_mapping(create_tables=True)


# INSERTIONS
@db_session
def create_vendor(vendor):
    Vendor(name=vendor.name, address=vendor.address, city=vendor.city)


@db_session
def create_food(food):
    Food(
        name=food.name,
        weight=food.weight,
        date_produced=food.date_produced,
        expiry_date=food.expiry_date,
        description=food.description,
        category=Category[food.category],
        serving_size=food.serving_size,
    )
