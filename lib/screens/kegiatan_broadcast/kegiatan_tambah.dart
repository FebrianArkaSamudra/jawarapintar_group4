import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class KegiatanTambah extends StatefulWidget {
  const KegiatanTambah({super.key});

  @override
  State<KegiatanTambah> createState() => _KegiatanTambahState();
}

class _KegiatanTambahState extends State<KegiatanTambah> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _lokasiController = TextEditingController();
  final TextEditingController _penanggungController = TextEditingController();
  final TextEditingController _deskripsiController = TextEditingController();
  final TextEditingController _tanggalController = TextEditingController();

  String? _kategori;
  final List<String> _kategoriList = [
    'Komunitas & Sosial',
    'Kebersihan & Keamanan',
    'Keagamaan',
    'Pendidikan',
    'Kesehatan & Olahraga',
    'Lainnya',
  ];

  Future<void> _pilihTanggal(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      String formattedDate = DateFormat('dd/MM/yyyy').format(pickedDate);
      setState(() {
        _tanggalController.text = formattedDate;
      });
    }
  }

  void _resetForm() {
    _formKey.currentState?.reset();
    _namaController.clear();
    _lokasiController.clear();
    _penanggungController.clear();
    _deskripsiController.clear();
    _tanggalController.clear();
    setState(() {
      _kategori = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xF5F8FCFF),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Buat Kegiatan Baru',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Nama Kegiatan
                    const Text('Nama Kegiatan'),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _namaController,
                      decoration: InputDecoration(
                        hintText: 'Contoh: Musyawarah Warga',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Kategori Kegiatan
                    const Text('Kategori kegiatan'),
                    const SizedBox(height: 8),
                    DropdownButtonFormField<String>(
                      value: _kategori,
                      hint: const Text('-- Pilih Kategori --'),
                      items: _kategoriList.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          _kategori = newValue;
                        });
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Tanggal
                    const Text('Tanggal'),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _tanggalController,
                      readOnly: true,
                      onTap: () => _pilihTanggal(context),
                      decoration: InputDecoration(
                        hintText: '--/--/----',
                        suffixIcon: const Icon(Icons.calendar_today_outlined),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Lokasi
                    const Text('Lokasi'),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _lokasiController,
                      decoration: InputDecoration(
                        hintText: 'Contoh: Balai RT 03',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Penanggung Jawab
                    const Text('Penanggung Jawab'),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _penanggungController,
                      decoration: InputDecoration(
                        hintText: 'Contoh: Pak RT atau Bu RW',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Deskripsi
                    const Text('Deskripsi'),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _deskripsiController,
                      maxLines: 4,
                      decoration: InputDecoration(
                        hintText: 'Tuliskan detail event seperti agenda, keperluan, dll.',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Tombol Submit dan Reset
                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Data kegiatan berhasil disimpan!'),
                                ),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 12,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                          child: const Text('Submit'),
                        ),
                        const SizedBox(width: 12),
                        OutlinedButton(
                          onPressed: _resetForm,
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 12,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
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
      ),
    );
  }
}
