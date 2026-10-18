import os

from authx import AuthXConfig, AuthX, TokenPayload

import uvicorn
from fastapi import FastAPI, Form, Depends, Request, HTTPException
from fastapi.responses import RedirectResponse
from sqlalchemy import select
from starlette import status
from starlette.staticfiles import StaticFiles
from starlette.templating import Jinja2Templates

from DataBase import Session, Users, Equpment, Cabinets

from dotenv import load_dotenv
load_dotenv()

templates = Jinja2Templates(directory="templates")

app = FastAPI()

app.mount('/static', StaticFiles(directory='static'), name='static')

Mango = AuthXConfig()
Mango.JWT_SECRET_KEY = "mellstroy-burmalda-mama-ptica-123123123123"
Mango.JWT_TOKEN_LOCATION = ["cookies"]
Mango.JWT_COOKIE_CSRF_PROTECT = False
SuperMango = AuthX(config=Mango)


# ВХОД
@app.get('/login', tags=["login"])
def login_page(request: Request):
    return templates.TemplateResponse(request, 'Main_2.html', {})


@app.post("/login", tags=["login"])
def login_post(
        username: str = Form(...),
        password: str = Form(...)
):
    with Session() as session:
        data = session.scalar(select(Users).where(Users.login == username))
        if data and data.password == password:
            token = SuperMango.create_access_token(uid=str(data.id))
            response = RedirectResponse(url="/", status_code=303)
            SuperMango.set_access_cookies(token, response)
            return response
    raise HTTPException(status_code=status.HTTP_401_UNAUTHORIZED,
                        detail="Incorrect username or password")


# ГЛАВНАЯ СТРАНИЦА
@app.get('/', tags=["main"])
def main(request: Request, payload: TokenPayload = Depends(SuperMango.access_token_required)):
    with Session() as session:
        cabinets = session.query(Cabinets).all()
    return templates.TemplateResponse(request, "Name.html", {"cabinets": cabinets})


# КАБИНЕТЫ
@app.get('/cabinet/add', tags=["cabinets"])
def add_cabinet_page(request: Request, payload: TokenPayload = Depends(SuperMango.access_token_required)):
    return templates.TemplateResponse(request, 'add_cabinet.html', {})


@app.post('/cabinet', tags=["cabinets"])
def add_cabinet_post(name: str = Form(...),
                     id_user: int = Form(...),
                     payload: TokenPayload = Depends(SuperMango.access_token_required)):
    with Session() as session:
        session.add(Cabinets(name=name, id_user=id_user))
        session.commit()
    return RedirectResponse(url="/", status_code=303)


@app.get('/cabinet/{cabinet_id}', tags=["cabinets"])
def cabinet_page(request: Request, cabinet_id: int,
                 payload: TokenPayload = Depends(SuperMango.access_token_required)):
    with Session() as session:
        cabinet = session.get(Cabinets, cabinet_id)
        if cabinet is None:
            raise HTTPException(status_code=404, detail="Кабинет не найден")
        items = session.query(Equpment).filter(Equpment.cabinets_id == cabinet_id).all()
    return templates.TemplateResponse(request, 'cabinet.html',
                                      {'equipment': items, 'cabinet': cabinet})


# ОБОРУДОВАНИЕ
@app.get('/equipment/add', tags=["equipment"])
def equipment_add_page(request: Request, cabinet_id: int,
                       payload: TokenPayload = Depends(SuperMango.access_token_required)):
    return templates.TemplateResponse(request, 'add_equipment.html', {'cabinet_id': cabinet_id})


@app.post('/equipment', tags=["equipment"])
def equipment_add_post(type: str = Form(...),
                       status: str = Form(...),
                       cabinets_id: int = Form(...),
                       inv_number: str = Form(...),
                       name: str = Form(...),
                       payload: TokenPayload = Depends(SuperMango.access_token_required)):
    with Session() as session:
        session.add(Equpment(
            type=type,
            status=status,
            cabinets_id=cabinets_id,
            inv_number=inv_number,
            name=name
        ))
        session.commit()
    return RedirectResponse(url=f'/cabinet/{cabinets_id}', status_code=303)


if __name__ == '__main__':
    uvicorn.run(app, host='127.0.0.1', port=8000)
