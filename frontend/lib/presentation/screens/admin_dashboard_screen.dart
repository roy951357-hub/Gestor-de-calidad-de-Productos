import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../core/theme/app_theme.dart';
import '../../core/routes/app_routes.dart';
import '../../data/services/api_service.dart';

class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({super.key});

  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  Map<String, dynamic>? _dashboardData;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchDashboardData();
  }

  Future<void> _fetchDashboardData() async {
    try {
      final response = await http.get(Uri.parse('${ApiService.baseUrl}/admin/dashboard'));
      if (response.statusCode == 200) {
        setState(() {
          _dashboardData = jsonDecode(response.body);
          _isLoading = false;
        });
      } else {
        setState(() => _isLoading = false);
      }
    } catch (e) {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final resumen = _dashboardData?['resumen'];

    return Scaffold(
      backgroundColor: AppColors.fondoApp,
      body: _isLoading
          ? const Center(child: CircularProgressIndicator(color: AppColors.admin))
          : Column(
              children: [
                // ==========================================
                // ENCABEZADO SUPERIOR (AZUL ADMIN)
                // ==========================================
                Container(
                  padding: const EdgeInsets.only(top: 60, left: 24, right: 24, bottom: 24),
                  decoration: const BoxDecoration(
                    color: AppColors.admin,
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
                              'Administrador',
                              style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            'Panel de Control',
                            style: TextStyle(color: Colors.white, fontSize: 24, fontFamily: 'Manrope', fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            'Gestión y monitoreo general de planta',
                            style: TextStyle(color: Colors.white70, fontSize: 14),
                          ),
                        ],
                      ),
                      IconButton(
                        icon: const Icon(Icons.refresh, color: Colors.white),
                        onPressed: _fetchDashboardData,
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
                        // Métricas Principales
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildStatCard('${resumen?['inspecciones_hoy'] ?? 0}', 'Inspecciones', AppColors.admin),
                            _buildStatCard('${resumen?['aprobacion_porcentaje'] ?? 0}%', 'Aprobación', AppColors.primeraCalidad),
                            _buildStatCard('${resumen?['alertas_activas'] ?? 0}', 'Alertas hoy', AppColors.terceraCalidad),
                          ],
                        ),
                        const SizedBox(height: 32),

                        // Gestión Rápida
                        const Text('Administración del Sistema', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textoPrincipal)),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(
                              child: _buildActionTile(
                                icon: Icons.people_outline,
                                title: 'Usuarios',
                                subtitle: '${resumen?['total_usuarios'] ?? 0} registrados',
                                onTap: () {},
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: _buildActionTile(
                                icon: Icons.psychology_outlined,
                                title: 'Modelos IA',
                                subtitle: 'v1.4 en producción',
                                onTap: () {},
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 32),

                        // Alertas Recientes
                        const Text('Alertas Críticas Recientes', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textoPrincipal)),
                        const SizedBox(height: 12),
                        ...((_dashboardData?['ultimas_alertas'] as List<dynamic>?) ?? []).map((alerta) {
                          return Container(
                            margin: const EdgeInsets.only(bottom: 12),
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: AppColors.borde),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 10,
                                  height: 10,
                                  decoration: const BoxDecoration(
                                    color: AppColors.terceraCalidad,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(alerta['producto'], style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.textoPrincipal)),
                                      Text('${alerta['defecto']} · ${alerta['linea']}', style: const TextStyle(fontSize: 12, color: AppColors.textoSecundario)),
                                    ],
                                  ),
                                ),
                                Text(alerta['hora'], style: const TextStyle(fontSize: 12, color: AppColors.textoSecundario)),
                              ],
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                ),
              ],
            ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.admin,
        unselectedItemColor: AppColors.textoSecundario,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard_outlined), label: 'Inicio'),
          BottomNavigationBarItem(icon: Icon(Icons.people_outline), label: 'Usuarios'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart_outlined), label: 'Reportes'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Perfil'),
        ],
      ),
    );
  }

  Widget _buildStatCard(String value, String label, Color color) {
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
          Text(value, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: color)),
          const SizedBox(height: 4),
          Text(label, textAlign: TextAlign.center, style: const TextStyle(fontSize: 11, color: AppColors.textoSecundario)),
        ],
      ),
    );
  }

  Widget _buildActionTile({required IconData icon, required String title, required String subtitle, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.borde),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: AppColors.admin, size: 28),
            const SizedBox(height: 8),
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.textoPrincipal)),
            Text(subtitle, style: const TextStyle(fontSize: 11, color: AppColors.textoSecundario)),
          ],
        ),
      ),
    );
  }
}