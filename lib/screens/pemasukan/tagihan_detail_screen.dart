import 'package:flutter/material.dart';

class TagihanDetailScreen extends StatelessWidget {
  final Map<String, dynamic> item;
  const TagihanDetailScreen({super.key, required this.item});

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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Detail Tagihan',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: gap * 1.5),

                        _infoRow(
                          'Kode Tagihan',
                          item['kodeTagihan']?.toString() ?? '-',
                        ),
                        _infoRow(
                          'Nama Keluarga',
                          item['nama']?.toString() ?? '-',
                        ),
                        _infoRow(
                          'Status Keluarga',
                          item['statusKeluarga']?.toString() ?? '-',
                        ),
                        _infoRow('Iuran', item['iuran']?.toString() ?? '-'),
                        _infoRow('Periode', item['periode']?.toString() ?? '-'),
                        _infoRow('Nominal', item['nominal']?.toString() ?? '-'),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              width: 160,
                              child: Text(
                                'Status',
                                style: TextStyle(color: Colors.black54),
                              ),
                            ),
                            _statusPill(item['status']?.toString() ?? '-'),
                          ],
                        ),
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

  Widget _statusPill(String text) {
    final bool paid = text.toLowerCase().contains('sudah');
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: paid ? Colors.green[100] : Colors.yellow[100],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: paid ? Colors.green : Colors.orange,
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
      ),
    );
  }
}
