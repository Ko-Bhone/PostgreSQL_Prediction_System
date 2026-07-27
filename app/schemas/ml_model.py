from pydantic import BaseModel, ConfigDict

class MLModel(BaseModel):
    model_name:str
    algorithm : str
    accuracy : float

class MLModelCreate(MLModel):
    pass

class MLModelResponse(MLModel):
    id : int

    model_config = ConfigDict(from_attributes=True)
