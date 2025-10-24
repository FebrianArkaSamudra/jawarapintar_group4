import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class BroadcastTambah extends StatefulWidget {
  const BroadcastTambah({super.key});

  @override
  State<BroadcastTambah> createState() => _BroadcastTambahState();
}

class _BroadcastTambahState extends State<BroadcastTambah> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _judulController = TextEditingController();
  final TextEditingController _isiController = TextEditingController();

  List<File> _fotoFiles = [];
  List<File> _dokumenFiles = [];

  Future<void> _pickFoto() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: ['png', 'jpg', 'jpeg'],
    );

    if (result != null) {
      final files = result.paths.map((path) => File(path!)).toList();
      if (files.length > 10) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Maksimal 10 foto yang dapat diupload.')),
        );
      } else {
        setState(() => _fotoFiles = files);
      }
    }
  }

  Future<void> _pickDokumen() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      final files = result.paths.map((path) => File(path!)).toList();
      if (files.length > 10) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Maksimal 10 dokumen yang dapat diupload.')),
        );
      } else {
        setState(() => _dokumenFiles = files);
      }
    }
  }

  void _resetForm() {
    _judulController.clear();
    _isiController.clear();
    setState(() {
      _fotoFiles.clear();
      _dokumenFiles.clear();
    });
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Broadcast berhasil dibuat!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F8FC),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Card(
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Buat Broadcast Baru',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 24),

                  // Judul Broadcast
                  const Text('Judul Broadcast'),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _judulController,
                    validator: (value) =>
                        value == null || value.isEmpty ? 'Judul wajib diisi' : null,
                    decoration: InputDecoration(
                      hintText: 'Masukkan judul broadcast',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Isi Broadcast
                  const Text('Isi Broadcast'),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _isiController,
                    maxLines: 5,
                    validator: (value) =>
                        value == null || value.isEmpty ? 'Isi broadcast wajib diisi' : null,
                    decoration: InputDecoration(
                      hintText: 'Tulis isi broadcast di sini...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Foto Section
                  const Text('Foto', style: TextStyle(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 4),
                  const Text(
                    'Maksimal 10 gambar (.png / .jpg), ukuran maksimal 5MB per gambar.',
                    style: TextStyle(fontSize: 13, color: Colors.black54),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    width: double.infinity,
                    height: 80,
                    color: const Color(0xFFF1F1F1),
                    alignment: Alignment.center,
                    child: TextButton(
                      onPressed: _pickFoto,
                      child: const Text('Upload foto png/jpg'),
                    ),
                  ),
                  if (_fotoFiles.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      children: _fotoFiles
                          .map((f) => Chip(
                                label: Text(f.path.split('/').last),
                                deleteIcon: const Icon(Icons.close),
                                onDeleted: () {
                                  setState(() => _fotoFiles.remove(f));
                                },
                              ))
                          .toList(),
                    ),
                  ],
                  const SizedBox(height: 24),

                  // Dokumen Section
                  const Text('Dokumen', style: TextStyle(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 4),
                  const Text(
                    'Maksimal 10 file (pdf), ukuran maksimal 5MB per file.',
                    style: TextStyle(fontSize: 13, color: Colors.black54),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    width: double.infinity,
                    height: 80,
                    color: const Color(0xFFF1F1F1),
                    alignment: Alignment.center,
                    child: TextButton(
                      onPressed: _pickDokumen,
                      child: const Text('Upload dokumen pdf'),
                    ),
                  ),
                  if (_dokumenFiles.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      children: _dokumenFiles
                          .map((f) => Chip(
                                label: Text(f.path.split('/').last),
                                deleteIcon: const Icon(Icons.close),
                                onDeleted: () {
                                  setState(() => _dokumenFiles.remove(f));
                                },
                              ))
                          .toList(),
                    ),
                  ],
                  const SizedBox(height: 24),

                  // Tombol Submit & Reset
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: _submitForm,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 255, 253, 253),
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        ),
                        child: const Text('Submit'),
                      ),
                      const SizedBox(width: 12),
                      OutlinedButton(
                        onPressed: _resetForm,
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        ),
                        child: const Text('Reset'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
