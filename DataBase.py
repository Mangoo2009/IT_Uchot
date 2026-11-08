from datetime import datetime

from sqlalchemy import *
from sqlalchemy.orm import *
import os
from dotenv import load_dotenv
load_dotenv()

engine = create_engine(
    os.getenv("DB_URL"),
    echo=True,
    pool_size=10,
    max_overflow=10
)

Session = sessionmaker(bind=engine)


class Base(DeclarativeBase):
    pass


class Users(Base):
    __tablename__ = 'users'

    id: Mapped[int] = mapped_column(primary_key=True)
    name: Mapped[str]
    surname: Mapped[str]
    role: Mapped[str]
    login: Mapped[str]
    password: Mapped[str]


class Equpment(Base):
    __tablename__ = 'equpment'

    id: Mapped[int] = mapped_column(primary_key=True)
    type: Mapped[str]
    status: Mapped[str]
    cabinets_id: Mapped[int] = mapped_column(ForeignKey("cabinets.id"))
    inv_number: Mapped[str]
    name: Mapped[str]


class Cabinets(Base):
    __tablename__ = 'cabinets'

    id: Mapped[int] = mapped_column(primary_key=True)
    name: Mapped[str]
    id_user: Mapped[int] = mapped_column(ForeignKey("users.id"))


class EquipmentHistory(Base):
    __tablename__ = 'equipment_history'
    id: Mapped[int] = mapped_column(primary_key=True)
    cabinet_id: Mapped[int] = mapped_column(ForeignKey("cabinets.id"))
    equipment_name: Mapped[str]
    action: Mapped[str]
    details: Mapped[str | None]
    user_id: Mapped[int] = mapped_column(ForeignKey("users.id"))
    user: Mapped["Users"] = relationship("Users", foreign_keys=[user_id])
    created_at: Mapped[datetime] = mapped_column(DateTime, default=func.now())

Base.metadata.create_all(engine)