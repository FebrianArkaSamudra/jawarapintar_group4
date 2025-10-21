import 'package:flutter/material.dart';

class RumahDaftarScreen extends StatefulWidget {
  const RumahDaftarScreen({super.key});

  @override
  State<RumahDaftarScreen> createState() => _RumahDaftarScreenState();
}

class _RumahDaftarScreenState extends State<RumahDaftarScreen> {
  final List<Map<String, String>> _rumahData = [
    {'no': '1', 'alamat': 'sssss', 'status': 'Ditempati'},
    {'no': '2', 'alamat': 'jalan sehat', 'status': 'Ditempati'},
    {'no': '3', 'alamat': 'i', 'status': 'Ditempati'},
    {'no': '4', 'alamat': 'Tes', 'status': 'Ditempati'},
    {'no': '5', 'alamat': 'Jl. Merbabu', 'status': 'Tersedia'},
    {'no': '6', 'alamat': 'Malang', 'status': 'Ditempati'},
    {'no': '7', 'alamat': 'Griyashanta L203', 'status': 'Ditempati'},
    {'no': '8', 'alamat': 'werwer', 'status': 'Tersedia'},
    {'no': '9', 'alamat': 'Jl. Baru Bangun', 'status': 'Ditempati'},
    {'no': '10', 'alamat': 'faeda', 'status': 'Tersedia'},
  ];

  int _currentPage = 1;
  final int _itemsPerPage = 10;

  @override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: const Color(0xFFF5F6FA),
    body: SafeArea(
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch, // 👈 makes card full width
            children: [
              // Header row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Data Rumah',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Colors.black87,
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.filter_list, size: 18),
                    label: const Text(
                      'Filter',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF673AB7),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      elevation: 0,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Full-width Card
              Card(
                color: Colors.white,
                elevation: 3,
                shadowColor: Colors.black.withOpacity(0.1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  child: Column(
                    children: [
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DataTable(
                          columnSpacing: 24,
                          headingRowHeight: 40,
                          dataRowHeight: 48,
                          headingRowColor:
                              MaterialStateProperty.all(Colors.white),
                          columns: [
                            DataColumn(
                              label: Text(
                                'NO',
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'ALAMAT',
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'STATUS',
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'AKSI',
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                          rows: _rumahData.map((data) {
                            return DataRow(
                              cells: [
                                DataCell(Text(data['no']!,
                                    style: const TextStyle(
                                        color: Colors.black87, fontSize: 13))),
                                DataCell(SizedBox(
                                  width: 200,
                                  child: Text(data['alamat']!,
                                      style: const TextStyle(
                                          color: Colors.black87, fontSize: 13),
                                      overflow: TextOverflow.ellipsis),
                                )),
                                DataCell(_buildStatusChip(data['status']!)),
                                const DataCell(Icon(Icons.more_horiz,
                                    color: Colors.grey)),
                              ],
                            );
                          }).toList(),
                        ),
                      ),
                      const SizedBox(height: 16),
                      _buildPagination(),
                    ],
                  ),
                ),
              ),
            ],
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
      case 'Ditempati':
        backgroundColor = const Color(0xFFE3F2FD);
        textColor = const Color(0xFF1565C0);
        break;
      case 'Tersedia':
        backgroundColor = const Color(0xFFE8F5E9);
        textColor = const Color(0xFF4CAF50);
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
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: textColor,
        ),
      ),
    );
  }

  Widget _buildPagination() {
    final int totalPages = (_rumahData.length / _itemsPerPage).ceil();
    List<Widget> pageButtons = [];

    // Left arrow
    pageButtons.add(
      IconButton(
        icon: Icon(
          Icons.chevron_left,
          color: _currentPage == 1 ? Colors.grey : Colors.black87,
        ),
        onPressed: _currentPage == 1
            ? null
            : () {
                setState(() {
                  _currentPage--;
                });
              },
      ),
    );

    for (int i = 1; i <= totalPages; i++) {
      final bool isActive = i == _currentPage;
      pageButtons.add(
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: GestureDetector(
            onTap: () {
              setState(() {
                _currentPage = i;
              });
            },
            child: Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: isActive ? const Color(0xFF673AB7).withOpacity(0.14) : Colors.transparent,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Text(
                '$i',
                style: TextStyle(
                  color: isActive ? const Color(0xFF673AB7) : Colors.grey,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ),
      );
    }

    // Right arrow
    pageButtons.add(
      IconButton(
        icon: Icon(
          Icons.chevron_right,
          color: _currentPage == totalPages ? Colors.grey : Colors.black87,
        ),
        onPressed: _currentPage == totalPages
            ? null
            : () {
                setState(() {
                  _currentPage++;
                });
              },
      ),
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: pageButtons,
    );
  }
}
