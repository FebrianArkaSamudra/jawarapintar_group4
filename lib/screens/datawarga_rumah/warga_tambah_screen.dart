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

  // Removed old _pickDate(), handled inline inside FormField for validation

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
                const Text(
                  'Tambah Warga',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    fontFamily: 'Poppins',
                  ),
                ),
                const SizedBox(height: 20),

                // Dropdowns & Text Fields
                _buildDropdown(
                  'Pilih Keluarga',
                  selectedKeluarga,
                  ['Keluarga A', 'Keluarga B'],
                  (val) => setState(() => selectedKeluarga = val),
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
                  keyboardType: TextInputType.number,
                ),
                _buildTextField(
                  'Nomor Telepon',
                  '08xxxxxx',
                  _teleponController,
                  keyboardType: TextInputType.number,
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
                _buildDropdown('Agama', selectedAgama, [
                  'Islam',
                  'Kristen',
                  'Hindu',
                  'Budha',
                ], (val) => setState(() => selectedAgama = val)),
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

                // Buttons
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Data berhasil disubmit!'),
                              duration: Duration(seconds: 2),
                            ),
                          );
                          _resetForm();
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
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Poppins',
                        ),
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
                      child: const Text(
                        'Reset',
                        style: TextStyle(fontFamily: 'Poppins'),
                      ),
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

  // 🔹 Text Field
  Widget _buildTextField(
    String label,
    String hint,
    TextEditingController controller, {
    TextInputType? keyboardType,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontFamily: 'Poppins')),
          const SizedBox(height: 6),
          TextFormField(
            controller: controller,
            keyboardType: keyboardType,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(fontFamily: 'Poppins'),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 10,
              ),
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return '$label wajib diisi';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  // 🔹 Dropdown
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
          Text(label, style: const TextStyle(fontFamily: 'Poppins')),
          const SizedBox(height: 6),
          DropdownButtonFormField<String>(
            value: value,
            isExpanded: true,
            items: items
                .map(
                  (e) => DropdownMenuItem(
                    value: e,
                    child: Text(
                      e,
                      style: const TextStyle(fontFamily: 'Poppins'),
                    ),
                  ),
                )
                .toList(),
            onChanged: onChanged,
            decoration: InputDecoration(
              hintText: '-- Pilih $label --',
              hintStyle: const TextStyle(fontFamily: 'Poppins'),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 10,
              ),
            ),
            validator: (v) {
              if (v == null || v.isEmpty) {
                return '$label wajib dipilih';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  // 🔹 Date Picker (required)
  Widget _buildDatePickerField(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: FormField<DateTime>(
        validator: (value) {
          if (selectedDate == null) {
            return '$label wajib diisi';
          }
          return null;
        },
        builder: (state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: const TextStyle(fontFamily: 'Poppins')),
              const SizedBox(height: 6),
              InkWell(
                onTap: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime(2100),
                  );
                  if (date != null) {
                    setState(() => selectedDate = date);
                    state.didChange(date);
                  }
                },
                child: InputDecorator(
                  decoration: InputDecoration(
                    hintText: 'Pilih tanggal lahir',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 10,
                    ),
                    errorText: state.errorText,
                  ),
                  child: Text(
                    selectedDate == null
                        ? '--/--/--'
                        : '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}',
                    style: const TextStyle(fontFamily: 'Poppins'),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
