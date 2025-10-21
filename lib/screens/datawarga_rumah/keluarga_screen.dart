import 'package:flutter/material.dart';

class KeluargaScreen extends StatefulWidget {
  const KeluargaScreen({super.key});

  @override
  State<KeluargaScreen> createState() => _KeluargaScreenState();
}

class _KeluargaScreenState extends State<KeluargaScreen> {
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

                  // --- PILIH KELUARGA ---
                  _buildDropdownField(
                    label: 'Pilih Keluarga',
                    hint: '-- Pilih Keluarga --',
                    value: selectedKeluarga,
                    items: [
                      'Keluarga Mara Nunez',
                      'Keluarga Varizky Naldiba Rimra',
                      'Keluarga Tes',
                    ],
                    onChanged: (val) => setState(() => selectedKeluarga = val),
                  ),

                  // --- TEXT INPUTS ---
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

                  // --- DATE PICKER ---
                  _buildDatePickerField('Tanggal Lahir'),

                  // --- DROPDOWNS ---
                  _buildDropdownField(
                    label: 'Jenis Kelamin',
                    hint: '-- Pilih Jenis Kelamin --',
                    value: selectedGender,
                    items: ['Laki-laki', 'Perempuan'],
                    onChanged: (val) => setState(() => selectedGender = val),
                  ),
                  _buildDropdownField(
                    label: 'Agama',
                    hint: '-- Pilih Agama --',
                    value: selectedAgama,
                    items: ['Islam', 'Kristen', 'Hindu', 'Budha'],
                    onChanged: (val) => setState(() => selectedAgama = val),
                  ),
                  _buildDropdownField(
                    label: 'Golongan Darah',
                    hint: '-- Pilih Golongan Darah --',
                    value: selectedDarah,
                    items: ['A', 'B', 'AB', 'O'],
                    onChanged: (val) => setState(() => selectedDarah = val),
                  ),
                  _buildDropdownField(
                    label: 'Peran Keluarga',
                    hint: '-- Pilih Peran Keluarga --',
                    value: selectedPeran,
                    items: ['Ayah', 'Ibu', 'Anak'],
                    onChanged: (val) => setState(() => selectedPeran = val),
                  ),
                  _buildDropdownField(
                    label: 'Pendidikan Terakhir',
                    hint: '-- Pilih Pendidikan Terakhir --',
                    value: selectedPendidikan,
                    items: ['SD', 'SMP', 'SMA', 'S1'],
                    onChanged: (val) =>
                        setState(() => selectedPendidikan = val),
                  ),
                  _buildDropdownField(
                    label: 'Pekerjaan',
                    hint: '-- Pilih Jenis Pekerjaan --',
                    value: selectedPekerjaan,
                    items: ['Pelajar', 'Karyawan', 'Wiraswasta'],
                    onChanged: (val) => setState(() => selectedPekerjaan = val),
                  ),
                  _buildDropdownField(
                    label: 'Status',
                    hint: '-- Pilih Status --',
                    value: selectedStatus,
                    items: ['Aktif', 'Nonaktif'],
                    onChanged: (val) => setState(() => selectedStatus = val),
                  ),

                  const SizedBox(height: 20),

                  // --- BUTTONS ---
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState?.validate() ?? false) {
                            // handle submit
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 12,
                          ),
                        ),
                        child: const Text('Submit'),
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

  // ----------- INPUT BUILDERS -----------

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
          Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
          const SizedBox(height: 6),
          TextFormField(
            controller: controller,
            decoration: InputDecoration(
              hintText: hint,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 14,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: const BorderSide(color: Colors.deepPurple),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdownField({
    required String label,
    required String hint,
    required String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
          const SizedBox(height: 8),
          DropdownButtonFormField<String>(
            value: value,
            items: items
                .map(
                  (item) =>
                      DropdownMenuItem<String>(value: item, child: Text(item)),
                )
                .toList(),
            onChanged: onChanged,
            decoration: InputDecoration(
              hintText: hint,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 14,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: const BorderSide(color: Colors.deepPurple),
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
          Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
          const SizedBox(height: 6),
          InkWell(
            onTap: _pickDate,
            child: InputDecorator(
              decoration: InputDecoration(
                hintText: 'Pilih tanggal lahir',
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 14,
                ),
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
