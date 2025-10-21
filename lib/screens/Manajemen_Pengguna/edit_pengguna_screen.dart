import 'package:flutter/material.dart';
import '../../models/pengguna_repo.dart';

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
    _nikController = TextEditingController(text: widget.pengguna["no"] ?? '');
    _emailController = TextEditingController(
      text: widget.pengguna["email"] ?? '',
    );
    _namaController = TextEditingController(
      text: widget.pengguna["nama"] ?? '',
    );
    _noHpController = TextEditingController(
      text: widget.pengguna["noHp"] ?? '',
    );
    _selectedRole = widget.pengguna["role"] ?? '';
    _status = widget.pengguna["status"] ?? 'Diterima';
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
      "no": widget.pengguna["no"] ?? '',
      "nama": _namaController.text.trim(),
      "email": _emailController.text.trim(),
      "noHp": _noHpController.text.trim(),
      "role": _selectedRole ?? '',
      "status": _status ?? 'Diterima',
    };

    await PenggunaRepo.updateByNo(updated["no"]!, updated);
    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    final roles = ['Admin', 'Ketua RW', 'Ketua RT', 'Sekretaris', 'Bendahara'];
    final statuses = ['Diterima', 'Pending', 'Ditolak'];

    return Scaffold(
      appBar: AppBar(title: const Text("Edit Pengguna")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            TextFormField(
              controller: _namaController,
              decoration: const InputDecoration(labelText: "Nama"),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _nikController,
              decoration: const InputDecoration(labelText: "NIK"),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: "Email"),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _noHpController,
              decoration: const InputDecoration(labelText: "Nomor HP"),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              initialValue: _selectedRole!.isEmpty ? null : _selectedRole,
              items: roles
                  .map((r) => DropdownMenuItem(value: r, child: Text(r)))
                  .toList(),
              onChanged: (v) => setState(() => _selectedRole = v),
              decoration: const InputDecoration(labelText: "Role"),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              initialValue: _status,
              items: statuses
                  .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                  .toList(),
              onChanged: (v) => setState(() => _status = v),
              decoration: const InputDecoration(labelText: "Status"),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _saveChanges,
              icon: const Icon(Icons.save),
              label: const Text("Simpan"),
            ),
          ],
        ),
      ),
    );
  }
}
