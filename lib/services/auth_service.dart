import 'dart:async';

class AuthService {
  // simple in-memory auth simulation
  static Future<Map<String, dynamic>> login(
    String email,
    String password,
  ) async {
    // emulate network delay
    await Future.delayed(const Duration(milliseconds: 400));

    if (email.isEmpty || password.isEmpty) {
      return {'success': false, 'message': 'Email dan password harus diisi'};
    }

    // Very small demo: if email contains 'admin' -> admin, else normal user
    if (email == 'admin@jawara.test' && password == 'admin') {
      return {'success': true, 'role': 'admin'};
    }

    if (email.endsWith('@jawara.test') && password == 'password') {
      return {'success': true, 'role': 'user'};
    }

    return {'success': false, 'message': 'Email atau password salah'};
  }
}
