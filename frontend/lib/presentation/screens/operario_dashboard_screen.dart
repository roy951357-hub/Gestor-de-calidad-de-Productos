import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../../core/routes/app_routes.dart'; // Importamos las rutas

class OperarioDashboardScreen extends StatelessWidget {
  const OperarioDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.fondoApp,
      body: Column(
        children: [
          // ==========================================
          // ENCABEZADO SUPERIOR
          // ==========================================
          Container(
            padding: const EdgeInsets.only(top: 60, left: 24, right: 24, bottom: 24),
            decoration: const BoxDecoration(
              color: AppColors.operario,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.2), // Corrección a withValues
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Text(
                        'Operario',
                        style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Panel del Operario',
                      style: TextStyle(color: Colors.white, fontSize: 24, fontFamily: 'Manrope', fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Hola, Daniel Moreno',
                      style: TextStyle(color: Colors.white70, fontSize: 14),
                    ),
                  ],
                ),
                IconButton(
                  icon: const Icon(Icons.notifications_none, color: Colors.white),
                  onPressed: () {},
                ),
              ],
            ),
          ),

          // ==========================================
          // CONTENIDO PRINCIPAL
          // ==========================================
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 1. Tarjeta principal de escaneo
                  GestureDetector(
                    onTap: () {
                      // Navegación hacia la cámara
                      Navigator.pushNamed(context, AppRoutes.operarioCaptura);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: AppColors.operario,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.operario.withValues(alpha: 0.3), // Corrección a withValues
                            blurRadius: 10, 
                            offset: const Offset(0, 4)
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  'Nuevo escaneo de calidad',
                                  style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  'Captura el producto y deja que la IA detecte defectos al instante',
                                  style: TextStyle(color: Colors.white70, fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 16),
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                            child: const Icon(Icons.camera_alt, color: AppColors.operario),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),

                  // 2. Resumen de hoy
                  const Text('Resumen de hoy', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textoPrincipal)),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildSummaryItem('34', 'Primera', AppColors.primeraCalidad),
                      _buildSummaryItem('9', 'Segunda', AppColors.segundaCalidad),
                      _buildSummaryItem('3', 'Tercera', AppColors.terceraCalidad),
                    ],
                  ),
                  const SizedBox(height: 32),

                  // 3. Resultados recientes
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Resultados en tiempo real', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textoPrincipal)),
                      TextButton(
                        onPressed: () {},
                        child: const Text('Ver historial', style: TextStyle(color: AppColors.operario, fontSize: 12)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  _buildResultItem('Bandeja Yogurt 24u', 'Hace 2 min', 'Primera', AppColors.primeraCalidad),
                  _buildResultItem('Caja Leche Entera 1L', 'Hace 6 min', 'Segunda', AppColors.segundaCalidad),
                  _buildResultItem('Bolsa Kumis 1L', 'Hace 11 min', 'Tercera', AppColors.terceraCalidad),
                ],
              ),
            ),
          ),
        ],
      ),
      
      // ==========================================
      // BARRA DE NAVEGACIÓN INFERIOR
      // ==========================================
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: AppColors.operario,
        unselectedItemColor: AppColors.textoSecundario,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Inicio'),
          BottomNavigationBarItem(icon: Icon(Icons.camera_alt_outlined), label: 'Escanear'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Perfil'),
        ],
      ),
    );
  }

  // Widget auxiliar para los números de resumen
  Widget _buildSummaryItem(String count, String label, Color color) {
    return Column(
      children: [
        Text(count, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: color)),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 12, color: AppColors.textoSecundario)),
      ],
    );
  }

  // Widget auxiliar para la lista de resultados
  Widget _buildResultItem(String title, String time, String status, Color statusColor) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.borde),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.textoPrincipal)),
              const SizedBox(height: 4),
              Text(time, style: const TextStyle(fontSize: 12, color: AppColors.textoSecundario)),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: statusColor.withValues(alpha: 0.1), // Corrección a withValues
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: statusColor),
            ),
            child: Text(
              status,
              style: TextStyle(color: statusColor, fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}