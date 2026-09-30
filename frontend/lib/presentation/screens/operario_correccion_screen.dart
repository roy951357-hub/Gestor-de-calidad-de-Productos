import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../../core/routes/app_routes.dart';

class OperarioCorreccionScreen extends StatefulWidget {
  const OperarioCorreccionScreen({super.key});

  @override
  State<OperarioCorreccionScreen> createState() => _OperarioCorreccionScreenState();
}

class _OperarioCorreccionScreenState extends State<OperarioCorreccionScreen> {
  bool? _esCorrecto; // true: Es correcto, false: Está mal
  String? _errorSeleccionado;
  final TextEditingController _comentarioController = TextEditingController();

  final List<String> _opcionesError = [
    'Debería ser Primera calidad',
    'Debería ser Tercera calidad',
    'No detectó el defecto real',
    'Falso positivo (no hay defecto)'
  ];

  void _enviarCorreccion() {
    // Si indicó que está mal y no seleccionó un error, no hacemos nada
    if (_esCorrecto == false && _errorSeleccionado == null) return;
    
    // Regresa al dashboard del operario tras enviar
    Navigator.popUntil(context, ModalRoute.withName(AppRoutes.operarioDashboard));
  }

  @override
  Widget build(BuildContext context) {
    // Determinamos si el botón de enviar debe estar activo
    final bool canSubmit = _esCorrecto == true || (_esCorrecto == false && _errorSeleccionado != null);

    return Scaffold(
      backgroundColor: AppColors.fondoApp,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Corregir veredicto', style: TextStyle(color: Colors.white, fontSize: 18)),
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
            // Resumen del veredicto actual
            const Text('Bandeja Yogurt 24u', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textoPrincipal)),
            const SizedBox(height: 4),
            const Text('Veredicto de la IA: Segunda calidad - 87% confianza', style: TextStyle(fontSize: 12, color: AppColors.textoSecundario)),
            const SizedBox(height: 24),

            // Pregunta principal
            const Text('¿El veredicto de la IA es correcto?', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textoPrincipal)),
            const SizedBox(height: 16),
            
            // Botones de selección múltiple (Toggle)
            Row(
              children: [
                Expanded(
                  child: _buildToggleButton(
                    title: 'Es correcto',
                    icon: Icons.check,
                    isSelected: _esCorrecto == true,
                    activeColor: AppColors.primeraCalidad,
                    onTap: () => setState(() {
                      _esCorrecto = true;
                      _errorSeleccionado = null; // Limpiamos errores si dice que está bien
                    }),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildToggleButton(
                    title: 'Está mal',
                    icon: Icons.close,
                    isSelected: _esCorrecto == false,
                    activeColor: AppColors.terceraCalidad,
                    onTap: () => setState(() => _esCorrecto = false),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),

            // Formulario condicional (Solo se muestra si selecciona "Está mal")
            if (_esCorrecto == false) ...[
              const Text('Selecciona el error del modelo', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textoPrincipal)),
              const SizedBox(height: 4),
              const Text('Obligatorio antes de enviar', style: TextStyle(fontSize: 12, color: AppColors.textoSecundario)),
              const SizedBox(height: 16),
              
              // Lista de opciones de error
              ..._opcionesError.map((opcion) => _buildErrorRadio(opcion)).toList(),
              const SizedBox(height: 24),

              // Campo de comentario
              const Text('Comentario (opcional)', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.textoPrincipal)),
              const SizedBox(height: 8),
              TextField(
                controller: _comentarioController,
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: 'Describe lo que observas...',
                  hintStyle: const TextStyle(color: AppColors.textoTenue),
                  filled: true,
                  fillColor: Colors.white,
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
              const SizedBox(height: 16),

              // Mensaje de advertencia si intenta enviar sin seleccionar
              if (_errorSeleccionado == null)
                Row(
                  children: const [
                    Icon(Icons.info_outline, color: AppColors.terceraCalidad, size: 16),
                    SizedBox(width: 8),
                    Text('Selecciona un error antes de enviar', style: TextStyle(color: AppColors.terceraCalidad, fontSize: 12)),
                  ],
                ),
              const SizedBox(height: 24),
            ],

            // Botón de Enviar
            ElevatedButton(
              onPressed: canSubmit ? _enviarCorreccion : null, // Se deshabilita si no cumple condiciones
              style: ElevatedButton.styleFrom(
                backgroundColor: canSubmit ? AppColors.operario : AppColors.borde,
              ),
              child: Text(
                'Enviar corrección',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: canSubmit ? Colors.white : AppColors.textoSecundario,
                ),
              ),
            ),
          ],
        ),
      ),
      
      // Barra inferior
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1, // 'Escanear' activo porque estamos en el flujo de captura
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

  // Widget para los botones grandes de "Es correcto" / "Está mal"
  Widget _buildToggleButton({required String title, required IconData icon, required bool isSelected, required Color activeColor, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: isSelected ? activeColor.withValues(alpha: 0.1) : Colors.white,
          border: Border.all(color: isSelected ? activeColor : AppColors.borde, width: isSelected ? 2 : 1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: isSelected ? activeColor : AppColors.textoSecundario, size: 20),
            const SizedBox(width: 8),
            Text(
              title,
              style: TextStyle(
                color: isSelected ? activeColor : AppColors.textoSecundario,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget para las opciones de radio
  Widget _buildErrorRadio(String title) {
    return Theme(
      data: Theme.of(context).copyWith(
        unselectedWidgetColor: AppColors.textoSecundario,
      ),
      child: RadioListTile<String>(
        title: Text(title, style: const TextStyle(fontSize: 14, color: AppColors.textoPrincipal)),
        value: title,
        groupValue: _errorSeleccionado,
        activeColor: AppColors.operario,
        contentPadding: EdgeInsets.zero,
        onChanged: (value) {
          setState(() {
            _errorSeleccionado = value;
          });
        },
      ),
    );
  }
}