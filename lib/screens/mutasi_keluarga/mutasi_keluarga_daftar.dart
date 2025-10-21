import 'package:flutter/material.dart';

// In-file shared in-memory store (no extra files) used by both daftar and tambah.
final ValueNotifier<List<Map<String, dynamic>>> mutasiKeluargaItems =
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

List<Map<String, dynamic>> _getMutasiItemsCopy() =>
    List<Map<String, dynamic>>.from(mutasiKeluargaItems.value);

/// Append a fully-formed mutasi item (expects fields except 'no' optionally).
void appendMutasi(Map<String, dynamic> item) {
  final list = _getMutasiItemsCopy();
  final nextNo = (list.length + 1).toString();
  final merged = Map<String, dynamic>.from(item);
  merged['no'] = merged['no'] ?? nextNo;
  list.add(merged);
  mutasiKeluargaItems.value = list;
}

class MutasiKeluargaDaftar extends StatefulWidget {
  final void Function(String keluarga)? onSelectKeluarga;

  const MutasiKeluargaDaftar({super.key, this.onSelectKeluarga});

  @override
  State<MutasiKeluargaDaftar> createState() => _MutasiKeluargaDaftarState();
}

class _MutasiKeluargaDaftarState extends State<MutasiKeluargaDaftar> {
  String? _filterStatus;
  String? _filterKeluarga;

  @override
  void initState() {
    super.initState();
    _resetDisplay();
  }

  @override
  void didUpdateWidget(covariant MutasiKeluargaDaftar oldWidget) {
    super.didUpdateWidget(oldWidget);
    _resetDisplay();
  }

  void _resetDisplay() {
    // replaced by store-driven UI; keep filter state consistent
    _applyFilters();
  }

  void _applyFilters() {
    // kept for compatibility; prefer using ValueListenableBuilder in UI
    setState(() {
      // no-op: UI reads directly from store; this keeps filter state intact
    });
  }

  List<Map<String, dynamic>> _applyLocalFilters(
    List<Map<String, dynamic>> source,
  ) {
    return source.where((item) {
      if (_filterStatus != null && _filterStatus!.isNotEmpty) {
        if ((item['jenis'] ?? '') != _filterStatus) return false;
      }
      if (_filterKeluarga != null && _filterKeluarga!.isNotEmpty) {
        if ((item['keluarga'] ?? '') != _filterKeluarga) return false;
      }
      return true;
    }).toList();
  }

  Future<void> _openFilterDialog() async {
    final source = _getMutasiItemsCopy();
    final keluargaOptions = source
        .map((e) => e['keluarga']?.toString() ?? '')
        .toSet()
        .toList();

    String? tempStatus = _filterStatus;
    String? tempKeluarga = _filterKeluarga;

    await showDialog<void>(
      context: context,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (ctx, setStateDialog) {
            return AlertDialog(
              title: const Text('Filter Mutasi Keluarga'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: const Text('Status'),
                  ),
                  const SizedBox(height: 8),
                  DropdownButton<String?>(
                    value: tempStatus,
                    isExpanded: true,
                    items: <DropdownMenuItem<String?>>[
                      DropdownMenuItem<String?>(
                        value: null,
                        child: const Text('-- Pilih Status --'),
                      ),
                      DropdownMenuItem<String?>(
                        value: 'Keluar Wilayah',
                        child: const Text('Keluar Wilayah'),
                      ),
                      DropdownMenuItem<String?>(
                        value: 'Pindah Rumah',
                        child: const Text('Pindah Rumah'),
                      ),
                      DropdownMenuItem<String?>(
                        value: 'Pindah Masuk',
                        child: const Text('Pindah Masuk'),
                      ),
                    ],
                    onChanged: (v) => setStateDialog(() => tempStatus = v),
                  ),
                  const SizedBox(height: 12),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: const Text('Keluarga'),
                  ),
                  const SizedBox(height: 8),
                  DropdownButton<String?>(
                    value: tempKeluarga,
                    isExpanded: true,
                    items: <DropdownMenuItem<String?>>[
                      DropdownMenuItem<String?>(
                        value: null,
                        child: const Text('-- Pilih Keluarga --'),
                      ),
                      ...keluargaOptions.map(
                        (k) =>
                            DropdownMenuItem<String?>(value: k, child: Text(k)),
                      ),
                    ],
                    onChanged: (v) => setStateDialog(() => tempKeluarga = v),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    setState(() {
                      _filterStatus = null;
                      _filterKeluarga = null;
                      _applyFilters();
                    });
                    Navigator.of(ctx).pop();
                  },
                  child: const Text('Reset Filter'),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _filterStatus = tempStatus;
                      _filterKeluarga = tempKeluarga;
                      _applyFilters();
                    });
                    Navigator.of(ctx).pop();
                  },
                  child: const Text('Terapkan'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 🔹 Header + tombol filter
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Daftar Mutasi Keluarga',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                ElevatedButton.icon(
                  onPressed: _openFilterDialog,
                  icon: const Icon(Icons.filter_list, size: 18),
                  label: const Text('Filter'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black87,
                    elevation: 0,
                    side: const BorderSide(color: Color(0xFFE0E0E0)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // 🔹 Kontainer tabel
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFE0E0E0)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Header tabel
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 14,
                        horizontal: 16,
                      ),
                      color: const Color(0xFFF9FAFB),
                      child: Row(
                        children: const [
                          Expanded(
                            flex: 1,
                            child: Text(
                              'NO',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              'TANGGAL',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Text(
                              'KELUARGA',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Text(
                              'JENIS MUTASI',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              'AKSI',
                              style: TextStyle(fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Divider(height: 1, color: Color(0xFFE0E0E0)),

                    // Isi data tabel (listens to store changes)
                    Expanded(
                      child: ValueListenableBuilder<List<Map<String, dynamic>>>(
                        valueListenable: mutasiKeluargaItems,
                        builder: (context, list, _) {
                          final source = _applyLocalFilters(list);
                          return ListView.separated(
                            itemCount: source.length,
                            separatorBuilder: (context, index) => const Divider(
                              height: 1,
                              color: Color(0xFFE0E0E0),
                            ),
                            itemBuilder: (context, index) {
                              final item = source[index];
                              return InkWell(
                                onTap: () {
                                  final keluargaName = item['keluarga'] ?? '';
                                  if (widget.onSelectKeluarga != null) {
                                    widget.onSelectKeluarga!(keluargaName);
                                  }
                                },
                                child: Container(
                                  color: index.isEven
                                      ? Colors.white
                                      : const Color(0xFFF9FAFB),
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 14,
                                    horizontal: 16,
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Text(item['no'] ?? ''),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Text(item['tanggal'] ?? ''),
                                      ),
                                      Expanded(
                                        flex: 3,
                                        child: Text(item['keluarga'] ?? ''),
                                      ),
                                      Expanded(
                                        flex: 3,
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 12,
                                              vertical: 6,
                                            ),
                                            decoration: BoxDecoration(
                                              color:
                                                  item['jenisColor'] ??
                                                  (() {
                                                    final jenis =
                                                        (item['jenis'] ?? '')
                                                            .toString()
                                                            .toLowerCase()
                                                            .trim();
                                                    if (jenis ==
                                                        'keluar wilayah') {
                                                      return Colors
                                                          .red
                                                          .shade100;
                                                    }
                                                    if (jenis ==
                                                            'pindah rumah' ||
                                                        jenis == 'pindah masuk') {
                                                      return Colors
                                                          .green
                                                          .shade100;
                                                    }
                                                    return Colors
                                                        .green
                                                        .shade100;
                                                  })(),
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            child: Text(
                                              item['jenis'] ?? '',
                                              style: TextStyle(
                                                color:
                                                    item['textColor'] ??
                                                    (() {
                                                      final jenis =
                                                          (item['jenis'] ?? '')
                                                              .toString()
                                                              .toLowerCase()
                                                              .trim();
                                                      if (jenis ==
                                                          'keluar wilayah') {
                                                        return Colors
                                                            .red
                                                            .shade700;
                                                      }
                                                      if (jenis ==
                                                              'pindah rumah' ||
                                                          jenis ==
                                                              'pindah masuk') {
                                                        return Colors
                                                            .green
                                                            .shade700;
                                                      }
                                                      return Colors
                                                          .green
                                                          .shade700;
                                                    })(),
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: PopupMenuButton<String>(
                                            icon: const Icon(
                                              Icons.more_horiz,
                                              color: Colors.black54,
                                            ),
                                            onSelected: (value) {
                                              if (value == 'detail') {
                                                showDialog(
                                                  context: context,
                                                  builder: (ctx) => AlertDialog(
                                                    title: const Text(
                                                      'Detail Mutasi',
                                                    ),
                                                    content: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          'Tanggal: ${item['tanggal'] ?? '-'}',
                                                        ),
                                                        const SizedBox(
                                                          height: 8,
                                                        ),
                                                        Text(
                                                          'Keluarga: ${item['keluarga'] ?? '-'}',
                                                        ),
                                                        const SizedBox(
                                                          height: 8,
                                                        ),
                                                        Text(
                                                          'Jenis: ${item['jenis'] ?? '-'}',
                                                        ),
                                                        const SizedBox(
                                                          height: 8,
                                                        ),
                                                        Text(
                                                          'Alasan: ${item['alasan'] != null && (item['alasan'] as String).isNotEmpty ? item['alasan'] : '-'}',
                                                        ),
                                                      ],
                                                    ),
                                                    actions: [
                                                      TextButton(
                                                        onPressed: () =>
                                                            Navigator.of(
                                                              ctx,
                                                            ).pop(),
                                                        child: const Text(
                                                          'Tutup',
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              }
                                            },
                                            itemBuilder: (context) => [
                                              const PopupMenuItem(
                                                value: 'detail',
                                                child: Text('Detail'),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
