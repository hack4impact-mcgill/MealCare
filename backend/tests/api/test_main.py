import json

from tests.api.base_api_test import BasicApiTestCase


class MainTest(BasicApiTestCase):
    def test_main(self):
        response = self.app.get("/")
        assert response.status_code == 200

    def test_health_check(self):
        response = self.app.get("/health")
        assert response.status_code == 200
        assert "healthy" in str(response.content)

    # TODO: add a test_create_vendor to test database entry creation

    def test_vendor(self):
        payload = {
            "name": "Ratatouille",
            "address": "2007 Pixar Avenue",
            "city": "Paris",
        }
        response = self.app.post("/add_vendor", json=payload)
        assert response.status_code == 200

        # TODO: remove entry from db

    def test_food(self):
        payload = {
            "name": "Pineapple pizza",
            "weight": 500,
            "date_produced": "2020-03-11",
            "expiry_date": "2021-04-12",
            "description": "The best pizza in town",
            "category": "Grains, Beans and Nuts",
            "serving_size": "4",
        }
        response = self.app.post("/add_food", json=payload)
        assert response.status_code == 200

        # TODO: remove entry from db

    def test_remove_food(self):

        add_food_payload = {
            "name": "ratata",
            "weight": 123,
            "date_produced": "2020-05-10",
            "expiry_date": "2025-05-10",
            "decription": "victory hw",
            "category": "Vegetables",
            "serving_size": "1",
        }
        response = self.app.post("/add_food", json=add_food_payload)

        all_food = self.app.get("/get_all_food")

        data = json.loads(all_food.content)
        last = len(data) - 1
        food_id = data[last]["id"]
        route = "/remove_food/{0}".format(str(food_id))
        response = self.app.delete(route)
        assert response.status_code == 200

    def test_vendors_tray(self):
        payload = {
            "type": "metal",
            "date_acquired": "2020-05-09 22:56:51.291273",
            "description": "from the pizza",
        }
        response = self.app.post("/vendors/1/add_tray", json=payload)
        assert response.status_code == 200

        # TODO remove entry from db

    def test_create_food_collect(self):
        # Add a vendor first
        vendor = {
            "name": "ratata",
            "address": "victory road",
            "city": "sinnoh",
        }
        response = self.app.post("/add_vendor", json=vendor)

        payload = {
            "pickup_time": "2020-10-08 11:11:51.291273",
            "vendor_id": 1,
        }
        response = self.app.post("/add_food_collect", json=payload)
        assert response.status_code == 200

    def test_get_food_collect(self):
        response = self.app.get("/get_food_collect/1")
        assert response.status_code == 200

    def test_get_all_food_collect(self):
        response = self.app.get("/get_all_food_collect")
        assert response.status_code == 200

    # TODO: test it after having a test db with data
    # def test_update_food_collect(self):
    #     payload = {
    #         "pickup_time": "2030-04-01T11:11",
    #         "vendor_id": 1,
    #         "id": 1,
    #     }
    #     response = self.app.put("/update_food_collect", json=payload)
    #     assert response.status_code == 200

    # def test_remove_food_collect(self):
    #     response = self.app.delete("/remove_food_collect/1")
    #     assert response.status_code == 200
