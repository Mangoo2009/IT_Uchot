from authx import AuthXConfig, AuthX, TokenPayload

import uvicorn
from fastapi import FastAPI, Form, Depends, Request, HTTPException
from fastapi.responses import RedirectResponse
from sqlalchemy import select
from starlette import status
from starlette.staticfiles import StaticFiles
from starlette.templating import Jinja2Templates

from DataBase import Session, Users, Equpment, Cabinets, EquipmentHistory

from dotenv import load_dotenv
load_dotenv()

templates = Jinja2Templates(directory="templates")

app = FastAPI()

app.mount('/static', StaticFiles(directory='static'), name='static')

Mango = AuthXConfig()
Mango.JWT_SECRET_KEY = "mellstroy-burmalda-mama-ptica-123123123123"
Mango.JWT_TOKEN_LOCATION = ["cookies"]
SuperMango = AuthX(config=Mango)

def history(cabinet_id: int, equipment_name: str, action: str, user_id: int, details: str | None):
    with Session() as session:
        session.add(EquipmentHistory(cabinet_id=cabinet_id, equipment_name=equipment_name, action=action, user_id=user_id, details=details))
        session.commit()

#распределение по ролям
async def get_current_user(payload: TokenPayload = Depends(SuperMango.access_token_required)):
    with Session() as session:
        user = session.get(Users, int(payload.sub))
        if not user:
            raise HTTPException(status_code=401, detail="User not found")
        return user

def require_roles(*roles: str):
    async def role_checker(user: Users = Depends(get_current_user)) -> Users:
        if user.role not in roles:
            raise HTTPException(status_code=403, detail=f"Недостаточно прав")
        return user
    return role_checker

#вход
#страница входа
@app.get('/login', tags=["login"])
def login_page(request: Request):
    return templates.TemplateResponse(request, 'Main_2.html')

#добавление токена
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


#главная
@app.get('/', tags=["main"])
def main(request: Request, payload: TokenPayload = Depends(SuperMango.access_token_required)):
    with Session() as session:
        cabinets = session.query(Cabinets).all()
    return templates.TemplateResponse(request, "Name.html", {"cabinets": cabinets})


#кабинеты
#страница добавление кабинетов
@app.get('/cabinet/add', tags=["cabinets"])
def add_cabinet_page(request: Request, user: Users = Depends(require_roles("admin"))):
    return templates.TemplateResponse(request, 'add_cabinet.html', {})

#добавление кабинета
@app.post('/cabinet', tags=["cabinets"])
def add_cabinet_post(name: str = Form(...),
                     id_user: int = Form(...),
                     user: Users = Depends(require_roles("admin"))):
    with Session() as session:
        session.add(Cabinets(name=name, id_user=id_user))
        session.commit()
    return RedirectResponse(url="/", status_code=303)

#просмотр кабинета
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

#страница редактирования
@app.get('/cabinet/{cabinet_id}/edit', tags=['cabinets'])
def edit_cabinet_page(request: Request, cabinet_id: int,
                      user: Users = Depends(require_roles("admin"))):
    with Session() as session:
        cabinet = session.get(Cabinets, cabinet_id)
        if cabinet is None:
            raise HTTPException(status_code=404, detail='Кабинет не найден')
    return templates.TemplateResponse(request, 'edit_cabinets.html', {'cabinet': cabinet})

#редактирование кабинета
@app.post('/cabinet/{cabinet_id}/edit', tags=['cabinets'])
def edit_cabinet(request: Request, cabinet_id: int,
                 user: Users = Depends(require_roles("admin")),
                 name: str = Form(),
                 id_user: int = Form()):
    with Session() as session:
        cabinet = session.get(Cabinets, cabinet_id)
        if cabinet is None:
            raise HTTPException(status_code=404, detail='Кабинеты не найдены')
        cabinet.name = name
        cabinet.id_user = id_user
        session.commit()
    return RedirectResponse(url=f'/cabinet/{cabinet_id}', status_code=303)

#удаление кабинета
@app.post('/cabinet/{cabinet_id}/delete')
def delete_cabinet(request: Request, cabinet_id: int,
                   user: Users = Depends(require_roles("admin"))):
    with Session() as session:
        cabinet = session.get(Cabinets, cabinet_id)
        if cabinet is None:
            raise HTTPException(status_code=404, detail='кабинет не найде')
        itemsin = session.query(Equpment).filter(Equpment.cabinets_id == cabinet_id).first()
        if itemsin:
            raise HTTPException(status_code=400, detail='в какбинете есть оборудование')
        session.delete(cabinet)
        session.commit()
    return RedirectResponse(url='/', status_code=303)


#оборудование
#страница добавление
@app.get('/equipment/add', tags=["equipment"])
def equipment_add_page(request: Request, cabinet_id: int,
                       user: Users = Depends(require_roles("admin"))):
    return templates.TemplateResponse(request, 'add_equipment.html', {'cabinet_id': cabinet_id})

#добавление
@app.post('/equipment', tags=["equipment"])
def equipment_add_post(type: str = Form(...),
                       status: str = Form(...),
                       cabinets_id: int = Form(...),
                       inv_number: str = Form(...),
                       name: str = Form(...),
                       user: Users = Depends(require_roles("admin"))):
    with Session() as session:
        session.add(Equpment(
            type=type,
            status=status,
            cabinets_id=cabinets_id,
            inv_number=inv_number,
            name=name
        ))
        session.commit()
        history(cabinets_id, name, "Добавлено", user.id, None)
    return RedirectResponse(url=f'/cabinet/{cabinets_id}', status_code=303)

#страница изменения оборудования
@app.get('/equipment/{equipment_id}/edit')
def equipment_edit_page(request: Request, equipment_id: int,
                   user: Users = Depends(require_roles("admin"))):
    with Session() as session:
        equipment = session.get(Equpment, equipment_id)
        if equipment is None:
            raise HTTPException(status_code=404, detail='оборудование не найдено')
    return templates.TemplateResponse(request, 'edit_equipment.html', {'equipment': equipment})

@app.post('/equipment/{equipment_id}/edit')
def equipment_edit(request: Request, equipment_id: int,
                   user: Users = Depends(require_roles("admin")),
                   type: str = Form(...),
                   status: str = Form(...),
                   cabinets_id: int = Form(...),
                   inv_number: str = Form(...),
                   name: str = Form(...)
                   ):
    with Session() as session:
        equipment = session.get(Equpment, equipment_id)
        if equipment is None:
            raise HTTPException(status_code=404, detail='оборудование не найдено')

        old_cabinet = equipment.cabinets_id
        old_name = equipment.name
        old_type = equipment.type
        old_status = equipment.status
        old_inv = equipment.inv_number

        equipment.name = name
        equipment.type = type
        equipment.status = status
        equipment.cabinets_id = cabinets_id
        equipment.inv_number = inv_number

        session.commit()

        if old_cabinet != cabinets_id:
            history(old_cabinet, old_name, "Перемещено", user.id, f"В кабинет {cabinets_id}")
            history(cabinets_id, name, "Поступило", user.id, f"Из кабинета {old_cabinet}")
        else:
            changes = []
            if old_name != name: changes.append(f"Название: {old_name} → {name}")
            if old_type != type: changes.append(f"Тип: {old_type} → {type}")
            if old_status != status: changes.append(f"Статус: {old_status} → {status}")
            if old_inv != inv_number: changes.append(f"Инв. номер: {old_inv} → {inv_number}")
            if changes:
                history(cabinets_id, name, "Изменено", user.id, "; ".join(changes))

    return RedirectResponse(url=f'/cabinet/{cabinets_id}', status_code=303)

#удаление оборудования
@app.post('/equipment/{equipment_id}/delete')
def delete_equipment(request: Request, equipment_id: int,
                     user: Users = Depends(require_roles("admin"))):
    with Session() as session:
        equipment = session.get(Equpment, equipment_id)
        if equipment is None:
            raise HTTPException(status_code=404, detail='оборудование не найдено')
        cabinets_id = equipment.cabinets_id
        equip_name = equipment.name
        history(cabinets_id, equip_name, "Удалено", user.id, None)
        session.delete(equipment)
        session.commit()
    return RedirectResponse(url=f'/cabinet/{cabinets_id}', status_code=303)

#история
@app.get('/cabinet/{cabinet_id}/history')
def history_cab(request: Request, cabinet_id: int, payload: TokenPayload = Depends(SuperMango.access_token_required)):
    with Session() as session:
        cabinet = session.get(Cabinets, cabinet_id)
        if cabinet is None:
            raise HTTPException(status_code=404, detail='кабинет ненайден')
        history_mam = session.query(EquipmentHistory).filter(EquipmentHistory.cabinet_id == cabinet_id).order_by(EquipmentHistory.created_at.desc()).all()
        return templates.TemplateResponse(request, 'History.html', {'cabinet': cabinet, 'history': history_mam})

#выход из системыф
@app.post('/logout')
def logout():
    response = RedirectResponse(url='/login', status_code=303)
    SuperMango.unset_access_cookies(response)
    return response


if __name__ == '__main__':
    uvicorn.run(app, host='127.0.0.1', port=8000)
