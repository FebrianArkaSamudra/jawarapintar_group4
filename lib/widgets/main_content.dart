import 'package:flutter/material.dart';

class MainContent extends StatelessWidget {
  final String selectedPrimaryItem;
  final String? selectedSubItem;

  const MainContent({
    super.key,
    required this.selectedPrimaryItem,
    this.selectedSubItem,
  });

  @override
  Widget build(BuildContext context) {
    const Color appBgColor = Color(0xFFF7F7F7);

    return Expanded(
      child: Container(
        color: appBgColor,
        padding: const EdgeInsets.all(32.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Konten untuk Halaman:',
                style: TextStyle(fontSize: 18, color: Colors.grey.shade600),
              ),
              const SizedBox(height: 8),
              Text(
                selectedSubItem != null
                    ? '$selectedPrimaryItem > $selectedSubItem'
                    : selectedPrimaryItem,
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF3F6FAA),
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
