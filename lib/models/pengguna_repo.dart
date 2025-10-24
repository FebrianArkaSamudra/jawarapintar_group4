import 'dart:convert';
import 'dart:collection';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class PenggunaRepo {
  // simple in-memory stub so daftar_pengguna compiles and runs
  static final List<Map<String, dynamic>> _store = <Map<String, dynamic>>[
    {
      'no': '1',
      'nama': 'Rendha Putra Rahmadya',
      'email': 'rendhazuper@gmail.com',
      'noHp': '081234567890',
      'role': 'Warga',
      'status': 'Diterima',
    },
    {
      'no': '2',
      'nama': 'Afifah Khoirunnisa',
      'email': 'afi@gmail.com',
      'noHp': '081298765432',
      'role': 'Warga',
      'status': 'Diterima',
    },
  ];

  static Future<void> init() async {
    // no-op for stub
  }

  // getAll may be sync or async in different implementations — support both
  static Future<dynamic> getAll() async {
    return List<dynamic>.from(_store);
  }

  static Future<void> add(Map<String, String> user) async {
    final id = user['no'] ?? '';
    if (id.isNotEmpty) {
      final idx = _store.indexWhere((e) => (e['no'] ?? '') == id);
      if (idx >= 0) {
        _store[idx] = Map<String, dynamic>.from(user);
        return;
      }
    }
    final Map<String, dynamic> u = Map<String, dynamic>.from(user);
    u['no'] = u['no'] ?? DateTime.now().millisecondsSinceEpoch.toString();
    _store.insert(0, u);
  }

  static Future<void> delete(String id) async {
    _store.removeWhere((e) => (e['no'] ?? '') == id);
  }
}
