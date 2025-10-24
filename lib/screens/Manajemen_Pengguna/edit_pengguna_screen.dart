import 'package:flutter/material.dart';

class EditPenggunaScreen extends StatefulWidget {
  final Map<String, String> pengguna;
  const EditPenggunaScreen({super.key, required this.pengguna});

  @override
  State<EditPenggunaScreen> createState() => _EditPenggunaScreenState();
}

class _EditPenggunaScreenState extends State<EditPenggunaScreen> {
  late TextEditingController _nikController;
  late TextEditingController _emailController;
  late TextEditingController _namaController;
  late TextEditingController _noHpController;
  String? _selectedRole;
  String? _status;

  @override
  void initState() {
    super.initState();
    _nikController = TextEditingController(text: widget.pengguna['nik'] ?? '');
    _namaController = TextEditingController(
      text: widget.pengguna['nama'] ?? '',
    );
    _emailController = TextEditingController(
      text: widget.pengguna['email'] ?? '',
    );
    _noHpController = TextEditingController(
      text: widget.pengguna['noHp'] ?? '',
    );
    _selectedRole = widget.pengguna['role'] ?? 'Warga';
    _status = widget.pengguna['status'] ?? 'Diterima';
  }

  @override
  void dispose() {
    _nikController.dispose();
    _emailController.dispose();
    _namaController.dispose();
    _noHpController.dispose();
    super.dispose();
  }

  Future<void> _saveChanges() async {
    final updated = {
      'nik': _nikController.text.trim(),
      'nama': _namaController.text.trim(),
      'email': _emailController.text.trim(),
      'noHp': _noHpController.text.trim(),
      'role': _selectedRole ?? 'Warga',
      'status': _status ?? 'Diterima',
      'no':
          widget.pengguna['no'] ??
          DateTime.now().millisecondsSinceEpoch.toString(),
    };
    Navigator.of(context).pop(updated);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Pengguna')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: ListView(
              children: [
                TextFormField(
                  controller: _nikController,
                  decoration: const InputDecoration(labelText: 'NIK'),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _namaController,
                  decoration: const InputDecoration(labelText: 'Nama'),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _noHpController,
                  decoration: const InputDecoration(labelText: 'No HP'),
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  value: _selectedRole,
                  items: ['Warga', 'Admin', 'Bendahara']
                      .map((r) => DropdownMenuItem(value: r, child: Text(r)))
                      .toList(),
                  decoration: const InputDecoration(labelText: 'Role'),
                  onChanged: (v) => setState(() => _selectedRole = v),
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  value: _status,
                  items: ['Diterima', 'Pending', 'Ditolak']
                      .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                      .toList(),
                  decoration: const InputDecoration(labelText: 'Status'),
                  onChanged: (v) => setState(() => _status = v),
                ),
                const SizedBox(height: 18),
                Row(
                  children: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Batal'),
                    ),
                    const Spacer(),
                    ElevatedButton(
                      onPressed: _saveChanges,
                      child: const Text('Simpan'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
