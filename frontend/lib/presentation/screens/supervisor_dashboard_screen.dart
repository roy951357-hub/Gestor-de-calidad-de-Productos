import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../../core/routes/app_routes.dart';

class SupervisorDashboardScreen extends StatelessWidget {
  const SupervisorDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.fondoApp,
      body: Column(
        children: [
          // ==========================================
          // ENCABEZADO SUPERIOR (MORADO)
          // ==========================================
          Container(
            padding: const EdgeInsets.only(top: 60, left: 24, right: 24, bottom: 24),
            decoration: const BoxDecoration(
              color: AppColors.supervisor,
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
                        color: Colors.white.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Text(
                        'Supervisor',
                        style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Panel del Supervisor',
                      style: TextStyle(color: Colors.white, fontSize: 24, fontFamily: 'Manrope', fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Hola, Marcela Cifuentes',
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
                  // 1. Tarjetas de Resumen Numérico
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildStatCard('7', 'Por validar', AppColors.supervisor),
                      _buildStatCard('41', 'Validadas hoy', AppColors.primeraCalidad),
                      _buildStatCard('2', 'Rechazadas', AppColors.terceraCalidad),
                    ],
                  ),
                  const SizedBox(height: 32),

                  // 2. Gráfico de Distribución General
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.borde),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Distribución general', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textoPrincipal)),
                        const SizedBox(height: 4),
                        const Text('Planta completa - hoy', style: TextStyle(fontSize: 12, color: AppColors.textoSecundario)),
                        const SizedBox(height: 24),
                        Row(
                          children: [
                            // Placeholder del gráfico Donut
                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: AppColors.primeraCalidad, width: 12),
                              ),
                              child: const Center(
                                child: Text('92%', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.textoPrincipal)),
                              ),
                            ),
                            const SizedBox(width: 24),
                            // Leyenda del gráfico
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildChartLegend('Primera calidad', '68%', AppColors.primeraCalidad),
                                  const SizedBox(height: 12),
                                  _buildChartLegend('Segunda calidad', '22%', AppColors.segundaCalidad),
                                  const SizedBox(height: 12),
                                  _buildChartLegend('Tercera calidad', '10%', AppColors.terceraCalidad),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),

                  // 3. Lista de Pruebas por validar
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Pruebas por validar', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textoPrincipal)),
                      TextButton(
                        onPressed: () {},
                        child: const Text('Ver todas', style: TextStyle(color: AppColors.supervisor, fontSize: 12)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  
                  _buildValidationItem(
                    title: 'Caja Leche Entera 1L',
                    subtitle: 'Daniel Moreno - Línea 2',
                    status: 'Segunda',
                    statusColor: AppColors.segundaCalidad,
                    isHighlighted: true, // Mockup muestra la primera tarjeta con borde de color
                  ),
                  _buildValidationItem(
                    title: 'Bolsa Kumis 1L',
                    subtitle: 'Roy Rojas - Línea 1',
                    status: 'Tercera',
                    statusColor: AppColors.terceraCalidad,
                    isHighlighted: false,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      
      // ==========================================
      // BARRA DE NAVEGACIÓN INFERIOR (4 ítems para Supervisor)
      // ==========================================
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        type: BottomNavigationBarType.fixed, // Necesario cuando son más de 3 ítems
        selectedItemColor: AppColors.supervisor,
        unselectedItemColor: AppColors.textoSecundario,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Inicio'),
          BottomNavigationBarItem(icon: Icon(Icons.check_circle_outline), label: 'Validar'),
          BottomNavigationBarItem(icon: Icon(Icons.access_time), label: 'Historial'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Perfil'),
        ],
      ),
    );
  }

  // Widget para las estadísticas superiores
  Widget _buildStatCard(String count, String label, Color color) {
    return Container(
      width: 100,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.borde),
      ),
      child: Column(
        children: [
          Text(count, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: color)),
          const SizedBox(height: 4),
          Text(label, textAlign: TextAlign.center, style: const TextStyle(fontSize: 11, color: AppColors.textoSecundario)),
        ],
      ),
    );
  }

  // Widget para la leyenda del gráfico
  Widget _buildChartLegend(String label, String percentage, Color color) {
    return Row(
      children: [
        Container(width: 8, height: 8, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.textoPrincipal)),
            Text('$percentage del total', style: const TextStyle(fontSize: 10, color: AppColors.textoSecundario)),
          ],
        ),
      ],
    );
  }

  // Widget para las tarjetas de validación pendientes
  Widget _buildValidationItem({required String title, required String subtitle, required String status, required Color statusColor, required bool isHighlighted}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isHighlighted ? statusColor : AppColors.borde,
          width: isHighlighted ? 2 : 1,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.textoPrincipal)),
                const SizedBox(height: 4),
                Text(subtitle, style: const TextStyle(fontSize: 12, color: AppColors.textoSecundario)),
                const SizedBox(height: 8),
                Text(status, style: TextStyle(color: statusColor, fontSize: 12, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {
              // Navegará a la vista de revisión
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.supervisor,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              minimumSize: Size.zero, // Quita el tamaño mínimo global
            ),
            child: const Text('Revisar', style: TextStyle(color: Colors.white, fontSize: 12)),
          ),
        ],
      ),
    );
  }
}