import '../models/user.dart';

class UserService {

  User? _currentUser;
  User? get currentUser => _currentUser;

  // Crear instancia única
  static final UserService _instance = UserService._internal();

  factory UserService() {
    return _instance;
  }

  UserService._internal();

  // Lista de usuarios locales
  final List<User> _registeredUsers = [];

  // Métodos de registro y login
  String? register(String email, String password) {
    final userExists = _registeredUsers.any((user) => user.email == email);
    if (userExists) {
      return 'El email ya está registrado';
    }
    _registeredUsers.add(User(email: email, password: password));
    return null;
  }
  String? login(String email, String password) {
    final user = _registeredUsers.firstWhere(
      (user) => user.email == email && user.password == password,
      orElse: () => User(email: '', password: ''),
    );

    if (user.email.isEmpty) {
      return 'Usuario o contraseña incorrectos';
    }

    _currentUser = user; // ✅ Guardar usuario activo
    return null;
  }
  void logout() {
  _currentUser = null;
  } 

}

