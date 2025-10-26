import 'package:flutter/material.dart';

class TagihIuranScreen extends StatefulWidget {
  const TagihIuranScreen({super.key});

  @override
  State<TagihIuranScreen> createState() => _TagihIuranScreenState();
}

class _TagihIuranScreenState extends State<TagihIuranScreen> {
  String? selectedIuran;
  DateTime? selectedDate;
  bool showDateError = false;

  final List<String> iuranList = [
    '-- Pilih Iuran --',
    'Agustusan',
    'Harian',
    'Mingguan',
    'Bulanan',
    'Kerja Bakti',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F8FC),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                const Text(
                  "Tagih Iuran ke Semua Keluarga Aktif",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),

                // Dropdown Label
                const Text(
                  "Jenis Iuran",
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 8),

                // Dropdown Field
                DropdownButtonFormField<String>(
                  value: selectedIuran,
                  hint: const Text('-- Pilih Iuran --'),
                  isExpanded: true,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 10,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                  ),
                  items: iuranList.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedIuran = value;
                      selectedDate = null;
                      showDateError = false;
                    });
                  },
                ),

                // Calendar Field (only visible after choosing iuran)
                if (selectedIuran != null &&
                    selectedIuran != '-- Pilih Iuran --') ...[
                  const SizedBox(height: 16),
                  const Text(
                    "Tanggal",
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    readOnly: true,
                    decoration: InputDecoration(
                      hintText: selectedDate == null
                          ? 'Pilih tanggal'
                          : '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}',
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 10,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      suffixIcon: const Icon(Icons.calendar_today),
                      errorText: showDateError ? 'Tanggal wajib diisi.' : null,
                    ),
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: selectedDate ?? DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                      );
                      if (pickedDate != null) {
                        setState(() {
                          selectedDate = pickedDate;
                          showDateError = false;
                        });
                      }
                    },
                  ),
                ],

                const SizedBox(height: 24),

                // Action Buttons
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        if (selectedIuran == null ||
                            selectedIuran == '-- Pilih Iuran --') {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Silakan pilih jenis iuran.'),
                              backgroundColor: Colors.red,
                            ),
                          );
                          return;
                        }
                        if (selectedDate == null) {
                          setState(() {
                            showDateError = true;
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Tanggal wajib diisi.'),
                              backgroundColor: Colors.red,
                            ),
                          );
                          return;
                        }

                        setState(() {
                          showDateError = false;
                        });

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Tagihan untuk "$selectedIuran" tanggal '
                              '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year} berhasil dikirim.',
                            ),
                            backgroundColor: Colors.green,
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF3E6FAA),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      child: const Text(
                        'Tagih Iuran',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(width: 12),
                    OutlinedButton(
                      onPressed: () {
                        setState(() {
                          selectedIuran = null;
                          selectedDate = null;
                          showDateError = false;
                        });
                      },
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                        side: BorderSide(color: Colors.grey.shade400),
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
    );
  }
}
