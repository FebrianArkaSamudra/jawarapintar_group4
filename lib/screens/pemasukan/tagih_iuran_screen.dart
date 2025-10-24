import 'package:flutter/material.dart';

class TagihIuranScreen extends StatefulWidget {
  const TagihIuranScreen({super.key});

  @override
  State<TagihIuranScreen> createState() => _TagihIuranScreenState();
}

class _TagihIuranScreenState extends State<TagihIuranScreen> {
  String? selectedIuran;

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
      body: Padding(
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
                    });
                  },
                ),

                const SizedBox(height: 24),

                // Action Buttons
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // TODO: Add logic to tagih all families
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
