import 'package:flutter/material.dart';

class KeluargaScreen extends StatefulWidget {
  const KeluargaScreen({super.key});

  @override
  State<KeluargaScreen> createState() => _KeluargaScreenState();
}

class _KeluargaScreenState extends State<KeluargaScreen> {
  // Sample data
  final List<Map<String, String>> _keluargaData = [
    {
      'no': '1',
      'nama_keluarga': 'Keluarga Varizky Naldiba Rimra',
      'kepala_keluarga': 'Varizky Naldiba Rimra',
      'alamat_rumah': 'i',
      'status_kepemilikan': 'Pemilik',
      'status': 'Aktif',
    },
    {
      'no': '2',
      'nama_keluarga': 'Keluarga Tes',
      'kepala_keluarga': 'Tes',
      'alamat_rumah': 'Tes',
      'status_kepemilikan': 'Penyewa',
      'status': 'Aktif',
    },
    {
      'no': '3',
      'nama_keluarga': 'Keluarga Farhan',
      'kepala_keluarga': 'Farhan',
      'alamat_rumah': 'Griyashanta L203',
      'status_kepemilikan': 'Pemilik',
      'status': 'Aktif',
    },
    {
      'no': '4',
      'nama_keluarga': 'Keluarga Rendha Putra Rahmadya',
      'kepala_keluarga': 'Rendha Putra Rahmadya',
      'alamat_rumah': 'Malang',
      'status_kepemilikan': 'Pemilik',
      'status': 'Aktif',
    },
    {
      'no': '5',
      'nama_keluarga': 'Keluarga Anti Micin',
      'kepala_keluarga': 'Anti Micin',
      'alamat_rumah': 'Malang',
      'status_kepemilikan': 'Penyewa',
      'status': 'Aktif',
    },
    {
      'no': '6',
      'nama_keluarga': 'Keluarga Varizky Naldiba Rimra',
      'kepala_keluarga': 'Varizky Naldiba Rimra',
      'alamat_rumah': 'i',
      'status_kepemilikan': 'Pemilik',
      'status': 'Aktif',
    },
    {
      'no': '7',
      'nama_keluarga': 'Keluarga Ijat',
      'kepala_keluarga': 'Ijat',
      'alamat_rumah': 'Keluar Wilayah',
      'status_kepemilikan': 'Penyewa',
      'status': 'Nonaktif',
    },
    {
      'no': '8',
      'nama_keluarga': 'Keluarga Raudhli Firdaus Naufal',
      'kepala_keluarga': 'Raudhli Firdaus Naufal',
      'alamat_rumah': 'Bogor Raya Permai FJ 2 no 11',
      'status_kepemilikan': 'Pemilik',
      'status': 'Aktif',
    },
    {
      'no': '9',
      'nama_keluarga': 'Keluarga Mara Nunez',
      'kepala_keluarga': 'Mara Nunez',
      'alamat_rumah': 'Malang',
      'status_kepemilikan': 'Pemilik',
      'status': 'Aktif',
    },
    {
      'no': '10',
      'nama_keluarga': 'Keluarga Habibie Ed Dien',
      'kepala_keluarga': 'Habibie Ed Dien',
      'alamat_rumah': 'Blok A49',
      'status_kepemilikan': 'Pemilik',
      'status': 'Aktif',
    },
  ];

  int _currentPage = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Card(
                elevation: 3,
                shadowColor: Colors.black.withOpacity(0.1),
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Header
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Data Keluarga',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 20,
                              color: Colors.black87,
                            ),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF673AB7),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 10),
                              elevation: 0,
                            ),
                            onPressed: () {
                              // TODO: Add filter logic here
                            },
                            child: const Icon(Icons.filter_list,
                                color: Colors.white, size: 22),
                          ),
                        ],
                      ),
                      const Divider(
                          height: 1,
                          thickness: 1,
                          color: Color(0xFFF0F0F0)),
                      const SizedBox(height: 8),

                      // DataTable
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DataTable(
                          headingRowHeight: 44,
                          dataRowHeight: 48,
                          columnSpacing: 24,
                          headingRowColor:
                              MaterialStateProperty.all(Colors.white),
                          columns: const [
                            DataColumn(
                                label: Text('NO',
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12))),
                            DataColumn(
                                label: Text('NAMA KELUARGA',
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12))),
                            DataColumn(
                                label: Text('KEPALA KELUARGA',
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12))),
                            DataColumn(
                                label: Text('ALAMAT RUMAH',
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12))),
                            DataColumn(
                                label: Text('STATUS KEPEMILIKAN',
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12))),
                            DataColumn(
                                label: Text('STATUS',
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12))),
                            DataColumn(
                                label: Text('AKSI',
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12))),
                          ],
                          rows: _keluargaData.map((data) {
                            return DataRow(
                              cells: [
                                DataCell(Text(data['no'] ?? '',
                                    style: const TextStyle(
                                        color: Colors.black87, fontSize: 13))),
                                DataCell(Text(data['nama_keluarga'] ?? '',
                                    style: const TextStyle(
                                        color: Colors.black87, fontSize: 13))),
                                DataCell(Text(data['kepala_keluarga'] ?? '',
                                    style: const TextStyle(
                                        color: Colors.black87, fontSize: 13))),
                                DataCell(Text(data['alamat_rumah'] ?? '',
                                    style: const TextStyle(
                                        color: Colors.black87, fontSize: 13))),
                                DataCell(Text(data['status_kepemilikan'] ?? '',
                                    style: const TextStyle(
                                        color: Colors.black87, fontSize: 13))),
                                DataCell(_buildStatusChip(data['status'] ?? '')),
                                const DataCell(
                                    Icon(Icons.more_horiz, color: Colors.grey)),
                              ],
                            );
                          }).toList(),
                        ),
                      ),

                      const SizedBox(height: 12),
                      _buildPagination(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatusChip(String status) {
    Color backgroundColor;
    Color textColor;
    switch (status) {
      case 'Aktif':
        backgroundColor = const Color(0xFFE8F5E9);
        textColor = const Color(0xFF4CAF50);
        break;
      case 'Nonaktif':
        backgroundColor = const Color(0xFFF2F2F2);
        textColor = const Color(0xFF9E9E9E);
        break;
      default:
        backgroundColor = Colors.grey.shade200;
        textColor = Colors.black87;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status,
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: textColor,
        ),
      ),
    );
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