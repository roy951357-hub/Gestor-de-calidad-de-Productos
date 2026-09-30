# app/models/inspeccion.py
from .usuario import db
from datetime import datetime

class Inspeccion(db.Model):
    __tablename__ = 'inspecciones'
    
    id = db.Column(db.Integer, primary_key=True) #[cite: 2]
    operario_id = db.Column(db.Integer, db.ForeignKey('usuarios.id'), nullable=False) #[cite: 2]
    producto_id = db.Column(db.Integer, db.ForeignKey('productos.id'), nullable=False) #[cite: 2]
    linea_id = db.Column(db.Integer, db.ForeignKey('lineas_produccion.id')) #[cite: 2]
    modelo_ia_id = db.Column(db.Integer, db.ForeignKey('modelos_ia.id')) #[cite: 2]
    categoria_ia_id = db.Column(db.Integer, db.ForeignKey('categorias_calidad.id')) #[cite: 2]
    confianza = db.Column(db.Numeric) #[cite: 2]
    imagen_url = db.Column(db.String(255)) #[cite: 2]
    estado = db.Column(db.String(50)) #[cite: 2]
    fecha_escaneo = db.Column(db.DateTime, default=datetime.utcnow) #[cite: 2]

class InspeccionDefecto(db.Model):
    __tablename__ = 'inspeccion_defectos'
    
    id = db.Column(db.Integer, primary_key=True) #[cite: 2]
    inspeccion_id = db.Column(db.Integer, db.ForeignKey('inspecciones.id'), nullable=False) #[cite: 2]
    tipo_defecto_id = db.Column(db.Integer, db.ForeignKey('tipos_defecto.id')) #[cite: 2]
    confianza = db.Column(db.Numeric) #[cite: 2]
    bounding_box = db.Column(db.JSON) #[cite: 2]