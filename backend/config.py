# Define the configurations of the app

import os

basedir = os.path.abspath(os.path.dirname(__file__))


class Config:
    title = "MealCare"
    description = "A food tracking app"
    version = "0.0.1"
    debug = False

    @staticmethod
    def init_app(app):
        pass


class DevelopmentConfig(Config):
    debug = True


class TestingConfig(Config):
    pass


class ProductionConfig(Config):
    pass


config = {
    "development": Config,
    "testing": Config,
    "production": Config,
    "default": Config,
}
