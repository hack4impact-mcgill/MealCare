from pydantic import BaseModel


class VendorBase(BaseModel):
    name: str
    address: str
    city: str


class VendorCreate(VendorBase):
    pass


class Vendor(VendorBase):
    id: int

    class Config:
        orm_mode = True
