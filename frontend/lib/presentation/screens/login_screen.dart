import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../../core/routes/app_routes.dart';
import '../../data/services/api_service.dart'; // Importación del servicio de red

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isLoading = false; // Estado para controlar la animación de carga

  Future<void> _iniciarSesion() async {
    // Validación de campos vacíos
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      _mostrarError('Por favor, ingresa tu correo y contraseña');
      return;
    }

    setState(() => _isLoading = true);

    try {
      final apiService = ApiService();
      final data = await apiService.login(
        _emailController.text.trim(),
        _passwordController.text.trim(),
      );

      if (!mounted) return;

      // Redirección basada en el rol de la base de datos
      final int rolId = data['usuario']['rol_id'];
      
      if (rolId == 1) {
        // Redirigir al panel de administrador (por crear)
        // Navigator.pushReplacementNamed(context, AppRoutes.adminDashboard);
      } else if (rolId == 2) {
        Navigator.pushReplacementNamed(context, AppRoutes.operarioDashboard);
      } else if (rolId == 3) {
        Navigator.pushReplacementNamed(context, AppRoutes.supervisorDashboard);
      }
      
    } catch (e) {
      if (!mounted) return;
      _mostrarError(e.toString());
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _mostrarError(String mensaje) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(mensaje),
        backgroundColor: AppColors.terceraCalidad, // Usa el color rojo de error corporativo
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.admin, 
      body: SafeArea(
        bottom: false, 
        child: Column(
          children: [
            // ==========================================
            // SECCIÓN SUPERIOR: Logo y Títulos
            // ==========================================
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 40.0),
              child: Column(
                children: [
                  Container(
                    width: 120,
                    height: 120,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: Text(
                        'alpina',
                        style: TextStyle(
                          color: AppColors.admin,
                          fontSize: 28,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Veridex Gestor de Calidad\nde Productos',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontFamily: 'Manrope',
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Control de calidad en línea de producción - Alpina',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),

            // ==========================================
            // SECCIÓN INFERIOR: Tarjeta Blanca y Formulario
            // ==========================================
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: AppColors.superficie,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(32),
                    topRight: Radius.circular(32),
                  ),
                ),
                padding: const EdgeInsets.all(32.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Iniciar sesión',
                        style: TextStyle(
                          fontSize: 24,
                          fontFamily: 'Manrope',
                          fontWeight: FontWeight.bold,
                          color: AppColors.textoPrincipal,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Ingresa con tu cuenta corporativa',
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.textoSecundario,
                        ),
                      ),
                      const SizedBox(height: 32),

                      // Campo: Correo electrónico
                      const Text(
                        'Correo electrónico',
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textoPrincipal),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hintText: 'nombre@alpina.com',
                          hintStyle: const TextStyle(color: AppColors.textoTenue),
                          filled: true,
                          fillColor: AppColors.fondoApp,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: AppColors.borde),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: AppColors.borde),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Campo: Contraseña
                      const Text(
                        'Contraseña',
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textoPrincipal),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _passwordController,
                        obscureText: _obscurePassword,
                        decoration: InputDecoration(
                          hintText: '••••••••',
                          filled: true,
                          fillColor: AppColors.fondoApp,
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscurePassword ? Icons.visibility_off : Icons.visibility,
                              color: AppColors.textoSecundario,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscurePassword = !_obscurePassword;
                              });
                            },
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: AppColors.borde),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: AppColors.borde),
                          ),
                        ),
                      ),
                      
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {},
                          child: const Text(
                            '¿Olvidaste tu contraseña?',
                            style: TextStyle(
                              color: AppColors.admin,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Botón Iniciar Sesión con indicador de carga
                      ElevatedButton(
                        onPressed: _isLoading ? null : _iniciarSesion,
                        child: _isLoading 
                          ? const SizedBox(
                              width: 24, 
                              height: 24, 
                              child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)
                            )
                          : const Text(
                              'Iniciar sesión',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                      ),
                      const SizedBox(height: 24),

                      const Center(
                        child: Text(
                          'El sistema te llevará automáticamente a tu panel según tu rol\n\nAdministrador · Supervisor de calidad · Operario',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.textoSecundario,
                            height: 1.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}