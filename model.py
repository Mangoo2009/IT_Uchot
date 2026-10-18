from pydantic import *


class Users(BaseModel):
    name: str = Field(min_length=2)
    surname: str = Field(min_ledge=3)
    role: str = Field(min_length=4)
    login: str = Field(min_length=4)
    passworld: str = Field(min_length=8)


class Smart(BaseModel):
    name: str = Field(min_length=5)
    surname: str = Field(min_length=5, max_length=10)


class UserLogin(BaseModel):
    username: str = Field(min_length=2)
    password: str = Field(min_length=4)
