# app/models/soporte.py
from .usuario import db
from datetime import datetime

class Notificacion(db.Model):
    __tablename__ = 'notificaciones'
    
    id = db.Column(db.Integer, primary_key=True) #[cite: 2]
    usuario_id = db.Column(db.Integer, db.ForeignKey('usuarios.id')) #[cite: 2]
    inspeccion_id = db.Column(db.Integer, db.ForeignKey('inspecciones.id')) #[cite: 2]
    tipo = db.Column(db.String(50)) #[cite: 2]
    mensaje = db.Column(db.String(255)) #[cite: 2]
    leida = db.Column(db.Boolean, default=False) #[cite: 2]
    created_at = db.Column(db.DateTime, default=datetime.utcnow) #[cite: 2]

class Reporte(db.Model):
    __tablename__ = 'reportes'
    
    id = db.Column(db.Integer, primary_key=True) #[cite: 2]
    generado_por = db.Column(db.Integer, db.ForeignKey('usuarios.id')) #[cite: 2]
    tipo = db.Column(db.String(100)) #[cite: 2]
    fecha_desde = db.Column(db.Date) #[cite: 2]
    fecha_hasta = db.Column(db.Date) #[cite: 2]
    archivo_url = db.Column(db.String(255)) #[cite: 2]
    created_at = db.Column(db.DateTime, default=datetime.utcnow) #[cite: 2]