import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../../core/routes/app_routes.dart';

class OperarioResultadoScreen extends StatelessWidget {
  const OperarioResultadoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.fondoApp,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Resultado del análisis', style: TextStyle(color: Colors.white, fontSize: 18)),
        centerTitle: true,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(4),
            ),
            child: const Center(
              child: Text('Operario', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ==========================================
            // TARJETA DE PRODUCTO ANALIZADO
            // ==========================================
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.textoPrincipal, // Fondo oscuro para contrastar la foto
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  // Placeholder de la foto tomada
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: AppColors.textoSecundario,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Center(child: Text('Foto', style: TextStyle(color: Colors.white54, fontSize: 12))),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Bandeja Yogurt 24u', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 4),
                        const Text('Escaneado 10:42 - Línea 3', style: TextStyle(color: Colors.white70, fontSize: 12)),
                        const SizedBox(height: 12),
                        
                        // Etiqueta de calidad (Mockup: Segunda calidad)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppColors.segundaCalidad,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Text('Segunda calidad', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                        ),
                        const SizedBox(height: 12),
                        
                        // Barra de confianza del modelo
                        const Text('Confianza del modelo', style: TextStyle(color: Colors.white70, fontSize: 10)),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Expanded(
                              child: LinearProgressIndicator(
                                value: 0.87, // 87%
                                backgroundColor: Colors.white24,
                                valueColor: const AlwaysStoppedAnimation<Color>(AppColors.segundaCalidad),
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Text('87%', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // ==========================================
            // DEFECTOS DETECTADOS
            // ==========================================
            const Text('Defectos detectados', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textoPrincipal)),
            const SizedBox(height: 16),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                _buildDefectChip('Etiqueta desalineada'),
                _buildDefectChip('Sello parcial'),
              ],
            ),
            const SizedBox(height: 32),

            // ==========================================
            // LEYENDA DE ESCALA DE CALIDAD
            // ==========================================
            const Text('Escala de calidad de la empresa', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.textoPrincipal)),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildLegendItem('Primera', AppColors.primeraCalidad),
                _buildLegendItem('Segunda', AppColors.segundaCalidad),
                _buildLegendItem('Tercera', AppColors.terceraCalidad),
              ],
            ),
            const SizedBox(height: 40),

            // ==========================================
            // BOTONES DE ACCIÓN
            // ==========================================
            ElevatedButton(
              onPressed: () {
                // Al confirmar, regresa al panel de inicio del operario
                Navigator.popUntil(context, ModalRoute.withName(AppRoutes.operarioDashboard));
              },
              child: const Text('Confirmar resultado', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
            ),
            const SizedBox(height: 16),
            
            // Botón Secundario (Outline)
            OutlinedButton(
              onPressed: () {
                // Aquí navegaremos a la pantalla de corrección más adelante
                print("Ir a corregir veredicto");
              },
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: AppColors.operario, width: 2),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text(
                'Corregir veredicto',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.operario),
              ),
            ),
            const SizedBox(height: 16),
            const Center(
              child: Text(
                '¿La IA se equivocó? Corrige el veredicto para\nayudar a entrenar el modelo con tu observación',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12, color: AppColors.textoSecundario),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget auxiliar para los chips de defectos
  Widget _buildDefectChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AppColors.borde),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: const BoxDecoration(color: AppColors.terceraCalidad, shape: BoxShape.circle), // Punto rojo
          ),
          const SizedBox(width: 8),
          Text(label, style: const TextStyle(color: AppColors.textoPrincipal, fontSize: 13, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  // Widget auxiliar para la leyenda de colores
  Widget _buildLegendItem(String label, Color color) {
    return Row(
      children: [
        Container(width: 8, height: 8, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        const SizedBox(width: 6),
        Text(label, style: const TextStyle(fontSize: 12, color: AppColors.textoSecundario)),
      ],
    );
  }
}