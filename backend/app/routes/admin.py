# backend/app/routes/admin.py
from flask import Blueprint, jsonify
from ..models.usuario import Usuario, Rol
# Importa los modelos adicionales de tu esquema cuando los requieras:
# from ..models.producto import Producto
# from ..models.captura import Captura, DeteccionIA

admin_bp = Blueprint('admin', __name__, url_prefix='/api/admin')

@admin_bp.route('/dashboard', methods=['GET'])
def get_dashboard_data():
    try:
        # ==========================================
        # CONSULTAS REALES A POSTGRESQL
        # ==========================================
        
        # Conteo total de usuarios registrados en la base de datos
        total_usuarios = Usuario.query.count()
        
        # Conteo real de operarios activos cruzando con la tabla de roles
        operarios_activos = Usuario.query.join(Rol).filter(Rol.nombre == 'Operario').count()
        
        # Conteo de administradores y supervisores
        administradores = Usuario.query.join(Rol).filter(Rol.nombre == 'Administrador').count()
        supervisores = Usuario.query.join(Rol).filter(Rol.nombre == 'Supervisor').count()

        # Retornamos los datos reales extraídos del motor relacional
        return jsonify({
            "estado": "Conexión exitosa con PostgreSQL",
            "metricas_usuarios": {
                "total_usuarios": total_usuarios,
                "operarios_activos": operarios_activos,
                "administradores": administradores,
                "supervisores": supervisores
            }
            # Nota: A medida que vayas poblando las tablas de detecciones (DETECCIONES_IA) 
            # y validaciones (VALIDACIONES), puedes agregar aquí sus .query.count() o filtros reales.
        }), 200

    except Exception as e:
        return jsonify({
            "error": "Error al consultar la base de datos",
            "detalles": str(e)
        }), 500