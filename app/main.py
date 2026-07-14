from fastapi import FastAPI

app = FastAPI()

@app.get("/")
def root():
    return {
        "Message":"ML Prediction System API with PostgreSQL"
    }