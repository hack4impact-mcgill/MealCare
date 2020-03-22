import os

import uvicorn

from app import create_app

# Import settings from .env file
if os.path.exists(".env"):
    print("Importing environment from .env file")
    for line in open(".env"):
        var = line.strip().split("=")
        if len(var) == 2:
            os.environ[var[0]] = var[1]

# Get the mode
mode = os.getenv("FAST_API_CONFIG") or "development"
app = create_app(mode)


# Runs the tests
def test():
    """
     Run the tests

    """
    import unittest

    api_tests = unittest.TestLoader().discover("./tests/api")
    unittest.TextTestRunner(verbosity=2).run(api_tests)

    int_tests = unittest.TestLoader().discover("./tests/integrations")
    unittest.TextTestRunner(verbosity=2).run(int_tests)

    unit_tests = unittest.TestLoader().discover("./tests/unit")
    unittest.TextTestRunner(verbosity=2).run(unit_tests)


# Setup to run the app in debug mode
if __name__ == "__main__":
    if mode == "development":
        uvicorn.run(app, host="127.0.0.1", port=8000)
    elif mode == "testing":
        test()
