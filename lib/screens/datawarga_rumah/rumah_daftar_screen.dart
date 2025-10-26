import 'package:flutter/material.dart';
import 'rumah_detail_screen.dart';
import 'rumah_edit_screen.dart';

class RumahDaftarScreen extends StatefulWidget {
  const RumahDaftarScreen({super.key});

  @override
  State<RumahDaftarScreen> createState() => _RumahDaftarScreenState();
}

class _RumahDaftarScreenState extends State<RumahDaftarScreen> {
  int _currentPage = 1;

  final List<Map<String, String>> rumahList = [
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

  List<Map<String, String>> filteredList = [];

  String? selectedStatus;
  final TextEditingController alamatController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredList = List.from(rumahList);
  }

  void applyFilter() {
    String searchAlamat = alamatController.text.toLowerCase();
    String? status = selectedStatus;

    setState(() {
      filteredList = rumahList.where((rumah) {
        final alamatLower = rumah['alamat']!.toLowerCase();
        final matchesAlamat = alamatLower.contains(searchAlamat);
        final matchesStatus = status == null || status.isEmpty
            ? true
            : rumah['status'] == status;
        return matchesAlamat && matchesStatus;
      }).toList();
    });
  }

  void resetFilter() {
    setState(() {
      selectedStatus = null;
      alamatController.clear();
      filteredList = List.from(rumahList);
    });
  }

  void _showFilterDialog() {
    String tempAlamat = alamatController.text;
    String? tempStatus = selectedStatus;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              title: const Text(
                'Filter Data Rumah',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              content: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Alamat"),
                    const SizedBox(height: 6),
                    TextField(
                      controller: TextEditingController.fromValue(
                        TextEditingValue(
                          text: tempAlamat,
                          selection: TextSelection.collapsed(
                            offset: tempAlamat.length,
                          ),
                        ),
                      ),
                      onChanged: (v) => tempAlamat = v,
                      decoration: InputDecoration(
                        hintText: 'Cari alamat...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 10,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text("Status"),
                    const SizedBox(height: 6),
                    DropdownButtonFormField<String>(
                      value: tempStatus,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 10,
                        ),
                      ),
                      hint: const Text("-- Pilih Status --"),
                      items: const [
                        DropdownMenuItem(
                          value: "Ditempati",
                          child: Text("Ditempati"),
                        ),
                        DropdownMenuItem(
                          value: "Tersedia",
                          child: Text("Tersedia"),
                        ),
                      ],
                      onChanged: (value) =>
                          setStateDialog(() => tempStatus = value),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    setState(() {
                      alamatController.clear();
                      selectedStatus = null;
                      filteredList = List.from(rumahList);
                    });
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Reset Filter",
                    style: TextStyle(color: Colors.black87),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      alamatController.text = tempAlamat;
                      selectedStatus = tempStatus;
                      applyFilter();
                    });
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Filter diterapkan!"),
                        duration: Duration(seconds: 1),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF3E6FAA),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    "Terapkan",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

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
                onPressed: _showFilterDialog,
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
                  rows: filteredList.map((rumah) {
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
                          PopupMenuButton<String>(
                            icon: const Icon(Icons.more_horiz),
                            itemBuilder: (context) {
                              final isTersedia = rumah['status'] == 'Tersedia';
                              return [
                                const PopupMenuItem(
                                  value: 'detail',
                                  child: Text('Detail'),
                                ),
                                if (isTersedia)
                                  const PopupMenuItem(
                                    value: 'edit',
                                    child: Text('Edit'),
                                  ),
                                if (isTersedia)
                                  const PopupMenuItem(
                                    value: 'hapus',
                                    child: Text('Hapus'),
                                  ),
                              ];
                            },
                            onSelected: (value) {
                              if (value == 'detail') {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (_) =>
                                        RumahDetailScreen(rumah: rumah),
                                  ),
                                );
                              } else if (value == 'edit') {
                                final idx = rumahList.indexWhere(
                                  (e) => e['no'] == rumah['no'],
                                );
                                if (idx != -1) {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (_) => RumahEditScreen(
                                        rumah: rumahList[idx],
                                        onSave: (updated) {
                                          setState(() {
                                            rumahList[idx] = updated;
                                            applyFilter();
                                          });
                                        },
                                      ),
                                    ),
                                  );
                                }
                              } else if (value == 'hapus') {
                                _showDeleteDialog(rumah);
                              }
                            },
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

  void _showDeleteDialog(Map<String, String> rumah) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: const Text('Konfirmasi Hapus'),
        content: Text('Yakin ingin menghapus rumah "${rumah['alamat']}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                rumahList.removeWhere((r) => r['no'] == rumah['no']);
                applyFilter();
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Rumah berhasil dihapus'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Hapus', style: TextStyle(color: Colors.white)),
          ),
        ],
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
