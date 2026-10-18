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
    cabinets_id: Mapped[int] = mapped_column(ForeignKey("cabinet.id"))
    inv_number: Mapped[str]
    name: Mapped[str]


class Cabinets(Base):
    __tablename__ = 'cabinets'

    id: Mapped[int] = mapped_column(primary_key=True)
    name: Mapped[str]
    id_user: Mapped[int] = mapped_column(ForeignKey("users.id"))

Base.metadata.create_all(engine)