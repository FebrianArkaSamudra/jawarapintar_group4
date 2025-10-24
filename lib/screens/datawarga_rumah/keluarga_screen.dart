import 'package:flutter/material.dart';

class KeluargaScreen extends StatefulWidget {
  const KeluargaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final keluargaList = [
      {
        'no': '1',
        'nama': 'Keluarga Varizky Naldiba Rimra',
        'kepala': 'Varizky Naldiba Rimra',
        'alamat': 'i',
        'kepemilikan': 'Pemilik',
        'status': 'Aktif',
      },
      {
        'no': '2',
        'nama': 'Keluarga Tes',
        'kepala': 'Tes',
        'alamat': 'Tes',
        'kepemilikan': 'Penyewa',
        'status': 'Aktif',
      },
      {
        'no': '3',
        'nama': 'Keluarga Farhan',
        'kepala': 'Farhan',
        'alamat': 'Griyashanta L203',
        'kepemilikan': 'Pemilik',
        'status': 'Aktif',
      },
      {
        'no': '7',
        'nama': 'Keluarga Ijat',
        'kepala': 'Ijat',
        'alamat': 'Keluar Wilayah',
        'kepemilikan': 'Penyewa',
        'status': 'Nonaktif',
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Text(
              "Data Keluarga",
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.topRight,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3E6FAA),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(Icons.filter_list, size: 20, color: Colors.white),
                    SizedBox(width: 6),
                    Text(
                      'Filter',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Table container
            Expanded(
              child: Container(
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
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: DataTable(
                      headingTextStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                      columns: const [
                        DataColumn(label: Text("No")),
                        DataColumn(label: Text("Nama Keluarga")),
                        DataColumn(label: Text("Kepala Keluarga")),
                        DataColumn(label: Text("Alamat Rumah")),
                        DataColumn(label: Text("Status Kepemilikan")),
                        DataColumn(label: Text("Status")),
                        DataColumn(label: Text("Aksi")),
                      ],
                      rows: keluargaList.map((keluarga) {
                        final isActive = keluarga['status'] == 'Aktif';
                        return DataRow(
                          cells: [
                            DataCell(Text(keluarga['no']!)),
                            DataCell(Text(keluarga['nama']!)),
                            DataCell(Text(keluarga['kepala']!)),
                            DataCell(Text(keluarga['alamat']!)),
                            DataCell(Text(keluarga['kepemilikan']!)),
                            DataCell(
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: isActive
                                      ? Colors.green.shade50
                                      : Colors.red.shade50,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  keluarga['status']!,
                                  style: TextStyle(
                                    color: isActive ? Colors.green : Colors.red,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                            DataCell(
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.more_horiz),
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Pagination (static sample)
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.arrow_left),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color(0xFF3E6FAA),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Text(
                      "1",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.arrow_right),
                  ),
                ],
              ),
            ),
          ],
        ), // ✅ closes Column
      ), // ✅ closes Padding
    ); // ✅ closes Scaffold
  }

  Widget _buildPagination() {
    const int totalPages = 1;
    List<Widget> pageButtons = [];

    for (int i = 1; i <= totalPages; i++) {
      final bool isActive = i == _currentPage;
      pageButtons.add(
        GestureDetector(
          onTap: () {
            if (!isActive) {
              setState(() => _currentPage = i);
            }
          },
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 4),
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: isActive
                  ? const Color(0xFF673AB7).withOpacity(0.14)
                  : Colors.transparent,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Text(
              '$i',
              style: TextStyle(
                color: isActive ? const Color(0xFF673AB7) : Colors.grey,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: const Icon(Icons.chevron_left),
          color: _currentPage == 1 ? Colors.grey : const Color(0xFF673AB7),
          onPressed:
              _currentPage == 1 ? null : () => setState(() => _currentPage--),
        ),
        ...pageButtons,
        IconButton(
          icon: const Icon(Icons.chevron_right),
          color: _currentPage == totalPages ? Colors.grey : const Color(0xFF673AB7),
          onPressed:
              _currentPage == totalPages ? null : () => setState(() => _currentPage++),
        ),
      ],
    );
  }
}