import 'package:flutter/material.dart';

class PemasukanLainDetailScreen extends StatelessWidget {
  final Map<String, String> item;
  const PemasukanLainDetailScreen({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FC),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final bool isMobile = constraints.maxWidth < 600;
            final double pad = isMobile ? 12 : 24;
            final double gap = isMobile ? 8 : 12;

            return SingleChildScrollView(
              padding: EdgeInsets.all(pad),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Back button
                  TextButton.icon(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back_ios_new, size: 16),
                    label: const Text('Kembali'),
                    style: TextButton.styleFrom(
                      foregroundColor: const Color(0xFF3E6FAA),
                    ),
                  ),
                  SizedBox(height: gap),

                  // Card
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    padding: EdgeInsets.all(pad),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Detail Pemasukan Lain',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: gap * 1.5),

                        _infoRow('Nama Pemasukan', item['nama'] ?? '-'),
                        _infoRow('Kategori', item['jenis'] ?? '-'),
                        _infoRow('Tanggal Transaksi', item['tanggal'] ?? '-'),
                        _infoRow('Jumlah', item['nominal'] ?? '-'),
                        _infoRow('Tanggal Terverifikasi', '-'),
                        _infoRow('Verifikator', 'Admin Jawara'),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 160,
            child: Text(label, style: const TextStyle(color: Colors.black54)),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}
