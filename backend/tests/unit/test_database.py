import unittest

import psycopg2
from pony.orm import Database


class DatabaseTest(unittest.TestCase):
    def setUp(self):
        self.db = Database()

    def tearDown(self):
        self.db = None

    def test_database_connection(self):
        try:
            self.db.bind(
                provider="postgres",
                user="mealadmin",
                password="happymeal",
                host="127.0.0.1",
                database="mealcare_dev",
            )
        except (Exception, psycopg2.Error) as error:
            self.fail(error)
