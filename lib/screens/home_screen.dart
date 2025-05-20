import 'package:flutter/material.dart';
import '../widgets/app_drawer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: const Text('Inicio - Rutas del Norte de Quito'),
        backgroundColor: const Color.fromARGB(255, 69, 181, 63), // no modificar
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          
          Row(
            children: const [
              Icon(Icons.directions_bus, color: Colors.indigo, size: 30),
              SizedBox(width: 10),
              Text(
                'Bienvenidos a MiRuta Inteligente',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            'En esta pantalla podrás explorar información detallada de los principales buses que transitan por la zona norte de Quito. Revisa rutas, horarios y puntos seguros antes de viajar.',
            style: TextStyle(fontSize: 16, color: isDarkMode ? Colors.white70 : Colors.black87),
          ),
          const SizedBox(height: 24),

          // 🚌 Tarjetas de buses
          _buildBusCard(
            context,
            isDarkMode,
            imageAsset: 'images/articulados.jpg',
            ruta: 'Carcelén - La Y - El Recreo',
            cooperativa: 'Metrobús Q',
            horario: 'Lunes a sábado, 05h30 - 21h00',
            lugaresSeguros: 'La Y, El Labrador, La Ofelia',
            salida: 'Carcelén',
            llegada: 'El Recreo',
          ),
          _buildBusCard(
            context,
            isDarkMode,
            imageAsset: 'images/Capturadepantalla2025-05-19234553.png',
            ruta: 'La Ofelia - El Ejido - Quitumbe',
            cooperativa: 'Trolebús',
            horario: 'Todos los días, 06h00 - 22h00',
            lugaresSeguros: 'La Ofelia, Estación El Ejido',
            salida: 'La Ofelia',
            llegada: 'Quitumbe',
          ),
          _buildBusCard(
            context,
            isDarkMode,
            imageAsset: 'assets/images/bus3.jpg',
            ruta: 'La Ofelia - El Inca',
            cooperativa: 'TransHemisor',
            horario: 'Lunes a viernes, 06h00 - 20h00',
            lugaresSeguros: 'El Inca, Mariscal',
            salida: 'La Ofelia',
            llegada: 'El Inca',
          ),
          _buildBusCard(
            context,
            isDarkMode,
            imageAsset: 'images/03autobus-flordelvalle-aloag.jpg',
            ruta: 'La Ofelia - Av. Occidental - La Rumiñahui',
            cooperativa: 'Coop. Flor del Valle',
            horario: 'Lunes a domingo, 05h30 - 21h30',
            lugaresSeguros: 'La Occidental, San Carlos',
            salida: 'La Ofelia',
            llegada: 'La Rumiñahui',
          ),
          _buildBusCard(
            context,
            isDarkMode,
            imageAsset: 'assets/images/bus5.jpg',
            ruta: 'El Condado - Cotocollao - Santa Clara',
            cooperativa: 'Coop. San Cristóbal',
            horario: 'Lunes a sábado, 06h00 - 20h30',
            lugaresSeguros: 'Condado, Cotocollao',
            salida: 'El Condado',
            llegada: 'Santa Clara',
          ),
          _buildBusCard(
            context,
            isDarkMode,
            imageAsset: 'images/OIP.jpg',
            ruta: 'San Antonio - Cotocollao - Iñaquito',
            cooperativa: 'Coop. Vencedores',
            horario: 'Lunes a viernes, 06h00 - 19h00',
            lugaresSeguros: 'Cotocollao, Iñaquito',
            salida: 'San Antonio',
            llegada: 'Iñaquito',
          ),

          const SizedBox(height: 32),
          // 🔜 Próximamente
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.schedule, color: Colors.grey),
              SizedBox(width: 8),
              Text(
                '¡Más rutas serán añadidas próximamente!',
                style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBusCard(
    BuildContext context,
    bool isDarkMode, {
    required String imageAsset,
    required String ruta,
    required String cooperativa,
    required String horario,
    required String lugaresSeguros,
    required String salida,
    required String llegada,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
        boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 6)],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: ExpansionTile(
                title: Text(
                  cooperativa,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
                children: [
                  _buildInfoRow('Ruta', ruta, isDarkMode),
                  _buildInfoRow('Horario', horario, isDarkMode),
                  _buildInfoRow('Zonas seguras', lugaresSeguros, isDarkMode),
                  _buildInfoRow('Desde', salida, isDarkMode),
                  _buildInfoRow('Hasta', llegada, isDarkMode),
                ],
              ),
            ),
          ),
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(12),
              bottomRight: Radius.circular(12),
            ),
            child: Image.asset(
              imageAsset,
              height: 140,
              width: 140,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, bool isDarkMode) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$label: ",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: isDarkMode ? Colors.white : Colors.black,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(color: isDarkMode ? Colors.white70 : Colors.black87),
            ),
          ),
        ],
      ),
    );
  }
}
