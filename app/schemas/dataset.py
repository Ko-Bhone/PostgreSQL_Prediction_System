from pydantic import BaseModel, ConfigDict

class DatasetBase(BaseModel):
    database_name : str
    total_records : int

class DatasetCreate(DatasetBase):
    pass

class DatasetResponse(DatasetBase):
    id : int
    model_config = ConfigDict(from_attributes=True)