import 'package:flutter/material.dart';

class WargaTambahScreen extends StatefulWidget {
  const WargaTambahScreen({super.key});

  @override
  State<WargaTambahScreen> createState() => _WargaTambahScreenState();
}

class _WargaTambahScreenState extends State<WargaTambahScreen> {
  // Controllers for text input fields
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _nikController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _birthPlaceController = TextEditingController();
  final TextEditingController _birthDateController =
      TextEditingController(); // For displaying selected date

  // Selected values for dropdowns
  String? _selectedFamily;
  String? _selectedGender;
  String? _selectedReligion;
  String? _selectedBloodType;
  String? _selectedFamilyRole;
  String? _selectedEducation;
  String? _selectedOccupation;
  String? _selectedStatus;

  // Sample data for dropdowns (UI placeholders)
  final List<String> _families = [
    'Keluarga Mara Nunez',
    'Keluarga Vansky',
    'Keluarga Ijat'
  ];
  final List<String> _genders = ['Laki-laki', 'Perempuan'];
  final List<String> _religions = [
    'Islam',
    'Kristen Protestan',
    'Kristen Katolik',
    'Hindu',
    'Buddha',
    'Konghucu'
  ];
  final List<String> _bloodTypes = ['A', 'B', 'AB', 'O'];
  final List<String> _familyRoles = [
    'Kepala Keluarga',
    'Istri',
    'Anak',
    'Lainnya'
  ];
  final List<String> _educations = [
    'SD',
    'SMP',
    'SMA/SMK',
    'Diploma',
    'Sarjana',
    'Magister',
    'Doktor'
  ];
  final List<String> _occupations = [
    'PNS',
    'Swasta',
    'Wirausaha',
    'Pelajar/Mahasiswa',
    'Tidak Bekerja'
  ];
  final List<String> _statuses = ['Hidup', 'Meninggal', 'Pindah'];

  // UI-only function to show date picker
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        // Format the date as DD/MM/YYYY
        _birthDateController.text =
            "${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}";
      });
    }
  }

  @override
  void dispose() {
    // Dispose controllers to free up resources
    _nameController.dispose();
    _nikController.dispose();
    _phoneController.dispose();
    _birthPlaceController.dispose();
    _birthDateController.dispose();
    super.dispose();
  }

  // Placeholder function for Submit button
  void _submitForm() {
    // No backend logic, just print to console for demonstration
    print('Submit button pressed! (UI only)');
  }

  // Resets all form fields to their initial state
  void _resetForm() {
    setState(() {
      _nameController.clear();
      _nikController.clear();
      _phoneController.clear();
      _birthPlaceController.clear();
      _birthDateController.clear();
      _selectedFamily = null;
      _selectedGender = null;
      _selectedReligion = null;
      _selectedBloodType = null;
      _selectedFamilyRole = null;
      _selectedEducation = null;
      _selectedOccupation = null;
      _selectedStatus = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA), // Light background to match daftar screen
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Card(
                elevation: 3,
                shadowColor: Colors.black.withOpacity(0.1),
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
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
                    _buildDropdownField(
                      label: 'Pilih Keluarga',
                      hint: '-- Pilih Keluarga --',
                      value: _selectedFamily,
                      items: _families,
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedFamily = newValue;
                        });
                      },
                    ),
                    const SizedBox(height: 16),
                    _buildTextField(
                      controller: _nameController,
                      label: 'Nama',
                      hint: 'Masukan nama lengkap',
                    ),
                    const SizedBox(height: 16),
                    _buildTextField(
                      controller: _nikController,
                      label: 'NIK',
                      hint: 'Masukan NIK sesuai KTP',
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 16),
                    _buildTextField(
                      controller: _phoneController,
                      label: 'Nomor Telepon',
                      hint: '08xxxxxx',
                      keyboardType: TextInputType.phone,
                    ),
                    const SizedBox(height: 16),
                    _buildTextField(
                      controller: _birthPlaceController,
                      label: 'Tempat Lahir',
                      hint: 'Masukan tempat lahir',
                    ),
                    const SizedBox(height: 16),
                    _buildDateField(
                      controller: _birthDateController,
                      label: 'Tanggal Lahir',
                      hint: '-- / -- / ----',
                      onTap: () => _selectDate(context),
                    ),
                    const SizedBox(height: 16),
                    _buildDropdownField(
                      label: 'Jenis Kelamin',
                      hint: '-- Pilih Jenis Kelamin --',
                      value: _selectedGender,
                      items: _genders,
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedGender = newValue;
                        });
                      },
                    ),
                    const SizedBox(height: 16),
                    _buildDropdownField(
                      label: 'Agama',
                      hint: '-- Pilih Agama --',
                      value: _selectedReligion,
                      items: _religions,
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedReligion = newValue;
                        });
                      },
                    ),
                    const SizedBox(height: 16),
                    _buildDropdownField(
                      label: 'Golongan Darah',
                      hint: '-- Pilih Golongan Darah --',
                      value: _selectedBloodType,
                      items: _bloodTypes,
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedBloodType = newValue;
                        });
                      },
                    ),
                    const SizedBox(height: 16),
                    _buildDropdownField(
                      label: 'Peran Keluarga',
                      hint: '-- Pilih Peran Keluarga --',
                      value: _selectedFamilyRole,
                      items: _familyRoles,
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedFamilyRole = newValue;
                        });
                      },
                    ),
                    const SizedBox(height: 16),
                    _buildDropdownField(
                      label: 'Pendidikan Terakhir',
                      hint: '-- Pilih Pendidikan Terakhir --',
                      value: _selectedEducation,
                      items: _educations,
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedEducation = newValue;
                        });
                      },
                    ),
                    const SizedBox(height: 16),
                    _buildDropdownField(
                      label: 'Pekerjaan',
                      hint: '-- Pilih Pekerjaan --',
                      value: _selectedOccupation,
                      items: _occupations,
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedOccupation = newValue;
                        });
                      },
                    ),
                    const SizedBox(height: 16),
                    _buildDropdownField(
                      label: 'Status',
                      hint: '-- Pilih Status --',
                      value: _selectedStatus,
                      items: _statuses,
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedStatus = newValue;
                        });
                      },
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ElevatedButton(
                          onPressed: _submitForm,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.deepPurple,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                          ),
                          child: const Text('Submit',
                              style: TextStyle(color: Colors.white)),
                        ),
                        const SizedBox(width: 16),
                        OutlinedButton(
                          onPressed: _resetForm,
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            side: BorderSide(color: Colors.grey.shade400),
                          ),
                          child: Text('Reset',
                              style: TextStyle(color: Colors.grey.shade700)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper widget to build a text field
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: Colors.grey.shade500),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: const BorderSide(color: Colors.deepPurple, width: 1.5),
            ),
            filled: true,
            fillColor: Colors.white,
          ),
        ),
      ],
    );
  }

  // Helper widget to build a date picker field
  Widget _buildDateField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required VoidCallback onTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: onTap,
          child: AbsorbPointer(
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: TextStyle(color: Colors.grey.shade500),
                suffixIcon:
                    const Icon(Icons.calendar_today_outlined, color: Colors.grey),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(color: Colors.deepPurple, width: 1.5),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Helper widget to build a dropdown field
  Widget _buildDropdownField<T>({
    required String label,
    required String hint,
    required T? value,
    required List<T> items,
    required ValueChanged<T?> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<T>(
          value: value,
          hint: Text(hint, style: TextStyle(color: Colors.grey.shade500)),
          isExpanded: true,
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: const BorderSide(color: Colors.deepPurple, width: 1.5),
            ),
            filled: true,
            fillColor: Colors.white,
          ),
          items: items.map<DropdownMenuItem<T>>((T item) {
            return DropdownMenuItem<T>(
              value: item,
              child: Text(
                item.toString(),
                overflow: TextOverflow.ellipsis,
              ),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }
}