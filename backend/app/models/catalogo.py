# app/models/catalogo.py
from .usuario import db

class TipoDefecto(db.Model):
    __tablename__ = 'tipos_defecto'
    
    id = db.Column(db.Integer, primary_key=True) #[cite: 2]
    nombre = db.Column(db.String(100), nullable=False) #[cite: 2]
    descripcion = db.Column(db.String(255)) #[cite: 2]

class LineaProduccion(db.Model):
    __tablename__ = 'lineas_produccion'
    
    id = db.Column(db.Integer, primary_key=True) #[cite: 2]
    nombre = db.Column(db.String(100), nullable=False) #[cite: 2]

class CategoriaCalidad(db.Model):
    __tablename__ = 'categorias_calidad'
    
    id = db.Column(db.Integer, primary_key=True) #[cite: 2]
    nombre = db.Column(db.String(100), nullable=False) #[cite: 2]
    color = db.Column(db.String(50)) #[cite: 2]
    nivel = db.Column(db.Integer) #[cite: 2]

class Producto(db.Model):
    __tablename__ = 'productos'
    
    id = db.Column(db.Integer, primary_key=True) #[cite: 2]
    codigo = db.Column(db.String(50), unique=True, nullable=False) #[cite: 2]
    nombre = db.Column(db.String(150), nullable=False) #[cite: 2]
    activo = db.Column(db.Boolean, default=True) #[cite: 2]