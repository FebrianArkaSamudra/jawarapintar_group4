import 'package:flutter/material.dart';

class PemasukanTambahScreen extends StatefulWidget {
  const PemasukanTambahScreen({super.key});

  @override
  State<PemasukanTambahScreen> createState() => _PemasukanTambahScreenState();
}

class _PemasukanTambahScreenState extends State<PemasukanTambahScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _tanggalController = TextEditingController();
  final TextEditingController _nominalController = TextEditingController();
  String? _selectedKategori;
  DateTime? _selectedDate;

  final List<String> _kategoriList = ['Gaji', 'Bonus', 'Hadiah', 'Lainnya'];

  void _pickDate() async {
    DateTime now = DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? now,
      firstDate: DateTime(now.year - 5),
      lastDate: DateTime(now.year + 5),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
        _tanggalController.text =
            "${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}";
      });
    }
  }

  void _resetForm() {
    _formKey.currentState?.reset();
    _namaController.clear();
    _tanggalController.clear();
    _nominalController.clear();
    setState(() {
      _selectedKategori = null;
      _selectedDate = null;
    });
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Process data here
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Data berhasil disubmit')));
    }
  }

  @override
  void dispose() {
    _namaController.dispose();
    _tanggalController.dispose();
    _nominalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Center(
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          color: Colors.white,
          margin: const EdgeInsets.all(16),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Buat Pemasukan Non Iuran Baru',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Nama Pemasukan
                    const Text(
                      'Nama Pemasukan',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _namaController,
                      decoration: const InputDecoration(
                        hintText: 'Masukkan nama pemasukan',
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 14,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Nama pemasukan wajib diisi';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    // Tanggal Pemasukan
                    const Text(
                      'Tanggal Pemasukan',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _tanggalController,
                            readOnly: true,
                            decoration: const InputDecoration(
                              hintText: 'Pilih tanggal',
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 14,
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Tanggal pemasukan wajib dipilih';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(width: 12),
                        Container(
                          height: 48,
                          width: 48,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.calendar_month),
                            color: Colors.grey[700],
                            onPressed: _pickDate,
                            tooltip: 'Pilih tanggal',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    // Kategori Pemasukan
                    const Text(
                      'Kategori Pemasukan',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 8),
                    DropdownButtonFormField<String>(
                      value: _selectedKategori,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 14,
                        ),
                      ),
                      hint: const Text('-- Pilih Kategori --'),
                      items: _kategoriList
                          .map(
                            (kategori) => DropdownMenuItem(
                              value: kategori,
                              child: Text(kategori),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedKategori = value;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Kategori pemasukan wajib dipilih';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    // Nominal
                    const Text(
                      'Nominal',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _nominalController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        hintText: 'Masukkan nominal pemasukan',
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 14,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Nominal pemasukan wajib diisi';
                        }
                        if (double.tryParse(value.replaceAll(',', '')) ==
                            null) {
                          return 'Nominal harus berupa angka';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    // Bukti Pemasukan
                    const Text(
                      'Bukti Pemasukan',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      height: 120,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey.shade400),
                      ),
                      child: Center(
                        child: Text(
                          'Upload bukti pemasukan (.png/.jpg)',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 28),
                    // Buttons row
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: _submitForm,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.purple,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                            child: const Text(
                              'Submit',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: _resetForm,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey[400],
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                            child: const Text(
                              'Reset',
                              style: TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
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
    );
  }
}
