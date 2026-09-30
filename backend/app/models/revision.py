# app/models/revision.py
from .usuario import db
from datetime import datetime

class Correccion(db.Model):
    __tablename__ = 'correcciones'
    
    id = db.Column(db.Integer, primary_key=True) #[cite: 2]
    inspeccion_id = db.Column(db.Integer, db.ForeignKey('inspecciones.id'), nullable=False) #[cite: 2]
    operario_id = db.Column(db.Integer, db.ForeignKey('usuarios.id'), nullable=False) #[cite: 2]
    categoria_sugerida_id = db.Column(db.Integer, db.ForeignKey('categorias_calidad.id')) #[cite: 2]
    ia_correcta = db.Column(db.Boolean) #[cite: 2]
    tipo_error = db.Column(db.String(100)) #[cite: 2]
    comentario = db.Column(db.String(255)) #[cite: 2]
    fecha = db.Column(db.DateTime, default=datetime.utcnow) #[cite: 2]

class Validacion(db.Model):
    __tablename__ = 'validaciones'
    
    id = db.Column(db.Integer, primary_key=True) #[cite: 2]
    inspeccion_id = db.Column(db.Integer, db.ForeignKey('inspecciones.id'), nullable=False) #[cite: 2]
    supervisor_id = db.Column(db.Integer, db.ForeignKey('usuarios.id'), nullable=False) #[cite: 2]
    categoria_final_id = db.Column(db.Integer, db.ForeignKey('categorias_calidad.id')) #[cite: 2]
    resultado = db.Column(db.String(100)) #[cite: 2]
    comentario = db.Column(db.String(255)) #[cite: 2]
    fecha = db.Column(db.DateTime, default=datetime.utcnow) #[cite: 2]