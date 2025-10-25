import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  final Map<String, String> item;

  const DetailPage({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final double maxContentWidth = 1000;
    final screenWidth = MediaQuery.of(context).size.width;

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
                  'Detail Kegiatan',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),

                _buildRow('Nama Kegiatan', item['nama'] ?? item['judul'] ?? ''),
                _buildRow('Kategori', item['kategori'] ?? ''),
                _buildRow('Tanggal Pelaksanaan', item['tanggal'] ?? ''),
                _buildRow('Status', item['status'] ?? ''),

                if (item.containsKey('pengirim'))
                  _buildRow('Pengirim', item['pengirim']!),
                if (item.containsKey('keterangan'))
                  _buildRow('Keterangan', item['keterangan']!),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRow(String label, String value) {
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
          Expanded(child: Text(value, style: const TextStyle(fontSize: 15))),
        ],
      ),
    );
  }
}

class FilterDialog extends StatefulWidget {
  const FilterDialog({super.key});

  @override
  State<FilterDialog> createState() => _FilterDialogState();
}

class _FilterDialogState extends State<FilterDialog> {
  final TextEditingController _queryController = TextEditingController();
  String? _selectedKategori;

  final List<String> _kategoriOptions = [
    'Semua',
    'Akademik',
    'Teknologi',
    'Kompetisi',
  ];

  void _reset() {
    setState(() {
      _queryController.clear();
      _selectedKategori = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 600),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Filter',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),

              TextField(
                controller: _queryController,
                decoration: const InputDecoration(
                  labelText: 'Cari (judul / pengirim)',
                  hintText: 'Masukkan kata kunci...',
                ),
              ),

              const SizedBox(height: 12),

              DropdownButtonFormField<String>(
                value: _selectedKategori,
                items: _kategoriOptions
                    .map((k) => DropdownMenuItem(value: k, child: Text(k)))
                    .toList(),
                onChanged: (v) => setState(() => _selectedKategori = v),
                decoration: const InputDecoration(labelText: 'Kategori'),
              ),

              const SizedBox(height: 18),

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      _reset();
                    },
                    child: const Text('Reset'),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton(
                    onPressed: () {
                      // Return filter results to caller
                      Navigator.of(context).pop({
                        'query': _queryController.text.isEmpty
                            ? null
                            : _queryController.text,
                        'kategori': _selectedKategori,
                      });
                    },
                    child: const Text('Terapkan'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
