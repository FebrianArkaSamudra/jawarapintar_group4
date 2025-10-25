import 'package:flutter/material.dart';
import 'mutasi_keluarga_daftar.dart' show appendMutasi;

class MutasiKeluargaTambah extends StatefulWidget {
  final String? initialKeluarga;

  const MutasiKeluargaTambah({super.key, this.initialKeluarga});

  @override
  State<MutasiKeluargaTambah> createState() => _MutasiKeluargaTambahState();
}

class _MutasiKeluargaTambahState extends State<MutasiKeluargaTambah> {
  String? _jenisMutasi;
  String? _keluarga;
  final TextEditingController _alasanController = TextEditingController();
  DateTime? _tanggalMutasi;
  final _formKey = GlobalKey<FormState>();
  bool _showDateError = false;

  @override
  void dispose() {
    _alasanController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    if (widget.initialKeluarga != null) {
      _keluarga = widget.initialKeluarga;
    }
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _tanggalMutasi ?? now,
      firstDate: DateTime(now.year - 10),
      lastDate: DateTime(now.year + 10),
    );
    if (picked != null) {
      setState(() {
        _tanggalMutasi = picked;
        _showDateError = false; // hide error once user picks a date
      });
    }
  }

  String _formatLongDate(DateTime d) {
    const months = [
      'Januari',
      'Februari',
      'Maret',
      'April',
      'Mei',
      'Juni',
      'Juli',
      'Agustus',
      'September',
      'Oktober',
      'November',
      'Desember',
    ];
    return '${d.day} ${months[d.month - 1]} ${d.year}';
  }

  void _resetForm() {
    setState(() {
      _jenisMutasi = null;
      _keluarga = null;
      _alasanController.clear();
      _tanggalMutasi = null;
      _showDateError = false;
    });
  }

  void _save() {
    // For now just print values. Integrate with backend later.
    debugPrint(
      'Simpan Mutasi: jenis=$_jenisMutasi, keluarga=$_keluarga, alasan=${_alasanController.text}, tanggal=$_tanggalMutasi',
    );

    // validate required fields (form validators)
    final isValid = _formKey.currentState?.validate() ?? false;
    // show date error only after validation attempt
    setState(() {
      _showDateError = _tanggalMutasi == null;
    });
    if (!isValid || _tanggalMutasi == null) return;

    final newItem = {
      'tanggal': _tanggalMutasi == null ? '' : _formatLongDate(_tanggalMutasi!),
      'keluarga': _keluarga ?? '',
      'jenis': _jenisMutasi ?? '',
      'alasan': _alasanController.text,
    };

    // Build full item with color mapping and add to notifier
    final jenis = (newItem['jenis'] ?? '').toString();
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

    appendMutasi({
      'tanggal': newItem['tanggal'] ?? '',
      'keluarga': newItem['keluarga'] ?? '',
      'jenis': jenis,
      'alasan': newItem['alasan'] ?? '',
      'jenisColor': bg,
      'textColor': text,
    });
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Data mutasi disimpan')));
    // After save, navigate back if possible
    if (Navigator.canPop(context)) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    // Simple static options to match screenshot look (compact)
    final jenisOptions = ['Keluar Wilayah', 'Pindah Rumah', 'Pindah Masuk'];
    final keluargaOptions = [
      'Keluarga Ijat',
      'Keluarga Mara Nunez',
      'Keluarga Siti',
    ];

    Widget label(String text) => Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        text,
        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
      ),
    );

    final inputDecoration = InputDecoration(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      isDense: false,
      contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 14),
      hintStyle: const TextStyle(fontSize: 14, color: Color(0xFF9AA0A6)),
    );

    String formatLongDate(DateTime d) => _formatLongDate(d);

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1200),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 18.0),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 0,
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Form(
                key: _formKey,
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final isNarrow = constraints.maxWidth < 700;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Buat Mutasi Keluarga',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 22),

                        // Jenis & Keluarga: side-by-side on wide, stacked on narrow
                        if (!isNarrow)
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    label('Jenis Mutasi'),
                                    DropdownButtonFormField<String>(
                                      initialValue: _jenisMutasi,
                                      items: [
                                        const DropdownMenuItem(
                                          value: null,
                                          child: Text(
                                            '-- Pilih Jenis Mutasi --',
                                          ),
                                        ),
                                        ...jenisOptions.map(
                                          (e) => DropdownMenuItem(
                                            value: e,
                                            child: Text(
                                              e,
                                              style: const TextStyle(
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                      onChanged: (v) =>
                                          setState(() => _jenisMutasi = v),
                                      decoration: inputDecoration,
                                      validator: (v) {
                                        if (v == null || v.isEmpty) {
                                          return 'Jenis mutasi wajib dipilih';
                                        }
                                        return null;
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 18),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    label('Keluarga'),
                                    DropdownButtonFormField<String>(
                                      initialValue: _keluarga,
                                      items: [
                                        const DropdownMenuItem(
                                          value: null,
                                          child: Text('-- Pilih Keluarga --'),
                                        ),
                                        ...keluargaOptions.map(
                                          (e) => DropdownMenuItem(
                                            value: e,
                                            child: Text(
                                              e,
                                              style: const TextStyle(
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                      onChanged: (v) =>
                                          setState(() => _keluarga = v),
                                      decoration: inputDecoration.copyWith(
                                        enabledBorder: inputDecoration.border,
                                      ),
                                      validator: (v) {
                                        if (v == null || v.isEmpty) {
                                          return 'Keluarga wajib dipilih';
                                        }
                                        return null;
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        else ...[
                          label('Jenis Mutasi'),
                          DropdownButtonFormField<String>(
                            initialValue: _jenisMutasi,
                            items: [
                              const DropdownMenuItem(
                                value: null,
                                child: Text('-- Pilih Jenis Mutasi --'),
                              ),
                              ...jenisOptions.map(
                                (e) => DropdownMenuItem(
                                  value: e,
                                  child: Text(
                                    e,
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                ),
                              ),
                            ],
                            onChanged: (v) => setState(() => _jenisMutasi = v),
                            decoration: inputDecoration,
                            validator: (v) {
                              if (v == null || v.isEmpty) {
                                return 'Jenis mutasi wajib dipilih';
                              }
                              return null;
                            },
                          ),

                          const SizedBox(height: 18),
                          label('Keluarga'),
                          DropdownButtonFormField<String>(
                            initialValue: _keluarga,
                            items: [
                              const DropdownMenuItem(
                                value: null,
                                child: Text('-- Pilih Keluarga --'),
                              ),
                              ...keluargaOptions.map(
                                (e) => DropdownMenuItem(
                                  value: e,
                                  child: Text(
                                    e,
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                ),
                              ),
                            ],
                            onChanged: (v) => setState(() => _keluarga = v),
                            decoration: inputDecoration.copyWith(
                              enabledBorder: inputDecoration.border,
                            ),
                            validator: (v) {
                              if (v == null || v.isEmpty) {
                                return 'Keluarga wajib dipilih';
                              }
                              return null;
                            },
                          ),
                        ],

                        const SizedBox(height: 18),
                        label('Alasan Mutasi'),
                        TextFormField(
                          controller: _alasanController,
                          maxLines: 4,
                          decoration: inputDecoration.copyWith(
                            hintText: 'Masukkan alasan disini...',
                          ),
                          style: const TextStyle(fontSize: 14),
                        ),

                        const SizedBox(height: 18),
                        label('Tanggal Mutasi'),
                        Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: InkWell(
                                    onTap: _pickDate,
                                    child: InputDecorator(
                                      decoration: inputDecoration,
                                      child: Text(
                                        _tanggalMutasi == null
                                            ? '--/--/----'
                                            : formatLongDate(_tanggalMutasi!),
                                        style: const TextStyle(fontSize: 14),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                IconButton(
                                  onPressed: () =>
                                      setState(() => _tanggalMutasi = null),
                                  icon: const Icon(Icons.close, size: 20),
                                  padding: const EdgeInsets.all(8),
                                ),
                                IconButton(
                                  onPressed: _pickDate,
                                  icon: const Icon(
                                    Icons.calendar_today,
                                    size: 20,
                                  ),
                                  padding: const EdgeInsets.all(8),
                                ),
                              ],
                            ),
                            // tanggal error text (only show after save attempt)
                            if (_showDateError)
                              Padding(
                                padding: const EdgeInsets.only(top: 6.0),
                                child: Text(
                                  'Tanggal mutasi wajib diisi',
                                  style: TextStyle(
                                    color: Colors.red.shade700,
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                          ],
                        ),

                        const SizedBox(height: 22),
                        Row(
                          children: [
                            ElevatedButton(
                              onPressed: _save,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Theme.of(context).primaryColor,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 18,
                                  vertical: 12,
                                ),
                                minimumSize: const Size(0, 42),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: const Text(
                                'Simpan',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            OutlinedButton(
                              onPressed: _resetForm,
                              style: OutlinedButton.styleFrom(
                                backgroundColor: Colors.white,
                                side: BorderSide(color: Colors.grey.shade300),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 12,
                                ),
                                minimumSize: const Size(0, 42),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: Text(
                                'Reset',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.grey.shade800,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
