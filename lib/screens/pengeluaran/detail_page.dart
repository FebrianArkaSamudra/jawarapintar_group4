import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  final Map<String, String> item;

  const DetailPage({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double maxContentWidth = 1000;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F7),
      appBar: AppBar(
       
      ),
      body: Center(
        child: Container(
          width: screenWidth < maxContentWidth ? screenWidth : maxContentWidth,
          padding: const EdgeInsets.all(16.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Detail Pengeluaran',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                _buildRow('No', item['no'] ?? ''),
                _buildRow('Nama Pengeluaran', item['nama'] ?? ''),
                _buildRow('Jenis Pengeluaran', item['jenis'] ?? ''),
                _buildRow('Tanggal', item['tanggal'] ?? ''),
                _buildRow('Nominal', item['nominal'] ?? '', isHighlight: true),
                // Tambahan opsional
                if (item.containsKey('tanggalVerifikasi'))
                  _buildRow('Tanggal Terverifikasi', item['tanggalVerifikasi']!),
                if (item.containsKey('verifikator'))
                  _buildRow('Verifikator', item['verifikator']!),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRow(String label, String value, {bool isHighlight = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          SizedBox(
            width: 180,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 15,
                fontWeight: isHighlight ? FontWeight.bold : FontWeight.normal,
                color: isHighlight ? Colors.red : Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
