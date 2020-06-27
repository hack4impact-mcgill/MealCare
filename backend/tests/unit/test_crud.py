import os

from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker

from app.main import crud, models, schemas
from app.main.database import Base
from tests.api.base_api_test import BasicApiTestCase

SQLALCHEMY_DATABASE_URL = os.getenv("SQLALCHEMY_DATABASE_URL")

engine = create_engine(SQLALCHEMY_DATABASE_URL)

TestingSessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)

Base.metadata.create_all(bind=engine)


def get_db():
    try:
        db = TestingSessionLocal()
        yield db
    finally:
        db.close()


class CrudTest(BasicApiTestCase):
    def setUp(self):
        # connect to the database
        self.connection = engine.connect()

        # begin a non-ORM transaction
        self.trans = self.connection.begin()

        # bind an individual Session to the connection
        self.session = TestingSessionLocal(bind=self.connection)

    def tearDown(self):
        self.session.close()

        # rollback - everything that happened with the
        # Session above (including calls to commit())
        # is rolled back.
        self.trans.rollback()

        # return connection to the Engine
        self.connection.close()

    def test_create_vendor(self):
        vendor_schema = schemas.VendorCreate(
            name="Kims222", address="166 st.cat", city="Montreal"
        )
        vendor = crud.create_vendor(self.session, vendor_schema)
        assert (
            vendor
            == self.session.query(models.Vendor)
            .filter(models.Vendor.name == vendor.name)
            .first()
        )

    def test_get_vendor(self):
        # test get_vendor_by_id
        vendor_schema = schemas.VendorCreate(
            name="Lee", address="123 st.cat", city="Montreal"
        )
        vendor = crud.create_vendor(self.session, vendor_schema)
        vendor_found = crud.get_vendor(self.session, vendor.id)
        assert vendor_found == vendor

        # test get_vendor_by_name
        vendor_found = crud.get_vendor_by_name(self.session, vendor.name)
        assert vendor_found == vendor

        # test get_vendors
        vendor2_schema = schemas.VendorCreate(
            name="Park", address="256 st.Mathieu", city="Montreal"
        )
        vendor2 = crud.create_vendor(self.session, vendor2_schema)
        vendors_found = crud.get_vendors(self.session)
        assert vendor in vendors_found
        assert vendor2 in vendors_found

    def test_remove_vendor(self):
        vendor_schema = schemas.VendorCreate(
            name="Choi", address="155 st.cat", city="Montreal"
        )
        vendor = crud.create_vendor(self.session, vendor_schema)
        crud.remove_vendor(self.session, vendor.id)
        q = self.session.query(models.Vendor).filter(models.Vendor.id == vendor.id)
        assert not self.session.query(q.exists()).scalar()

    def test_create_food_collect(self):
        vendor_schema = schemas.VendorCreate(
            name="James", address="155 st.pat", city="Montreal"
        )
        vendor = crud.create_vendor(self.session, vendor_schema)
        food_collect_schema = schemas.FoodCollectCreate(
            pickup_time="2020-11-08 11:11:51.291273", vendor_id=vendor.id,
        )
        food_collect = crud.create_food_collect(self.session, food_collect_schema)
        assert (
            food_collect
            == self.session.query(models.FoodCollect)
            .filter(models.FoodCollect.id == food_collect.id)
            .first()
        )

    def test_get_food_collect(self):
        # test get_food_collect
        vendor_schema = schemas.VendorCreate(
            name="Lee", address="123 st.cat", city="Montreal"
        )
        vendor = crud.create_vendor(self.session, vendor_schema)
        food_collect_schema = schemas.FoodCollectCreate(
            pickup_time="2020-10-08 11:11:51.291273", vendor_id=vendor.id,
        )
        food_collect = crud.create_food_collect(self.session, food_collect_schema)
        food_collect_found = crud.get_food_collect(self.session, food_collect.id)
        assert food_collect_found == food_collect

        # test get_all_food_collect
        vendor2_schema = schemas.VendorCreate(
            name="Park", address="256 st.Mathieu", city="Montreal"
        )
        vendor2 = crud.create_vendor(self.session, vendor2_schema)
        food_collect2_schema = schemas.FoodCollectCreate(
            pickup_time="2020-10-04 11:11:51.291273", vendor_id=vendor2.id,
        )
        food_collect2 = crud.create_food_collect(self.session, food_collect2_schema)
        food_collects_found = crud.get_all_food_collect(self.session)
        assert food_collect in food_collects_found
        assert food_collect2 in food_collects_found

    def test_remove_food_collect(self):
        vendor_schema = schemas.VendorCreate(
            name="Choi", address="155 st.cat", city="Montreal"
        )
        vendor = crud.create_vendor(self.session, vendor_schema)
        food_collect_schema = schemas.FoodCollectCreate(
            pickup_time="2020-05-08 11:11:51.291273", vendor_id=vendor.id,
        )
        food_collect = crud.create_food_collect(self.session, food_collect_schema)
        crud.remove_food_collect(self.session, food_collect.id)
        q = self.session.query(models.FoodCollect).filter(
            models.FoodCollect.id == food_collect.id
        )
        assert not self.session.query(q.exists()).scalar()

    def test_update_food_collect(self):
        vendor_schema = schemas.VendorCreate(
            name="Jackson", address="155 clark", city="Montreal"
        )
        vendor = crud.create_vendor(self.session, vendor_schema)
        food_collect_schema = schemas.FoodCollectCreate(
            pickup_time="2020-05-08 11:11:51.291273", vendor_id=vendor.id,
        )
        food_collect = crud.create_food_collect(self.session, food_collect_schema)
        new_food_collect_schema = schemas.FoodCollect(
            pickup_time="2018-12-12 12:12:12.121212",
            vendor_id=vendor.id,
            id=food_collect.id,
        )
        new = crud.update_food_collect(self.session, new_food_collect_schema)
        assert new.pickup_time == new_food_collect_schema.pickup_time

    def test_create_food(self):
        vendor_schema = schemas.VendorCreate(
            name="James", address="155 st.pat", city="Montreal"
        )
        vendor = crud.create_vendor(self.session, vendor_schema)
        food_collect_schema = schemas.FoodCollectCreate(
            pickup_time="2020-11-08 11:11:51.291273", vendor_id=vendor.id,
        )
        food_collect = crud.create_food_collect(self.session, food_collect_schema)
        food_schema = schemas.FoodCreate(
            name="Pepperoni pizza",
            weight=502,
            date_produced="2020-03-11",
            expiry_date="2023-04-12",
            description="The best pizza in town",
            category="Grains, Beans and Nuts",
            serving_size="4",
        )
        food = crud.create_food(self.session, food_schema, food_collect.id)
        assert (
            food
            == self.session.query(models.Food).filter(models.Food.id == food.id).first()
        )

    def test_get_food(self):

        # test get_all_food_collecti
        vendor_schema = schemas.VendorCreate(
            name="James", address="155 st.pat", city="Montreal"
        )
        vendor = crud.create_vendor(self.session, vendor_schema)
        food_collect_schema = schemas.FoodCollectCreate(
            pickup_time="2020-10-08 11:11:51.291273", vendor_id=vendor.id,
        )
        food_collect = crud.create_food_collect(self.session, food_collect_schema)
        food_schema = schemas.FoodCreate(
            name="Pepperoni pizza",
            weight=502,
            date_produced="2020-03-11",
            expiry_date="2023-04-12",
            description="The best pizza in town",
            category="Grains, Beans and Nuts",
            serving_size="4",
        )
        food = crud.create_food(self.session, food_schema, food_collect.id)
        vendor2_schema = schemas.VendorCreate(
            name="Park", address="256 st.Mathieu", city="Montreal"
        )
        vendor2 = crud.create_vendor(self.session, vendor2_schema)
        food_collect2_schema = schemas.FoodCollectCreate(
            pickup_time="2020-10-04 11:11:51.291273", vendor_id=vendor2.id,
        )
        food_collect2 = crud.create_food_collect(self.session, food_collect2_schema)
        food2_schema = schemas.FoodCreate(
            name="Hawaiian pizza",
            weight=1000,
            date_produced="2020-03-11",
            expiry_date="2023-04-12",
            description="The second best pizza in town",
            category="Grains, Beans and Nuts",
            serving_size="4",
        )
        food2 = crud.create_food(self.session, food2_schema, food_collect2.id)
        foods_found = crud.get_all_food(self.session)
        assert food in foods_found
        assert food2 in foods_found

    def test_remove_food(self):
        vendor_schema = schemas.VendorCreate(
            name="Choi", address="155 st.cat", city="Montreal"
        )
        vendor = crud.create_vendor(self.session, vendor_schema)
        food_collect_schema = schemas.FoodCollectCreate(
            pickup_time="2020-05-08 11:11:51.291273", vendor_id=vendor.id,
        )
        food_collect = crud.create_food_collect(self.session, food_collect_schema)
        food_schema = schemas.FoodCreate(
            name="Pepperoni pizza",
            weight=502,
            date_produced="2020-03-11",
            expiry_date="2023-04-12",
            description="The best pizza in town",
            category="Grains, Beans and Nuts",
            serving_size="4",
        )
        food = crud.create_food(self.session, food_schema, food_collect.id)
        crud.remove_food(self.session, food.id)
        q = self.session.query(models.Food).filter(models.Food.id == food.id)
        assert not self.session.query(q.exists()).scalar()

    def test_create_user(self):
        user_schema = schemas.UserCreate(
            name="geoff", username="test", password="password", is_vendor="false"
        )
        user = crud.create_user(self.session, user_schema)

        assert (
            user
            == self.session.query(models.User)
            .filter(models.User.username == user_schema.username)
            .first()
        )

    def test_remove_user(self):
        user_schema = schemas.UserCreate(
            name="geoff",
            username="test456",
            password="thisispassword",
            is_vendor="false",
        )
        user = crud.create_user(self.session, user_schema)
        crud.remove_user(self.session, user.id)
        q = self.session.query(models.User).filter(models.User.id == user.id)
        assert not self.session.query(q.exists()).scalar()

    def test_authenticate_user(self):
        user_schema = schemas.UserCreate(
            name="geoff",
            username="test123",
            password="yesthisispassword",
            is_vendor="false",
        )
        user = crud.create_user(self.session, user_schema)
        assert crud.authenticate_user(self.session, user.username, user_schema.password)
        assert not crud.authenticate_user(self.session, "Test123", user_schema.password)
        assert not crud.authenticate_user(self.session, "Test123", "test")

    def test_create_tray_collect(self):
        vendor_schema = schemas.VendorCreate(
            name="Johnson", address="125 st.cat", city="Montreal"
        )
        vendor = crud.create_vendor(self.session, vendor_schema)
        tray_collect_schema = schemas.TrayCollectCreate(
            pickup_time="2020-10-11 11:11:51.291273", vendor_id=vendor.id,
        )
        tray_collect = crud.create_tray_collect(self.session, tray_collect_schema)
        assert (
            tray_collect
            == self.session.query(models.TrayCollect)
            .filter(models.TrayCollect.id == tray_collect.id)
            .first()
        )

    def test_create_tray_return(self):
        vendor_schema = schemas.VendorCreate(
            name="Jackson", address="325 st.cat", city="Montreal"
        )
        vendor = crud.create_vendor(self.session, vendor_schema)
        tray_return_schema = schemas.TrayReturnCreate(
            return_time="2020-10-11 11:11:51.291273", vendor_id=vendor.id,
        )
        tray_return = crud.create_tray_return(self.session, tray_return_schema)
        assert (
            tray_return
            == self.session.query(models.TrayReturn)
            .filter(models.TrayReturn.id == tray_return.id)
            .first()
        )

    def test_create_tray(self):
        vendor_schema = schemas.VendorCreate(
            name="Bai", address="325 Mackay", city="Montreal"
        )
        vendor = crud.create_vendor(self.session, vendor_schema)
        food_collect_schema = schemas.FoodCollectCreate(
            pickup_time="2020-02-08 11:11:51.291273", vendor_id=vendor.id,
        )
        food_collect = crud.create_food_collect(self.session, food_collect_schema)
        tray_collect_schema = schemas.TrayCollectCreate(
            pickup_time="2020-10-11 11:11:51.291273", vendor_id=vendor.id,
        )
        tray_collect = crud.create_tray_collect(self.session, tray_collect_schema)
        tray_return_schema = schemas.TrayReturnCreate(
            return_time="2020-10-11 12:12:51.291273", vendor_id=vendor.id,
        )
        tray_return = crud.create_tray_return(self.session, tray_return_schema)
        tray_schema = schemas.TrayCreate(
            type="metal",
            date_acquired="2020-05-09 22:56:51.291273",
            description="from the pizza",
            tray_collect_id=tray_collect.id,
            tray_return_id=tray_return.id,
        )
        tray = crud.create_tray(self.session, tray_schema, vendor.id, food_collect.id)
        assert (
            tray
            == self.session.query(models.Tray).filter(models.Tray.id == tray.id).first()
        )

    def test_remove_tray(self):
        vendor_schema = schemas.VendorCreate(
            name="Bai", address="325 Mackay", city="Montreal"
        )
        vendor = crud.create_vendor(self.session, vendor_schema)
        food_collect_schema = schemas.FoodCollectCreate(
            pickup_time="2020-02-08 11:11:51.291273", vendor_id=vendor.id,
        )
        food_collect = crud.create_food_collect(self.session, food_collect_schema)
        tray_collect_schema = schemas.TrayCollectCreate(
            pickup_time="2020-10-11 11:11:51.291273", vendor_id=vendor.id,
        )
        tray_collect = crud.create_tray_collect(self.session, tray_collect_schema)
        tray_return_schema = schemas.TrayReturnCreate(
            return_time="2020-10-11 12:12:51.291273", vendor_id=vendor.id,
        )
        tray_return = crud.create_tray_return(self.session, tray_return_schema)
        tray_schema = schemas.TrayCreate(
            type="metal",
            date_acquired="2020-05-29 22:56:51.291273",
            description="from the cheese",
            tray_collect_id=tray_collect.id,
            tray_return_id=tray_return.id,
        )
        tray = crud.create_tray(self.session, tray_schema, vendor.id, food_collect.id)
        crud.remove_tray(self.session, tray.id)
        q = self.session.query(models.Tray).filter(models.Tray.id == tray.id)
        assert not self.session.query(q.exists()).scalar()
