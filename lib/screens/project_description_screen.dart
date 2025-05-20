import 'package:flutter/material.dart';

class ProjectDescriptionScreen extends StatelessWidget {
  const ProjectDescriptionScreen({super.key});

  Widget _buildCard({
    required BuildContext context,
    required IconData icon,
    required String title,
    required Widget content,
    Color iconColor = const Color.fromARGB(255, 59, 197, 57),
  }) {
    return Card(
      elevation: 6,
      margin: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          leading: CircleAvatar(
            backgroundColor: iconColor.withOpacity(0.1),
            child: Icon(icon, color: iconColor),
          ),
          title: Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          children: [Padding(padding: const EdgeInsets.all(16), child: content)],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: const Color(0xFFFAFAF0),
      appBar: AppBar(
        title: const Text('Descripción del Proyecto'),
        backgroundColor: const Color.fromARGB(255, 65, 181, 63),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: const [
                  Icon(Icons.info_outline, size: 80, color: Color.fromARGB(255, 71, 181, 63)),
                  SizedBox(height: 10),
                  Text(
                    'MiRuta Inteligente',
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
            _buildCard(
              context: context,
              icon: Icons.description,
              title: 'Resumen del Proyecto',
              content: const Text(
                'MiRuta Inteligente es una aplicación informativa que permite planificar rutas óptimas combinando buses, caminatas y otros medios de transporte. '
                'Está pensada para ayudar a estudiantes, trabajadores y usuarios urbanos a optimizar sus desplazamientos. '
                'Ofrece rutas clasificadas por rapidez o economía e integra Google Maps para su visualización.',
                style: TextStyle(fontSize: 16),
              ),
            ),
            _buildCard(
              context: context,
              icon: Icons.flag,
              title: 'Objetivo General',
              iconColor: Colors.green,
              content: const Text(
                'Desarrollar una aplicación móvil en Flutter denominada “MiRuta Inteligente”, que permita planificar rutas óptimas combinando buses, caminatas y otros medios de transporte, '
                'mediante una interfaz interactiva con filtros y conexión a Google Maps, para facilitar a los usuarios urbanos la elección de recorridos rápidos o económicos en función de sus preferencias.',
                style: TextStyle(fontSize: 16),
              ),
            ),
            _buildCard(
              context: context,
              icon: Icons.check_circle,
              title: 'Objetivos Específicos',
              iconColor: Colors.teal,
              content: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('• Diseñar e implementar una interfaz de usuario que permita ingresar el origen y destino.',
                      style: TextStyle(fontSize: 16)),
                  SizedBox(height: 6),
                  Text('• Integrar la funcionalidad de rutas sugeridas conectadas con Google Maps, clasificadas por rapidez o economía.',
                      style: TextStyle(fontSize: 16)),
                  SizedBox(height: 6),
                  Text('• Establecer la estructura base del sistema para futuras integraciones de datos de tráfico, clima y otros medios de transporte.',
                      style: TextStyle(fontSize: 16)),
                ],
              ),
            ),
            _buildCard(
              context: context,
              icon: Icons.lightbulb_outline,
              title: 'Justificación',
              iconColor: Colors.orange,
              content: const Text(
                'La movilidad urbana representa un desafío diario para millones de personas, quienes deben enfrentar tiempos de espera, transbordos incómodos y desconocimiento de rutas óptimas. '
                'MiRuta Inteligente busca mitigar estos problemas proporcionando una herramienta accesible que permita planificar desplazamientos combinando diferentes medios de transporte. '
                'Aunque el tiempo de desarrollo es limitado, se logrará construir una versión funcional que sirva como punto de partida para una solución más robusta en el futuro.',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
