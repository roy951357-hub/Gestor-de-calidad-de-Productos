# seed.py
from app import create_app
from app.models.usuario import db, Rol, Usuario

app = create_app()

with app.app_context():
    # 1. Crear los roles
    rol_admin = Rol(id=1, nombre='Administrador')
    rol_operario = Rol(id=2, nombre='Operario')
    rol_supervisor = Rol(id=3, nombre='Supervisor')
    
    # 2. Crear un usuario de prueba (Operario)
    operario = Usuario(
        rol_id=2, # Asignamos el rol de Operario
        nombre='Daniel Moreno',
        correo='daniel@alpina.com',
        password_hash='123456' # Usamos texto plano temporalmente por simplicidad
    )
    
    # 3. Guardar en la base de datos
    db.session.add_all([rol_admin, rol_operario, rol_supervisor, operario])
    db.session.commit()
    print("✅ Roles y usuario 'daniel@alpina.com' creados exitosamente.")