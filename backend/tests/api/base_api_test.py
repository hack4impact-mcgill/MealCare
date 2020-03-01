import unittest
from app import create_app
from starlette.testclient import TestClient


class BasicApiTestCase(unittest.TestCase):

    def setUp(self):
        self.app = TestClient(create_app("testing"))

    def tearDown(self):
        self.app = None
