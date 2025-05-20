import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  String name = '', email = '', password = '';
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: const Color(0xFFF7F7F7),
      appBar: AppBar(
        title: const Text('Registro de Usuario'),
        backgroundColor: const Color.fromARGB(255, 73, 181, 63),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            children: [
              const CircleAvatar(
                radius: 40,
                backgroundColor: Color.fromARGB(255, 69, 181, 63),
                child: Icon(Icons.person_add, size: 40, color: Colors.white),
              ),
              const SizedBox(height: 20),
              Card(
                elevation: 8,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.person),
                            labelText: 'Nombre completo',
                          ),
                          validator: (value) => value!.isEmpty ? 'Campo obligatorio' : null,
                          onSaved: (value) => name = value!,
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.email),
                            labelText: 'Correo electrónico',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) return 'Campo requerido';
                            if (!value.contains('@')) return 'Correo inválido';
                            return null;
                          },
                          onSaved: (value) => email = value!,
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          obscureText: !showPassword,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.lock),
                            labelText: 'Contraseña',
                            suffixIcon: IconButton(
                              icon: Icon(showPassword
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                              onPressed: () {
                                setState(() {
                                  showPassword = !showPassword;
                                });
                              },
                            ),
                          ),
                          validator: (value) =>
                              value != null && value.length < 6 ? 'Mínimo 6 caracteres' : null,
                          onSaved: (value) => password = value!,
                        ),
                        const SizedBox(height: 24),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            icon: const Icon(Icons.person_add_alt),
                            label: const Text('Registrarse'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color.fromARGB(255, 73, 181, 63),
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
                                Navigator.pushNamed(context, '/home');
                              }
                            },
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
      ),
    );
  }
}
