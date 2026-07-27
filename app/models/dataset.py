from sqlalchemy import Integer, String
from sqlalchemy.orm import Mapped, mapped_column
from app.database.base import Base

class Dataset(Base):
    __tablename__ = "datasets"
    id :Mapped[int] = mapped_column(primary_key=True)
    dataset_name:Mapped[str] = mapped_column(String(100))
    total_records:Mapped[int] = mapped_column(Integer)