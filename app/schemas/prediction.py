from pydantic import BaseModel, ConfigDict

class PredictionBase(BaseModel):
    user_id : int
    model_id : int
    dataset_id : int
    prediction : str
    confidence : float


class PredictionCreate(PredictionBase):
    pass

class PredictionResponse(PredictionBase):
    id : int
    model_config = ConfigDict(from_attributes=True)