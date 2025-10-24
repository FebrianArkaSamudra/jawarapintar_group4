import 'package:flutter/material.dart';

class RumahTambahScreen extends StatefulWidget {
  const RumahTambahScreen({super.key});

  @override
  State<RumahTambahScreen> createState() => _RumahTambahScreenState();
}

class _RumahTambahScreenState extends State<RumahTambahScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _alamatController = TextEditingController();

  void _handleSubmit() {
    if (_formKey.currentState!.validate()) {
      // TODO: Add your submit logic here (e.g., send data to Firestore)
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Rumah berhasil ditambahkan!')),
      );
      _alamatController.clear();
    }
  }

  void _handleReset() {
    _alamatController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Text(
              "Tambah Rumah Baru",
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
            const SizedBox(height: 24),

            // Form Container
            Container(
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
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Label
                    const Text(
                      "Alamat Rumah",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Text Field
                    TextFormField(
                      controller: _alamatController,
                      decoration: InputDecoration(
                        hintText: "Contoh: Jl. Merpati No. 5",
                        hintStyle: const TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 14,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: const BorderSide(color: Colors.black12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: const BorderSide(
                            color: Color(0xFF3E6FAA),
                            width: 1.5,
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Alamat rumah wajib diisi';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 24),

                    // Buttons
                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: _handleSubmit,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF3E6FAA),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 12,
                            ),
                          ),
                          child: const Text(
                            "Submit",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        const SizedBox(width: 12),
                        OutlinedButton(
                          onPressed: _handleReset,
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 12,
                            ),
                            side: const BorderSide(color: Colors.black26),
                          ),
                          child: const Text(
                            "Reset",
                            style: TextStyle(color: Colors.black87),
                          ),
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
}
