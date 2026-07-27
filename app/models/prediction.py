from sqlalchemy import Float, ForeignKey, String
from sqlalchemy.orm import Mapped, mapped_column
from app.database.base import Base


class Prediction(Base):
    __tablename__ = "predictions"
    id:Mapped[int] = mapped_column(primary_key=True)
    user_id:Mapped[int] = mapped_column(ForeignKey("users.id"))
    model_id:Mapped[int] = mapped_column(ForeignKey("ml_models.id"))
    dataset_id:Mapped[int] = mapped_column(ForeignKey("datasets.id"))
    prediction:Mapped[str] = mapped_column(String(100))
    confidence:Mapped[float] = mapped_column(Float)