from tests.api.base_api_test import BasicApiTestCase


class MainTest(BasicApiTestCase):

    def test_main(self):
        response = self.app.get('/')
        assert response.status_code == 200

    def test_health_check(self):
        response = self.app.get('/health')
        assert response.status_code == 200
        assert "healthy" in str(response.content)

