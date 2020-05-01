from fastapi import FastAPI

from config import config


def create_app(config_name):
    """
    This will create an instance of FastAPI with the specified routers

    :param config_name: Setup the config name
    :return: A FastAPI Instance
    """

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

    app.include_router(main.router)

    return app
