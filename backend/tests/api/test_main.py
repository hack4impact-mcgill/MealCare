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

    # def test_food(self):
    #     payload = {
    #         "name": "Pineapple pizza",
    #         "weight": 500,
    #         "date_produced": "2020-03-11",
    #         "expiry_date": "2021-04-12",
    #         "description": "The best pizza in town",
    #         "category": "Grains",
    #         "serving_size": "4",
    #     }
    #     response = self.app.post("/add_food", json=payload)
    #     assert response.status_code == 200
    #     assert response.json() == {
    #         "name": "Pineapple pizza",
    #         "weight": 500,
    #         "date_produced": "2020-03-11",
    #         "expiry_date": "2021-04-12",
    #         "description": "The best pizza in town",
    #         "category": "Grains",
    #         "serving_size": "4",
    #     }
