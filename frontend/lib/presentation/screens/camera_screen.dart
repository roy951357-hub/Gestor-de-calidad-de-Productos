import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import '../../core/theme/app_theme.dart';
import '../../main.dart'; // Para acceder a la lista global 'cameras'

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController? _controller;
  bool _isCameraInitialized = false;
  bool _isFlashOn = false;

  @override
  void initState() {
    super.initState();
    _initCamera();
  }

  Future<void> _initCamera() async {
    if (cameras.isEmpty) return;

    // Seleccionamos la cámara principal (trasera)
    _controller = CameraController(
      cameras[0],
      ResolutionPreset.high, // Alta resolución para mejor análisis
      enableAudio: false,
    );

    try {
      await _controller!.initialize();
      if (mounted) {
        setState(() => _isCameraInitialized = true);
      }
    } catch (e) {
      debugPrint("Error inicializando cámara: $e");
    }
  }

  // Función para encender/apagar la linterna (Flash)
  Future<void> _toggleFlash() async {
    if (_controller == null || !_isCameraInitialized) return;
    try {
      if (_isFlashOn) {
        await _controller!.setFlashMode(FlashMode.off);
        setState(() => _isFlashOn = false);
      } else {
        await _controller!.setFlashMode(FlashMode.torch); // Linterna continua
        setState(() => _isFlashOn = true);
      }
    } catch (e) {
      debugPrint("Error al cambiar el flash: $e");
    }
  }

  @override
  void dispose() {
    // Es vital apagar la cámara y el flash al salir de la pantalla
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Fondo negro mientras carga la cámara
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Escanear producto',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              _isFlashOn ? Icons.flash_on : Icons.flash_off, 
              color: Colors.white
            ),
            onPressed: _toggleFlash, // Conectado a la lógica del flash
          ),
        ],
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          // 1. Video en vivo de la cámara
          SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: _isCameraInitialized
                ? CameraPreview(_controller!) // Muestra lo que ve el lente
                : const Center(
                    child: CircularProgressIndicator(color: AppColors.operario),
                  ),
          ),

          // 2. Overlay de la interfaz (Marco y textos)
          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 60),
                const Text(
                  'Centra el producto dentro del marco',
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
                const Spacer(),

                // Marco delimitador de escaneo (Bounding box central)
                Container(
                  width: 280,
                  height: 280,
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.operario.withOpacity(0.5), width: 2),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Stack(
                    children: [
                      // Esquinas resaltadas
                      _buildCorner(Alignment.topLeft),
                      _buildCorner(Alignment.topRight),
                      _buildCorner(Alignment.bottomLeft),
                      _buildCorner(Alignment.bottomRight),
                      // Texto temporal en el centro
                      const Center(
                        child: Text(
                          'Producto\ndetectado en cuadro',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white38, fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                ),

                const Spacer(),

                // Indicador de análisis de IA
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: AppColors.operario.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColors.operario),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      SizedBox(
                        width: 12,
                        height: 12,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(AppColors.operario),
                        ),
                      ),
                      SizedBox(width: 8),
                      Text('Analizando...', style: TextStyle(color: AppColors.operario, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: Text(
                    'La IA analiza el empaque en tiempo real y determina su categoría de calidad',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white70, fontSize: 12),
                  ),
                ),
                const SizedBox(height: 32),

                // Botón de captura manual
                GestureDetector(
                  onTap: () {
                    // Simulación de envío a la IA
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Capturando imagen para análisis IA...'),
                        backgroundColor: AppColors.operario,
                      ),
                    );
                  },
                  child: Container(
                    width: 72,
                    height: 72,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 4),
                    ),
                    child: Center(
                      child: Container(
                        width: 56,
                        height: 56,
                        decoration: const BoxDecoration(
                          color: AppColors.operario,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.camera_alt, color: Colors.white, size: 28),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Toca el botón para capturar y analizar',
                  style: TextStyle(color: Colors.white54, fontSize: 12),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Widget auxiliar para dibujar las esquinas del marco de escaneo
  Widget _buildCorner(Alignment alignment) {
    return Align(
      alignment: alignment,
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          border: Border(
            top: (alignment == Alignment.topLeft || alignment == Alignment.topRight)
                ? const BorderSide(color: AppColors.operario, width: 4)
                : BorderSide.none,
            bottom: (alignment == Alignment.bottomLeft || alignment == Alignment.bottomRight)
                ? const BorderSide(color: AppColors.operario, width: 4)
                : BorderSide.none,
            left: (alignment == Alignment.topLeft || alignment == Alignment.bottomLeft)
                ? const BorderSide(color: AppColors.operario, width: 4)
                : BorderSide.none,
            right: (alignment == Alignment.topRight || alignment == Alignment.bottomRight)
                ? const BorderSide(color: AppColors.operario, width: 4)
                : BorderSide.none,
          ),
        ),
      ),
    );
  }
}