from fastapi import FastAPI

from app.models import user, ml_model, dataset, prediction

app = FastAPI(
    title = "ML Prediction API",
    version = "1.0.0")

@app.get("/")
def root():
    return {"Message": "Welcome to ML Prediction API......."}

