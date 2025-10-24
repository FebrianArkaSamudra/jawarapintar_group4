import 'package:flutter/material.dart';

class WargaTambahScreen extends StatefulWidget {
  const WargaTambahScreen({super.key});

  @override
  State<WargaTambahScreen> createState() => _WargaTambahScreenState();
}

class _WargaTambahScreenState extends State<WargaTambahScreen> {
  final _formKey = GlobalKey<FormState>();

  String? selectedKeluarga;
  String? selectedGender;
  String? selectedAgama;
  String? selectedDarah;
  String? selectedPeran;
  String? selectedPendidikan;
  String? selectedPekerjaan;
  String? selectedStatus;
  DateTime? selectedDate;

  final _namaController = TextEditingController();
  final _nikController = TextEditingController();
  final _teleponController = TextEditingController();
  final _tempatLahirController = TextEditingController();

  void _pickDate() async {
    DateTime? date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (date != null) setState(() => selectedDate = date);
  }

  void _resetForm() {
    _formKey.currentState?.reset();
    _namaController.clear();
    _nikController.clear();
    _teleponController.clear();
    _tempatLahirController.clear();
    selectedKeluarga = selectedGender = selectedAgama = selectedDarah =
        selectedPeran = selectedPendidikan = selectedPekerjaan =
            selectedStatus = null;
    selectedDate = null;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
        child: Align(
          alignment: Alignment.topLeft,
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Tambah Warga',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildDropdown(
                    'Pilih Keluarga',
                    selectedKeluarga,
                    ['Keluarga A', 'Keluarga B'],
                    (val) {
                      setState(() => selectedKeluarga = val);
                    },
                  ),
                  _buildTextField(
                    'Nama',
                    'Masukkan nama lengkap',
                    _namaController,
                  ),
                  _buildTextField(
                    'NIK',
                    'Masukkan NIK sesuai KTP',
                    _nikController,
                  ),
                  _buildTextField(
                    'Nomor Telepon',
                    '08xxxxxx',
                    _teleponController,
                  ),
                  _buildTextField(
                    'Tempat Lahir',
                    'Masukkan tempat lahir',
                    _tempatLahirController,
                  ),
                  _buildDatePickerField('Tanggal Lahir'),
                  _buildDropdown(
                    'Jenis Kelamin',
                    selectedGender,
                    ['Laki-laki', 'Perempuan'],
                    (val) => setState(() => selectedGender = val),
                  ),
                  _buildDropdown(
                    'Agama',
                    selectedAgama,
                    ['Islam', 'Kristen', 'Hindu', 'Budha'],
                    (val) => setState(() => selectedAgama = val),
                  ),
                  _buildDropdown(
                    'Golongan Darah',
                    selectedDarah,
                    ['A', 'B', 'AB', 'O'],
                    (val) => setState(() => selectedDarah = val),
                  ),
                  _buildDropdown(
                    'Peran Keluarga',
                    selectedPeran,
                    ['Ayah', 'Ibu', 'Anak'],
                    (val) => setState(() => selectedPeran = val),
                  ),
                  _buildDropdown(
                    'Pendidikan Terakhir',
                    selectedPendidikan,
                    ['SD', 'SMP', 'SMA', 'S1'],
                    (val) => setState(() => selectedPendidikan = val),
                  ),
                  _buildDropdown(
                    'Pekerjaan',
                    selectedPekerjaan,
                    ['Pelajar', 'Karyawan', 'Wiraswasta'],
                    (val) => setState(() => selectedPekerjaan = val),
                  ),
                  _buildDropdown(
                    'Status',
                    selectedStatus,
                    ['Aktif', 'Nonaktif'],
                    (val) => setState(() => selectedStatus = val),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState?.validate() ?? false) {
                            // handle submit
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF3E6FAA),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 12,
                          ),
                        ),
                        child: const Text(
                          'Submit',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      const SizedBox(width: 16),
                      OutlinedButton(
                        onPressed: _resetForm,
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 12,
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
    );
  }

  Widget _buildTextField(
    String label,
    String hint,
    TextEditingController controller,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label),
          const SizedBox(height: 6),
          TextFormField(
            controller: controller,
            decoration: InputDecoration(
              hintText: hint,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdown(
    String label,
    String? value,
    List<String> items,
    ValueChanged<String?> onChanged,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label),
          const SizedBox(height: 6),
          DropdownButtonFormField<String>(
            value: value,
            items: items
                .map((e) => DropdownMenuItem<String>(value: e, child: Text(e)))
                .toList(),
            onChanged: onChanged,
            decoration: InputDecoration(
              hintText: '-- Pilih $label --',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDatePickerField(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label),
          const SizedBox(height: 6),
          InkWell(
            onTap: _pickDate,
            child: InputDecorator(
              decoration: InputDecoration(
                hintText: 'Pilih tanggal lahir',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              child: Text(
                selectedDate == null
                    ? '--/--/--'
                    : '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
