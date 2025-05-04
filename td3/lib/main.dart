import 'package:flutter/material.dart';

// Importa tus pantallas
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/home_screen.dart';
import 'screens/cart_screen.dart';
import 'screens/category_screen.dart';
import 'screens/profile_screen.dart';

import 'widgets/top_bar.dart';
import 'widgets/bottom_nav_bar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tienda Flutter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginScreen(),
        '/register': (context) => RegisterScreen(),
        '/home': (context) => MainApp(),
        '/category': (context) => CategoryScreen(),
        '/cart': (context) => CartScreen(),
        '/profile': (context) => ProfileScreen(),
      },
    );
  }
}

class MainApp extends StatefulWidget {
  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int _currentIndex = 0;

  final TextEditingController _searchController = TextEditingController();

  // Solo las pantallas que se quedan dentro del MainApp (sin barras duplicadas)
  final List<Widget> _screens = [
    HomeScreen(searchController: TextEditingController()),
    CategoryScreen(),                                       // index 0
    CartScreen(),                                           // index 1
    ProfileScreen(),                                        // index 2
  ];

  void _onTap(int index) {
    if (index == 1) {
      // Ir a categorías mediante ruta externa
      Navigator.pushReplacementNamed(context, '/category');
      return;
    }

    setState(() {
      _currentIndex = index > 1 ? index - 1 : index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(
        searchController: _searchController,
        onSearchChanged: (query) {}, // opcional, si Home usa esto
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex == 0 ? 0 : _currentIndex + 1, // para que se mantenga el índice correcto
        onTap: _onTap,
      ),
    );
  }
}
