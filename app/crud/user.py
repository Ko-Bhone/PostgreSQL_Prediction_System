from sqlalchemy.orm import Session
from app.models.user import User
from app.schemas.user import UserCreate

def create_user(db: Session, user: UserCreate) -> User:
    db_user = User(
        full_name = user.full_name,
        email = user.email,
        password = user.password)

    db.add(db_user)
    db.commit()
    return db_user

def get_user_by_id(db: Session, user_id: int) -> User | None:
    return db.query(User).filter(User.id == user_id).first()

def get_user_by_email(db: Session, email: str) -> User | None:
    return db.query(User).filter(User.email == email).first()

def get_users(db: Session, email:str) -> list[User]:
    return db.query(User).all()

def update_user(db: Session, user:User, full_name:str, email:str) -> User:
    user.full_name = full_name
    user.email = email
    db.commit()
    db.refresh(user)
    return user

def delete_user(db: Session, user:User) -> None:
    db.delete()
    db.commit()
