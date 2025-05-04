import 'package:flutter/material.dart';
import '../services/user_service.dart';
import '../widgets/top_bar.dart';
import '../widgets/bottom_nav_bar.dart';

class ProfileScreen extends StatelessWidget {
  final UserService _userService = UserService();
  final int _currentIndex = 3;

  void _logout(BuildContext context) {
    _userService.logout();
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    final user = _userService.currentUser;

    return Scaffold(
      appBar: TopBar(
        searchController: TextEditingController(),
        onSearchChanged: (_) {},
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: user == null
            ? Center(child: Text('No hay sesión activa'))
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Perfil de Usuario',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  Text('Email: ${user.email}', style: TextStyle(fontSize: 18)),
                  Spacer(),
                  Center(
                    child: ElevatedButton.icon(
                      onPressed: () => _logout(context),
                      icon: Icon(Icons.logout),
                      label: Text('Cerrar Sesión'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        minimumSize: Size(double.infinity, 50),
                      ),
                    ),
                  ),
                ],
              ),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushReplacementNamed(context, '/home');
              break;
            case 1:
              Navigator.pushReplacementNamed(context, '/category');
              break;
            case 2:
              Navigator.pushReplacementNamed(context, '/cart');
              break;
            case 3:
              break; // Ya estamos aquí
          }
        },
      ),
    );
  }
}
