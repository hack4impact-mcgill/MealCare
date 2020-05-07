from sqlalchemy.orm import Session

from . import models, schemas


def get_vendor_by_name(session: Session, name: str):
    return session.query(models.Vendor).filter(models.Vendor.name == name).first()


def create_vendor(session: Session, vendor: schemas.VendorCreate):
    db_vendor = models.Vendor(
        name=vendor.name, address=vendor.address, city=vendor.city
    )
    session.add(db_vendor)
    session.commit()
    session.refresh(db_vendor)
    return db_vendor
