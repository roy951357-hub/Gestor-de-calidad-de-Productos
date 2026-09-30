# app/models/usuario.py
from flask_sqlalchemy import SQLAlchemy
from datetime import datetime

db = SQLAlchemy()

class Rol(db.Model):
    __tablename__ = 'roles'
    
    id = db.Column(db.Integer, primary_key=True) #
    nombre = db.Column(db.String(50), nullable=False) #
    
    usuarios = db.relationship('Usuario', backref='rol', lazy=True)

class Usuario(db.Model):
    __tablename__ = 'usuarios'
    
    id = db.Column(db.Integer, primary_key=True) #
    rol_id = db.Column(db.Integer, db.ForeignKey('roles.id'), nullable=False) #
    nombre = db.Column(db.String(150), nullable=False) #
    correo = db.Column(db.String(150), unique=True, nullable=False) #
    password_hash = db.Column(db.String(255), nullable=False) #
    activo = db.Column(db.Boolean, default=True) #
    created_at = db.Column(db.DateTime, default=datetime.utcnow) #