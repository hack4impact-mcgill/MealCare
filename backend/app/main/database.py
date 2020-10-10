import os

import sqlalchemy

# Import the Secret Manager client library.
from google.cloud import secretmanager
from sqlalchemy import create_engine
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker

mode = os.getenv("DEPLOY_MODE", "LOCAL")
engine = None
print(mode)
if mode == "GCP":
    # Create the Secret Manager client.
    client = secretmanager.SecretManagerServiceClient()

    # Build the resource name of the secret version.
    name = client.secret_version_path("fastapi-demo-286421", "my-secret", 2)

    # Access the secret version.
    response = client.access_secret_version(name)

    payload = response.payload.data.decode("UTF-8")
    # Remember - storing secrets in plaintext is potentially unsafe. Consider using
    # something like https://cloud.google.com/secret-manager/docs/overview to help keep
    # secrets secret.
    db_user = "mealadmin"
    db_pass = payload
    db_name = "mealcare_dev"
    db_socket_dir = os.environ.get("DB_SOCKET_DIR", "/cloudsql")
    cloud_sql_connection_name = "fastapi-demo-286421:us-east1:mealcare-dev"

    engine = sqlalchemy.create_engine(
        # Equivalent URL:
        # postgres+pg8000://<db_user>:<db_pass>@/<db_name>
        #                         ?unix_sock=<socket_path>/<cloud_sql_instance_name>/.s.PGSQL.5432
        sqlalchemy.engine.url.URL(
            drivername="postgres+pg8000",
            username=db_user,  # e.g. "my-database-user"
            password=db_pass,  # e.g. "my-database-password"
            database=db_name,  # e.g. "my-database-name"
            query={
                "unix_sock": "{}/{}/.s.PGSQL.5432".format(
                    db_socket_dir, cloud_sql_connection_name  # e.g. "/cloudsql"
                )  # i.e "<PROJECT-NAME>:<INSTANCE-REGION>:<INSTANCE-NAME>"
            },
        ),
        # ... Specify additional properties here.
    )
else:
    SQLALCHEMY_DATABASE_URL = "postgresql://mealadmin:happymeal@localhost/mealcare_dev"

    engine = create_engine(SQLALCHEMY_DATABASE_URL)
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)

Base = declarative_base()
