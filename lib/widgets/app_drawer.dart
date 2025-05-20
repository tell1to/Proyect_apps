import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Color.fromARGB(255, 79, 181, 63)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage('https://cdn-icons-png.flaticon.com/512/149/149071.png'),
                  radius: 30,
                ),
                SizedBox(height: 10),
                Text(
                  'MiRuta Inteligente',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home, color: Colors.green),
            title: const Text('Inicio'),
            onTap: () => Navigator.pushNamed(context, '/home'),
          ),
          ListTile(
            leading: const Icon(Icons.map, color: Colors.green),
            title: const Text('Ver Mapa'),
            onTap: () => Navigator.pushNamed(context, '/map'),
          ),
          ListTile(
            leading: const Icon(Icons.description, color: Colors.green),
            title: const Text('Descripción del Proyecto'),
            onTap: () => Navigator.pushNamed(context, '/description'),
          ),
          ListTile(
            leading: const Icon(Icons.login, color: Colors.green),
            title: const Text('Iniciar Sesión'),
            onTap: () => Navigator.pushNamed(context, '/login'),
          ),
          ListTile(
            leading: const Icon(Icons.person_add, color: Colors.green),
            title: const Text('Registrarse'),
            onTap: () => Navigator.pushNamed(context, '/register'),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.exit_to_app, color: Colors.red),
            title: const Text('Cerrar sesión'),
            onTap: () => Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false),
          ),
        ],
      ),
    );
  }
}
