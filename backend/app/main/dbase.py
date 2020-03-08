from pony.orm import *

# DATABASE INITIALIZATION
# Example function on how to create a db and to connect using pony.orm
def get_db():
    db = Database()
    db.bind(provider="postgres",
            user='mealadmin',
            password='happymeal',
            host='127.0.0.1',
            database='mealcare_dev')
    return db


# Initialize the Database Object
db = get_db()

# MODELS
class Vendor(db.Entity):
    name = Required(str)
    address = Required(str)


# GENERATE MAPPING
db.generate_mapping(create_tables=True)


# INSERTIONS
@db_session
def create_vendor(n, a):
    v = Vendor(name=n, address=a)
