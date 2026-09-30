from flask import Flask
from flask_socketio import SocketIO
from .models.usuario import db

# Importamos todos los modelos
from .models.usuario import Rol, Usuario
from .models.catalogo import TipoDefecto, LineaProduccion, CategoriaCalidad, Producto
from .models.inspeccion import Inspeccion, InspeccionDefecto
from .models.revision import Correccion, Validacion
from .models.entrenamiento import ModeloIA, ImagenReferencia, AnotacionReferencia, Dataset, DatasetImagen, Entrenamiento
from .models.soporte import Notificacion, Reporte

socketio = SocketIO(cors_allowed_origins="*")

def create_app():
    app = Flask(__name__)

    app.config['SQLALCHEMY_DATABASE_URI'] = 'postgresql://postgres:admin123@localhost:5432/veridex'
    app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

    db.init_app(app)
    socketio.init_app(app)

    with app.app_context():
        db.create_all()
        print("✅ ¡Todas las tablas se han creado y sincronizado con PostgreSQL exitosamente!")

    from .routes.auth import auth_bp
    app.register_blueprint(auth_bp)

    return app