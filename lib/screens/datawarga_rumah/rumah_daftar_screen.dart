import 'package:flutter/material.dart';

class RumahDaftarScreen extends StatefulWidget {
  const RumahDaftarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final rumahList = [
      {'no': '1', 'alamat': 'sssss', 'status': 'Ditempati'},
      {'no': '2', 'alamat': 'jalan suhat', 'status': 'Ditempati'},
      {'no': '3', 'alamat': 'l', 'status': 'Ditempati'},
      {'no': '4', 'alamat': 'Tes', 'status': 'Ditempati'},
      {'no': '5', 'alamat': 'Jl. Merbabu', 'status': 'Tersedia'},
      {'no': '6', 'alamat': 'Malang', 'status': 'Ditempati'},
      {'no': '7', 'alamat': 'Griyashanta L203', 'status': 'Ditempati'},
      {'no': '8', 'alamat': 'werwer', 'status': 'Tersedia'},
      {'no': '9', 'alamat': 'Jl. Baru bangun', 'status': 'Ditempati'},
      {'no': '10', 'alamat': 'fasda', 'status': 'Tersedia'},
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Text(
                "Data Rumah",
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
              const SizedBox(height: 12),

              // Filter button
              Align(
                alignment: Alignment.topRight,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF3E6FAA),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                    elevation: 0,
                  ),
                  onPressed: () {},
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
              const SizedBox(height: 12),

              // Table container
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
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 20,
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return ConstrainedBox(
                        constraints: BoxConstraints(
                          minWidth: constraints.maxWidth,
                        ),
                        child: DataTable(
                          headingTextStyle: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                          columns: const [
                            DataColumn(label: Text("No")),
                            DataColumn(label: Text("Alamat")),
                            DataColumn(label: Text("Status")),
                            DataColumn(label: Text("Aksi")),
                          ],
                          rows: rumahList.map((rumah) {
                            final isTersedia = rumah['status'] == 'Tersedia';
                            return DataRow(
                              cells: [
                                DataCell(Text(rumah['no']!)),
                                DataCell(Text(rumah['alamat']!)),
                                DataCell(
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 6,
                                    ),
                                    decoration: BoxDecoration(
                                      color: isTersedia
                                          ? Colors.green.shade50
                                          : Colors.blue.shade50,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text(
                                      rumah['status']!,
                                      style: TextStyle(
                                        color: isTersedia
                                            ? Colors.green
                                            : Colors.blueAccent,
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
                      );
                    },
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
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Text(
                        "2",
                        style: TextStyle(color: Colors.black87),
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
          ),
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
