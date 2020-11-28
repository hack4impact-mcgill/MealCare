from fastapi import FastAPI

from app.main import models
from app.main.database import engine
from config import config


def create_app(config_name):
    """
    This will create an instance of FastAPI with the specified routers

    :param config_name: Setup the config name
    :return: A FastAPI Instance
    """

    models.Base.metadata.create_all(bind=engine)

    # TODO: Setup proper configurations
    app_config = config[config_name]
    app = FastAPI(
        title=app_config.title,
        description=app_config.description,
        version=app_config.version,
        debug=app_config.debug,
    )

    # TODO: Get the router from the main file and other files later on
    from app.main import main
    from app.main.routers import food, food_collect, vendors, session, trays, users

    app.include_router(main.router)
    app.include_router(food.router)
    app.include_router(food_collect.router)
    app.include_router(vendors.router)
    app.include_router(session.router)
    app.include_router(trays.router)
    app.include_router(users.router)

    return app
