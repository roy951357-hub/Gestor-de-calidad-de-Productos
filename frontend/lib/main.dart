import 'package:flutter/material.dart';
import 'package:camera/camera.dart'; // <-- 1. Importación de la cámara
import 'core/theme/app_theme.dart';
import 'core/routes/app_routes.dart';

// 2. Variable global para guardar las cámaras disponibles del celular
List<CameraDescription> cameras = [];

Future<void> main() async {
  // 3. Obligatorio: asegurar que Flutter esté inicializado antes de buscar hardware
  WidgetsFlutterBinding.ensureInitialized();
  
  try {
    // 4. Detectar y guardar las cámaras disponibles
    cameras = await availableCameras();
  } catch (e) {
    debugPrint('Error al inicializar la cámara: $e');
  }

  runApp(const VeridexApp());
}

class VeridexApp extends StatelessWidget {
  const VeridexApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Veridex Alpina',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      initialRoute: AppRoutes.login,
      routes: AppRoutes.routes,
    );
  }
}