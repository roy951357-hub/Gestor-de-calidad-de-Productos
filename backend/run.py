# backend/app.py
from app import create_app, socketio

# Creamos la instancia de la aplicación
app = create_app()

if __name__ == '__main__':
    # Arrancamos el servidor en el puerto 5000
    socketio.run(app, debug=True, host='0.0.0.0', port=5000)