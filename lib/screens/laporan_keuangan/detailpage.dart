import 'package:flutter/material.dart';

class detailPage extends StatelessWidget {
  final Map<String, String> item;

  const detailPage({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final double maxContentWidth = 1000;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F7),
      appBar: AppBar(),
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
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                _buildRow(context, 'No', item['no'] ?? ''),
                _buildRow(context, 'Nama Pengeluaran', item['nama'] ?? ''),
                _buildRow(context, 'Jenis Pengeluaran', item['jenis'] ?? ''),
                _buildRow(context, 'Tanggal', item['tanggal'] ?? ''),
                _buildRow(
                  context,
                  'Nominal',
                  item['nominal'] ?? '',
                  isHighlight: true,
                ),
                // Tambahan opsional
                if (item.containsKey('tanggalVerifikasi'))
                  _buildRow(
                    context,
                    'Tanggal Terverifikasi',
                    item['tanggalVerifikasi']!,
                  ),
                if (item.containsKey('verifikator'))
                  _buildRow(context, 'Verifikator', item['verifikator']!),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRow(
    BuildContext context,
    String label,
    String value, {
    bool isHighlight = false,
  }) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isMobile = screenWidth < 600;

    if (isMobile) {
      // stack label above value for mobile
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(fontSize: 13, color: Colors.grey),
            ),
            const SizedBox(height: 6),
            Text(
              value,
              style: TextStyle(
                fontSize: 15,
                fontWeight: isHighlight ? FontWeight.bold : FontWeight.normal,
                color: isHighlight ? Colors.red : Colors.black,
              ),
            ),
          ],
        ),
      );
    }

    // desktop/tablet layout: label + value in a row
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          SizedBox(
            width: 180,
            child: Text(
              label,
              style: const TextStyle(fontSize: 14, color: Colors.grey),
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
