import 'package:flutter/material.dart';
import '../widgets/app_drawer.dart';

class OptionsScreen extends StatelessWidget {
  const OptionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: const Text('Menú de Opciones'),
        backgroundColor: const Color.fromARGB(255, 79, 181, 63),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 4,
            child: ListTile(
              leading: const Icon(Icons.description, color: Color.fromARGB(255, 65, 181, 63)),
              title: const Text('Ver descripción del proyecto'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () => Navigator.pushNamed(context, '/description'),
            ),
          ),
          const SizedBox(height: 10),
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 4,
            child: ListTile(
              leading: const Icon(Icons.directions_bus, color: Color.fromARGB(255, 77, 181, 63)),
              title: const Text('Planificar una ruta (futuro)'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Puedes colocar aquí la ruta al planificador cuando lo implementes
              },
            ),
          ),
          const SizedBox(height: 10),
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 4,
            child: ListTile(
              leading: const Icon(Icons.map, color: Color.fromARGB(255, 63, 142, 181)),
              title: const Text('Ver Mapa'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () => Navigator.pushNamed(context, '/map'),
            ),
          ),
          const SizedBox(height: 10),
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 4,
            child: ListTile(
              leading: const Icon(Icons.exit_to_app, color: Colors.red),
              title: const Text('Cerrar sesión'),
              trailing: const Icon(Icons.arrow_back),
              onTap: () => Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false),
            ),
          ),
        ],
      ),
    );
  }
}
