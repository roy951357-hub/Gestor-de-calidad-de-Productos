import 'package:flutter/material.dart';

class AppColors {
  // Colores por rol
  static const Color admin = Color(0xFF1B4F72);
  static const Color operario = Color(0xFF0E7C7B);
  static const Color supervisor = Color(0xFF5B2E96);

  // Estados de calidad
  static const Color primeraCalidad = Color(0xFF2E8B57);
  static const Color segundaCalidad = Color(0xFFC98A12);
  static const Color terceraCalidad = Color(0xFFCD3928);

  // Neutros de interfaz
  static const Color fondoApp = Color(0xFFF5F6F8);
  static const Color superficie = Color(0xFFFFFFFF);
  static const Color borde = Color(0xFFE3E6EA);
  static const Color textoPrincipal = Color(0xFF1C2530);
  static const Color textoSecundario = Color(0xFF6B7684);
  static const Color textoTenue = Color(0xFF98A2AE);
}

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      scaffoldBackgroundColor: AppColors.fondoApp,
      fontFamily: 'IBMPlexSans', // Configurar en pubspec.yaml
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.admin, 
        elevation: 0,
        titleTextStyle: TextStyle(
          fontFamily: 'Manrope',
          fontSize: 20, 
          fontWeight: FontWeight.w700,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.admin,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          minimumSize: const Size(double.infinity, 50),
        ),
      ),
    );
  }
}