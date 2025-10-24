import 'package:flutter/material.dart';

class TambahPenggunaScreen extends StatefulWidget {
  final Future<void> Function(Map<String, String>)? onUserAdded;
  const TambahPenggunaScreen({Key? key, this.onUserAdded}) : super(key: key);

  @override
  State<TambahPenggunaScreen> createState() => _TambahPenggunaScreenState();
}

class _TambahPenggunaScreenState extends State<TambahPenggunaScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nik = TextEditingController();
  final _nama = TextEditingController();
  final _email = TextEditingController();
  final _noHp = TextEditingController();
  String? _role;
  String? _status;

  @override
  void dispose() {
    _nik.dispose();
    _nama.dispose();
    _email.dispose();
    _noHp.dispose();
    super.dispose();
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;
    final map = {
      'nik': _nik.text.trim(),
      'nama': _nama.text.trim(),
      'email': _email.text.trim(),
      'noHp': _noHp.text.trim(),
      'role': _role ?? 'Warga',
      'status': _status ?? 'Diterima',
      'no': DateTime.now().millisecondsSinceEpoch.toString(),
    };
    if (widget.onUserAdded != null) widget.onUserAdded!(map);
    Navigator.of(context).pop(map);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      appBar: AppBar(
        title: const Text(
          'Tambah Pengguna',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0.5,
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Container(
            constraints: const BoxConstraints(maxWidth: 500),
            child: Card(
              color: Colors.white,
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 24,
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        'Form Tambah Pengguna',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 22),

                      // NIK
                      TextFormField(
                        controller: _nik,
                        decoration: _inputDecoration('NIK'),
                      ),
                      const SizedBox(height: 14),

                      // Nama
                      TextFormField(
                        controller: _nama,
                        decoration: _inputDecoration('Nama'),
                        validator: (v) => v == null || v.isEmpty
                            ? 'Nama tidak boleh kosong'
                            : null,
                      ),
                      const SizedBox(height: 14),

                      // Email
                      TextFormField(
                        controller: _email,
                        decoration: _inputDecoration('Email'),
                      ),
                      const SizedBox(height: 14),

                      // No HP
                      TextFormField(
                        controller: _noHp,
                        decoration: _inputDecoration('No HP'),
                      ),
                      const SizedBox(height: 14),

                      // Role
                      DropdownButtonFormField<String>(
                        value: _role,
                        items: ['Warga', 'Admin', 'Bendahara']
                            .map(
                              (r) => DropdownMenuItem(value: r, child: Text(r)),
                            )
                            .toList(),
                        decoration: _inputDecoration('Role'),
                        onChanged: (v) => setState(() => _role = v),
                      ),
                      const SizedBox(height: 14),

                      // Status
                      DropdownButtonFormField<String>(
                        value: _status,
                        items: ['Diterima', 'Pending', 'Ditolak']
                            .map(
                              (s) => DropdownMenuItem(value: s, child: Text(s)),
                            )
                            .toList(),
                        decoration: _inputDecoration('Status'),
                        onChanged: (v) => setState(() => _status = v),
                      ),
                      const SizedBox(height: 22),

                      // Buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.grey[700],
                            ),
                            child: const Text('Batal'),
                          ),
                          ElevatedButton(
                            onPressed: _save,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey[800],
                              padding: const EdgeInsets.symmetric(
                                horizontal: 28,
                                vertical: 12,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              elevation: 0,
                            ),
                            child: const Text(
                              'Simpan',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(fontSize: 13, color: Colors.black87),
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.black26),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.black54, width: 1),
      ),
    );
  }
}
