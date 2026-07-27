from sqlalchemy import Float, String
from sqlalchemy.orm import Mapped, mapped_column
from app.database.base import Base

class ML_Model(Base):
    __tablename__ = 'ml_model'
    id:Mapped[int] = mapped_column(primary_key=True)
    model_name:Mapped[str] = mapped_column(String(100))
    algorithm_name:Mapped[str] = mapped_column(String(100))
    accuracy:Mapped[float] = mapped_column(Float)
