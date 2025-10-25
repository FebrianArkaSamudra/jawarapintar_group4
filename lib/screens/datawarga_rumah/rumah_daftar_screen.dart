import 'package:flutter/material.dart';

class RumahDaftarScreen extends StatefulWidget {
  const RumahDaftarScreen({super.key});

  @override
  State<RumahDaftarScreen> createState() => _RumahDaftarScreenState();
}

class _RumahDaftarScreenState extends State<RumahDaftarScreen> {
  int _currentPage = 1;

  final rumahList = [
    {'no': '1', 'alamat': 'sssss', 'status': 'Ditempati'},
    {'no': '2', 'alamat': 'Jalan Suhat', 'status': 'Ditempati'},
    {'no': '3', 'alamat': 'l', 'status': 'Ditempati'},
    {'no': '4', 'alamat': 'Tes', 'status': 'Ditempati'},
    {'no': '5', 'alamat': 'Jl. Merbabu', 'status': 'Tersedia'},
    {'no': '6', 'alamat': 'Malang', 'status': 'Ditempati'},
    {'no': '7', 'alamat': 'Griyashanta L203', 'status': 'Ditempati'},
    {'no': '8', 'alamat': 'werwer', 'status': 'Tersedia'},
    {'no': '9', 'alamat': 'Jl. Baru Bangun', 'status': 'Ditempati'},
    {'no': '10', 'alamat': 'fasda', 'status': 'Tersedia'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      body: SingleChildScrollView(
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
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
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

            // --- MODIFIED SECTION ---
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
              // We only apply vertical padding to the container
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: SingleChildScrollView(
                // This makes the table scrollable from left-to-right
                scrollDirection: Axis.horizontal,
                // We apply horizontal padding here, inside the scroll
                padding: const EdgeInsets.symmetric(horizontal: 24),
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
              ),
            ),

            // --- END OF MODIFIED SECTION ---
            const SizedBox(height: 20),

            // Pagination
            _buildPagination(),
          ],
        ),
      ),
    );
  }

  Widget _buildPagination() {
    const int totalPages = 2; // Example: total 2 pages for now
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
              color: isActive ? const Color(0xFF3E6FAA) : Colors.transparent,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Text(
              '$i',
              style: TextStyle(
                color: isActive ? Colors.white : Colors.grey,
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
          color: _currentPage == 1 ? Colors.grey : const Color(0xFF3E6FAA),
          onPressed: _currentPage == 1
              ? null
              : () => setState(() => _currentPage--),
        ),
        ...pageButtons,
        IconButton(
          icon: const Icon(Icons.chevron_right),
          color: _currentPage == totalPages
              ? Colors.grey
              : const Color(0xFF3E6FAA),
          onPressed: _currentPage == totalPages
              ? null
              : () => setState(() => _currentPage++),
        ),
      ],
    );
  }
}
