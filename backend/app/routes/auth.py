from flask import Blueprint, request, jsonify
from ..models.usuario import Usuario

auth_bp = Blueprint('auth', __name__, url_prefix='/api/auth')

@auth_bp.route('/login', methods=['POST'])
def login():
    data = request.get_json()
    correo = data.get('correo')
    password = data.get('password')

    # Buscamos el usuario en la base de datos de PostgreSQL
    usuario = Usuario.query.filter_by(correo=correo).first()

    # Como inyectaste '123456' directamente mediante SQL, comparamos el texto exacto
    if usuario and usuario.password_hash == password:
        return jsonify({
            "mensaje": "Login exitoso",
            "usuario": {
                "id": usuario.id,
                "nombre": usuario.nombre,
                "correo": usuario.correo,
                "rol_id": usuario.rol_id
            }
        }), 200
    else:
        return jsonify({"error": "Correo o contraseña incorrectos"}), 401