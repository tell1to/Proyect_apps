import 'package:flutter/material.dart';
import 'screens/welcome_screen.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/project_description_screen.dart';
import 'screens/options_screen.dart';
import 'screens/home_screen.dart';
import 'screens/map_screen.dart';

void main() {
  runApp(const MiRutaApp());
}

class MiRutaApp extends StatefulWidget {
  const MiRutaApp({super.key});

  @override
  State<MiRutaApp> createState() => _MiRutaAppState();
}

class _MiRutaAppState extends State<MiRutaApp> {
  // Controlador para modo claro/oscuro
  final ValueNotifier<ThemeMode> _themeMode = ValueNotifier(ThemeMode.light);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _themeMode,
      builder: (context, ThemeMode currentMode, _) {
        return MaterialApp(
          title: 'MiRuta Inteligente',
          debugShowCheckedModeBanner: false,
          themeMode: currentMode,
          theme: ThemeData(
            brightness: Brightness.light,
            fontFamily: 'Arial',
            scaffoldBackgroundColor: Colors.grey[100],
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromARGB(255, 104, 181, 63),
              brightness: Brightness.light,
            ),
            useMaterial3: true,
          ),
          darkTheme: ThemeData(
            brightness: Brightness.dark,
            fontFamily: 'Arial',
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromARGB(255, 63, 181, 65),
              brightness: Brightness.dark,
            ),
            useMaterial3: true,
          ),

          initialRoute: '/',
          routes: {
            '/':
                (context) => BackgroundWrapper(
                  child: const WelcomeScreen(),
                  themeModeNotifier: _themeMode,
                ),
            '/login':
                (context) => BackgroundWrapper(
                  child: const LoginScreen(),
                  themeModeNotifier: _themeMode,
                ),
            '/register':
                (context) => BackgroundWrapper(
                  child: const RegisterScreen(),
                  themeModeNotifier: _themeMode,
                ),
            '/description':
                (context) => BackgroundWrapper(
                  child: const ProjectDescriptionScreen(),
                  themeModeNotifier: _themeMode,
                ),
            '/options':
                (context) => BackgroundWrapper(
                  child: const OptionsScreen(),
                  themeModeNotifier: _themeMode,
                ),
            '/home':
                (context) => BackgroundWrapper(
                  child: const HomeScreen(),
                  themeModeNotifier: _themeMode,
                ),
            '/map':
                (context) => BackgroundWrapper(
                  child: const MapScreen(),
                  themeModeNotifier: _themeMode,
                ),
          },
        );
      },
    );
  }
}

// Widget que coloca un fondo GIF o color, y añade botón de cambio de modo
class BackgroundWrapper extends StatelessWidget {
  final Widget child;
  final ValueNotifier<ThemeMode> themeModeNotifier;

  const BackgroundWrapper({
    super.key,
    required this.child,
    required this.themeModeNotifier,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Container(
            color:
                Theme.of(context).brightness == Brightness.dark
                    ? Colors.black.withOpacity(0.7)
                    : Colors.white.withOpacity(0.6),
          ),
        ),

        Scaffold(
          backgroundColor: Colors.transparent,
          floatingActionButton: FloatingActionButton(
            backgroundColor: const Color.fromARGB(255, 67, 181, 63),
            foregroundColor: Colors.white,
            tooltip: 'Cambiar modo',
            onPressed: () {
              themeModeNotifier.value =
                  themeModeNotifier.value == ThemeMode.light
                      ? ThemeMode.dark
                      : ThemeMode.light;
            },
            child: Icon(
              themeModeNotifier.value == ThemeMode.dark
                  ? Icons.wb_sunny
                  : Icons.nightlight_round,
            ),
          ),
          body: child,
        ),
      ],
    );
  }
}
