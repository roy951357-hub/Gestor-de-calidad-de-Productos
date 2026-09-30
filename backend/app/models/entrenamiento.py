# app/models/entrenamiento.py
from .usuario import db
from datetime import datetime

class ModeloIA(db.Model):
    __tablename__ = 'modelos_ia'
    
    id = db.Column(db.Integer, primary_key=True) #
    version = db.Column(db.String(50)) #[cite: 2]
    precision = db.Column(db.Numeric) #[cite: 2]
    fecha_entrenamiento = db.Column(db.Date) #[cite: 2]
    activo = db.Column(db.Boolean) #[cite: 2]

class ImagenReferencia(db.Model):
    __tablename__ = 'imagenes_referencia'
    
    id = db.Column(db.Integer, primary_key=True) #[cite: 2]
    producto_id = db.Column(db.Integer, db.ForeignKey('productos.id')) #[cite: 2]
    categoria_id = db.Column(db.Integer, db.ForeignKey('categorias_calidad.id')) #[cite: 2]
    inspeccion_id = db.Column(db.Integer, db.ForeignKey('inspecciones.id')) #[cite: 2]
    subido_por = db.Column(db.Integer, db.ForeignKey('usuarios.id')) #[cite: 2]
    imagen_url = db.Column(db.String(255)) #[cite: 2]
    origen = db.Column(db.String(100)) #[cite: 2]
    estado_revision = db.Column(db.String(50)) #[cite: 2]
    created_at = db.Column(db.DateTime, default=datetime.utcnow) #[cite: 2]

class AnotacionReferencia(db.Model):
    __tablename__ = 'anotaciones_referencia'
    
    id = db.Column(db.Integer, primary_key=True) #[cite: 2]
    imagen_id = db.Column(db.Integer, db.ForeignKey('imagenes_referencia.id')) #[cite: 2]
    tipo_defecto_id = db.Column(db.Integer, db.ForeignKey('tipos_defecto.id')) #[cite: 2]
    bounding_box = db.Column(db.JSON) #[cite: 2]
    anotado_por = db.Column(db.Integer, db.ForeignKey('usuarios.id')) #[cite: 2]

class Dataset(db.Model):
    __tablename__ = 'datasets'
    
    id = db.Column(db.Integer, primary_key=True) #[cite: 2]
    producto_id = db.Column(db.Integer, db.ForeignKey('productos.id')) #[cite: 2]
    creado_por = db.Column(db.Integer, db.ForeignKey('usuarios.id')) #[cite: 2]
    nombre = db.Column(db.String(150)) #[cite: 2]
    descripcion = db.Column(db.String(255)) #[cite: 2]
    created_at = db.Column(db.DateTime, default=datetime.utcnow) #[cite: 2]

class DatasetImagen(db.Model):
    __tablename__ = 'dataset_imagenes'
    
    dataset_id = db.Column(db.Integer, db.ForeignKey('datasets.id'), primary_key=True) #[cite: 2]
    imagen_id = db.Column(db.Integer, db.ForeignKey('imagenes_referencia.id'), primary_key=True) #[cite: 2]
    split = db.Column(db.String(50)) #[cite: 2]

class Entrenamiento(db.Model):
    __tablename__ = 'entrenamientos'
    
    id = db.Column(db.Integer, primary_key=True) #[cite: 2]
    dataset_id = db.Column(db.Integer, db.ForeignKey('datasets.id')) #[cite: 2]
    modelo_resultado_id = db.Column(db.Integer, db.ForeignKey('modelos_ia.id')) #[cite: 2]
    ejecutado_por = db.Column(db.Integer, db.ForeignKey('usuarios.id')) #[cite: 2]
    modelo_base = db.Column(db.String(100)) #[cite: 2]
    epocas = db.Column(db.Integer) #[cite: 2]
    precision = db.Column(db.Numeric) #[cite: 2]
    recall = db.Column(db.Numeric) #[cite: 2]
    estado = db.Column(db.String(50)) #[cite: 2]
    fecha_inicio = db.Column(db.DateTime) #[cite: 2]
    fecha_fin = db.Column(db.DateTime) #[cite: 2]