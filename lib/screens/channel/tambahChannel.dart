import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class TambahChannelPage extends StatefulWidget {
  final Map<String, String>? initialData;
  const TambahChannelPage({Key? key, this.initialData}) : super(key: key);

  @override
  State<TambahChannelPage> createState() => _TambahChannelPageState();
}

class _TambahChannelPageState extends State<TambahChannelPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _accountCtrl = TextEditingController();
  final _ownerCtrl = TextEditingController();
  final _notesCtrl = TextEditingController();

  String? _type;
  String? _status;
  File? _qrFile;
  File? _thumbFile;

  final List<String> _types = ['Bank', 'E-Wallet', 'QRIS'];
  final List<String> _statuses = ['Aktif', 'Non-Aktif'];

  @override
  void initState() {
    super.initState();
    final d = widget.initialData;
    if (d != null) {
      _nameCtrl.text = d['name'] ?? '';
      _accountCtrl.text = d['account'] ?? '';
      _ownerCtrl.text = d['owner'] ?? '';
      _notesCtrl.text = d['desc'] ?? '';
      _type = d['type'];
      _status = d['status'] ?? 'Aktif';
      // initialData may contain local paths or URLs; leave files null (user can pick)
    }
  }

  Future<void> _pickFile(bool isQr) async {
    final res = await FilePicker.platform.pickFiles(type: FileType.any);
    if (res == null) return;
    final path = res.files.single.path;
    if (path == null) return;
    setState(() {
      if (isQr) {
        _qrFile = File(path);
      } else {
        _thumbFile = File(path);
      }
    });
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;
    final map = <String, String>{
      'name': _nameCtrl.text.trim(),
      'type': _type ?? '',
      'account': _accountCtrl.text.trim(),
      'owner': _ownerCtrl.text.trim(),
      'desc': _notesCtrl.text.trim(),
      'status': _status ?? 'Aktif',
      // For simplicity we return file paths if chosen
      'qr': _qrFile?.path ?? (widget.initialData?['qr'] ?? ''),
      'thumb': _thumbFile?.path ?? (widget.initialData?['thumb'] ?? ''),
    };
    Navigator.of(context).pop(map);
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _accountCtrl.dispose();
    _ownerCtrl.dispose();
    _notesCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Constrain layout for wide screens but remain mobile friendly
    final maxWidth = MediaQuery.of(context).size.width > 900
        ? 900.0
        : double.infinity;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.initialData == null
              ? 'Buat Transfer Channel'
              : 'Edit Transfer Channel',
        ),
        backgroundColor: const Color(0xFFEFF1F8),
        foregroundColor: const Color(0xFF2B3674),
        elevation: 0,
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: maxWidth),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 18,
                ),
                child: Form(
                  key: _formKey,
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      TextFormField(
                        controller: _nameCtrl,
                        decoration: const InputDecoration(
                          labelText: 'Nama Channel',
                          hintText: 'Contoh: BCA, Dana, QRIS RT',
                        ),
                        validator: (v) => (v == null || v.trim().isEmpty)
                            ? 'Nama channel tidak boleh kosong'
                            : null,
                      ),
                      const SizedBox(height: 16),
                      DropdownButtonFormField<String>(
                        value: _type,
                        items: _types
                            .map(
                              (t) => DropdownMenuItem(value: t, child: Text(t)),
                            )
                            .toList(),
                        decoration: const InputDecoration(labelText: 'Tipe'),
                        onChanged: (v) => setState(() => _type = v),
                        validator: (v) => (v == null || v.isEmpty)
                            ? 'Pilih tipe channel'
                            : null,
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _accountCtrl,
                        decoration: const InputDecoration(
                          labelText: 'Nomor Rekening / Akun',
                          hintText: 'Contoh: 1234567890 atau ID QR',
                        ),
                        validator: (v) => (v == null || v.trim().isEmpty)
                            ? 'Nomor akun tidak boleh kosong'
                            : null,
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _ownerCtrl,
                        decoration: const InputDecoration(
                          labelText: 'Nama Pemilik',
                          hintText: 'Contoh: Bendahara RT',
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'QR',
                                  style: TextStyle(fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(height: 8),
                                _qrPreview(),
                              ],
                            ),
                          ),
                          const SizedBox(width: 12),
                          OutlinedButton(
                            onPressed: () => _pickFile(true),
                            child: const Text('Pilih File'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Thumbnail',
                                  style: TextStyle(fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(height: 8),
                                _thumbPreview(),
                              ],
                            ),
                          ),
                          const SizedBox(width: 12),
                          OutlinedButton(
                            onPressed: () => _pickFile(false),
                            child: const Text('Pilih File'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      DropdownButtonFormField<String>(
                        value:
                            _status ?? widget.initialData?['status'] ?? 'Aktif',
                        items: _statuses
                            .map(
                              (s) => DropdownMenuItem(value: s, child: Text(s)),
                            )
                            .toList(),
                        decoration: const InputDecoration(labelText: 'Status'),
                        onChanged: (v) => setState(() => _status = v),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _notesCtrl,
                        decoration: const InputDecoration(
                          labelText: 'Catatan (Opsional)',
                          hintText:
                              'Contoh: Transfer hanya dari bank yang sama agar instan',
                        ),
                        maxLines: 3,
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: const Text(
                              'Batal',
                              style: TextStyle(color: Colors.purple),
                            ),
                          ),
                          const Spacer(),
                          ElevatedButton(
                            onPressed: _save,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF4318FF),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 24,
                                vertical: 12,
                              ),
                            ),
                            child: const Text(
                              'Simpan',
                              style: TextStyle(color: Colors.white),
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

  Widget _qrPreview() {
    final initialPath = widget.initialData?['qr'];
    if (_qrFile != null) {
      return _imageBox(File(_qrFile!.path));
    } else if (initialPath != null && initialPath.isNotEmpty) {
      return _textPathBox(initialPath);
    } else {
      return const Text(
        'Path file QR atau URL — kosongkan jika tidak ada',
        style: TextStyle(color: Colors.grey),
      );
    }
  }

  Widget _thumbPreview() {
    final initialPath = widget.initialData?['thumb'];
    if (_thumbFile != null) {
      return _imageBox(File(_thumbFile!.path));
    } else if (initialPath != null && initialPath.isNotEmpty) {
      return _textPathBox(initialPath);
    } else {
      return const Text(
        'Path file thumbnail atau URL — kosongkan jika tidak ada',
        style: TextStyle(color: Colors.grey),
      );
    }
  }

  Widget _imageBox(File file) {
    return Container(
      height: 72,
      width: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: const Color(0xFFF4F6FF),
        image: DecorationImage(image: FileImage(file), fit: BoxFit.cover),
      ),
    );
  }

  Widget _textPathBox(String path) {
    return Container(
      height: 72,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE6E9F2)),
        color: const Color(0xFFF8F9FC),
      ),
      child: Text(
        path,
        style: const TextStyle(fontSize: 13),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
