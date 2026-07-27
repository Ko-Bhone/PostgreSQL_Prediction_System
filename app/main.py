from fastapi import FastAPI
from app.api.users import router as user_router


app = FastAPI(
    title = "ML Prediction API",
    version = "1.0.0")

app.include_router(user_router)

@app.get("/")
def root():
    return {"Message": "Welcome to ML Prediction API......."}

