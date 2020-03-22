import unittest

from starlette.testclient import TestClient

from app import create_app


class BasicApiTestCase(unittest.TestCase):
    def setUp(self):
        self.app = TestClient(create_app("testing"))

    def tearDown(self):
        self.app = None
