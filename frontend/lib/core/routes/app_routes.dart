import 'package:flutter/material.dart';
import '../../presentation/screens/login_screen.dart';
import '../../presentation/screens/operario_dashboard_screen.dart';
import '../../presentation/screens/camera_screen.dart';
import '../../presentation/screens/operario_resultado_screen.dart';
import '../../presentation/screens/operario_correccion_screen.dart';
import '../../presentation/screens/supervisor_dashboard_screen.dart';
import '../../presentation/screens/admin_dashboard_screen.dart'; // <-- Aquí está tu archivo

class AppRoutes {
  static const String login = '/';
  
  // Rutas de Operario
  static const String operarioDashboard = '/operario/dashboard';
  static const String operarioCaptura = '/operario/captura';
  static const String operarioResultado = '/operario/resultado';
  static const String operarioCorreccion = '/operario/correccion';
  
  // Rutas de Supervisor
  static const String supervisorDashboard = '/supervisor/dashboard';
  
  // Rutas de Administrador
  static const String adminDashboard = '/admin/dashboard'; // <-- Ruta del admin

  static Map<String, WidgetBuilder> get routes {
    return {
      login: (context) => const LoginScreen(),
      operarioDashboard: (context) => const OperarioDashboardScreen(),
      operarioCaptura: (context) => const CameraScreen(),
      operarioResultado: (context) => const OperarioResultadoScreen(),
      operarioCorreccion: (context) => const OperarioCorreccionScreen(),
      supervisorDashboard: (context) => const SupervisorDashboardScreen(),
      adminDashboard: (context) => const AdminDashboardScreen(), // <-- Conexión final
    };
  }
}