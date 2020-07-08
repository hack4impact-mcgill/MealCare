from fastapi import FastAPI
from starlette.middleware.cors import CORSMiddleware

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

    origins = [
        "http://localhost:8080",
        "http://localhost",
        "http://192.168.50.37:8080/",
    ]

    app.add_middleware(
        CORSMiddleware,
        allow_origins=origins,
        allow_credentials=True,
        allow_methods=["*"],
        allow_headers=["*"],
    )

    # TODO: Get the router from the main file and other files later on
    from app.main import main
    from app.main.routers import food, food_collect, vendors, session, trays

    app.include_router(main.router)
    app.include_router(food.router)
    app.include_router(food_collect.router)
    app.include_router(vendors.router)
    app.include_router(session.router)
    app.include_router(trays.router)

    return app
