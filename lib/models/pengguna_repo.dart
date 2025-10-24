import 'dart:convert';
import 'dart:collection';
import 'package:shared_preferences/shared_preferences.dart';

class PenggunaRepo {
  static const _storageKey = 'pengguna_list_v1';
  static final List<Map<String, String>> _users = [];

  // Call once at app startup (e.g. from home_page.initState)
  static Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_storageKey);
    if (raw == null) {
      // seed default data
      _users.clear();
      _users.addAll([
        {
          "no": "1",
          "nama": "Rendha Putra Rahmadya",
          "email": "rendhazuper@gmail.com",
          "status": "Diterima",
          "role": "",
        },
        {
          "no": "2",
          "nama": "bla",
          "email": "y@gmail.com",
          "status": "Diterima",
          "role": "",
        },
        {
          "no": "3",
          "nama": "Anti Micin",
          "email": "antimicin3@gmail.com",
          "status": "Diterima",
          "role": "",
        },
        {
          "no": "4",
          "nama": "ijat4",
          "email": "ijat4@gmail.com",
          "status": "Diterima",
          "role": "",
        },
        {
          "no": "5",
          "nama": "ijat3",
          "email": "ijat3@gmail.com",
          "status": "Diterima",
          "role": "",
        },
        {
          "no": "6",
          "nama": "ijat2",
          "email": "ijat2@gmail.com",
          "status": "Diterima",
          "role": "",
        },
        {
          "no": "7",
          "nama": "AFIFAH KHOIRUNNISA",
          "email": "afi@gmail.com",
          "status": "Diterima",
          "role": "",
        },
        {
          "no": "8",
          "nama": "Raudhil Firdaus Naufal",
          "email": "raudhilfirdausn@gmail.com",
          "status": "Diterima",
          "role": "",
        },
        {
          "no": "9",
          "nama": "varizky naldiba rimra",
          "email": "zelectra1011@gmail.com",
          "status": "Diterima",
          "role": "",
        },
      ]);
      await _saveToPrefs(prefs);
    } else {
      try {
        final list = json.decode(raw) as List<dynamic>;
        _users
          ..clear()
          ..addAll(list.map((e) => Map<String, String>.from(e as Map)));
      } catch (_) {
        _users.clear();
      }
    }
  }

  static UnmodifiableListView<Map<String, String>> get users =>
      UnmodifiableListView(_users);

  static Future<void> add(Map<String, String> user) async {
    user["no"] = (_users.length + 1).toString();
    _users.add(Map<String, String>.from(user));
    final prefs = await SharedPreferences.getInstance();
    await _saveToPrefs(prefs);
  }

  static Future<void> updateByNo(String no, Map<String, String> newData) async {
    final idx = _users.indexWhere((u) => u["no"] == no);
    if (idx != -1) {
      newData["no"] = no;
      _users[idx] = Map<String, String>.from(newData);
      final prefs = await SharedPreferences.getInstance();
      await _saveToPrefs(prefs);
    }
  }

  static Future<void> _saveToPrefs(SharedPreferences prefs) async {
    await prefs.setString(_storageKey, json.encode(_users));
  }

  static Future<void> clear() async {
    _users.clear();
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_storageKey);
  }
}
