import 'package:flutter/material.dart';

class MutasiKeluargaStore {
  MutasiKeluargaStore._();
  static final MutasiKeluargaStore instance = MutasiKeluargaStore._();

  final ValueNotifier<List<Map<String, dynamic>>> items =
      ValueNotifier<List<Map<String, dynamic>>>([
        {
          'no': '1',
          'tanggal': '15 Oktober 2025',
          'keluarga': 'Keluarga Ijat',
          'jenis': 'Keluar Wilayah',
          'jenisColor': Colors.red.shade100,
          'textColor': Colors.red.shade700,
        },
        {
          'no': '2',
          'tanggal': '30 September 2025',
          'keluarga': 'Keluarga Mara Nunez',
          'jenis': 'Pindah Rumah',
          'jenisColor': Colors.green.shade100,
          'textColor': Colors.green.shade700,
        },
        {
          'no': '3',
          'tanggal': '24 Oktober 2026',
          'keluarga': 'Keluarga Ijat',
          'jenis': 'Pindah Rumah',
          'jenisColor': Colors.green.shade100,
          'textColor': Colors.green.shade700,
        },
      ]);

  List<Map<String, dynamic>> getAll() =>
      List<Map<String, dynamic>>.from(items.value);

  void add(Map<String, dynamic> raw) {
    final list = getAll();
    final nextNo = (list.length + 1).toString();
    final jenis = (raw['jenis'] ?? '').toString();
    Color bg;
    Color text;
    final jenisLower = jenis.toLowerCase().trim();
    if (jenisLower == 'keluar wilayah') {
      bg = Colors.red.shade100;
      text = Colors.red.shade700;
    } else if (jenisLower == 'pindah rumah' || jenisLower == 'pindah masuk') {
      bg = Colors.green.shade100;
      text = Colors.green.shade700;
    } else {
      bg = Colors.green.shade100;
      text = Colors.green.shade700;
    }

    final item = {
      'no': nextNo,
      'tanggal': raw['tanggal'] ?? '',
      'keluarga': raw['keluarga'] ?? '',
      'jenis': jenis,
      'alasan': raw['alasan'] ?? '',
      'jenisColor': raw['jenisColor'] ?? bg,
      'textColor': raw['textColor'] ?? text,
    };

    list.add(item);
    items.value = list;
  }
}