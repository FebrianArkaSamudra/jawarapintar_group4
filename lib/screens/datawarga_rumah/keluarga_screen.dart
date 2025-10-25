import 'package:flutter/material.dart';

class KeluargaScreen extends StatefulWidget {
  const KeluargaScreen({super.key});

  @override
  State<KeluargaScreen> createState() => _KeluargaScreenState();
}

class _KeluargaScreenState extends State<KeluargaScreen> {
  int _currentPage = 1;

  // Filters (persisted)
  String? selectedStatus;
  String? selectedRumah; // corresponds to 'kepemilikan' in data
  final TextEditingController namaController = TextEditingController();

  // Full data (source of truth)
  final List<Map<String, String>> keluargaList = [
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

  // Filtered list shown in the table
  late List<Map<String, String>> filteredList;

  @override
  void initState() {
    super.initState();
    filteredList = List.from(keluargaList);
  }

  @override
  void dispose() {
    namaController.dispose();
    super.dispose();
  }

  void applyFilter() {
    final String namaQuery = namaController.text.trim().toLowerCase();

    setState(() {
      filteredList = keluargaList.where((item) {
        final matchesNama =
            namaQuery.isEmpty ||
            item['nama']!.toLowerCase().contains(namaQuery) ||
            item['kepala']!.toLowerCase().contains(namaQuery);

        final matchesStatus =
            (selectedStatus == null || selectedStatus!.isEmpty) ||
            item['status'] == selectedStatus;

        final matchesRumah =
            (selectedRumah == null || selectedRumah!.isEmpty) ||
            item['kepemilikan'] == selectedRumah;

        return matchesNama && matchesStatus && matchesRumah;
      }).toList();
      _currentPage = 1; // reset pagination if you use pages later
    });
  }

  void resetFilter() {
    setState(() {
      namaController.clear();
      selectedStatus = null;
      selectedRumah = null;
      filteredList = List.from(keluargaList);
      _currentPage = 1;
    });
  }

  void _openFilterDialog() {
    // Use temporary local variables so the dialog UI can update independently.
    String tempNama = namaController.text;
    String? tempStatus = selectedStatus;
    String? tempRumah = selectedRumah;

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
                'Filter Keluarga',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              content: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Nama"),
                    const SizedBox(height: 6),
                    TextField(
                      controller: TextEditingController.fromValue(
                        TextEditingValue(
                          text: tempNama,
                          selection: TextSelection.collapsed(
                            offset: tempNama.length,
                          ),
                        ),
                      ),
                      onChanged: (v) => tempNama = v,
                      decoration: InputDecoration(
                        hintText: 'Cari nama...',
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
                        DropdownMenuItem(value: "Aktif", child: Text("Aktif")),
                        DropdownMenuItem(
                          value: "Nonaktif",
                          child: Text("Nonaktif"),
                        ),
                      ],
                      onChanged: (value) =>
                          setStateDialog(() => tempStatus = value),
                    ),
                    const SizedBox(height: 16),
                    const Text("Rumah"),
                    const SizedBox(height: 6),
                    DropdownButtonFormField<String>(
                      value: tempRumah,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 10,
                        ),
                      ),
                      hint: const Text("-- Pilih Rumah --"),
                      items: const [
                        DropdownMenuItem(
                          value: "Pemilik",
                          child: Text("Pemilik"),
                        ),
                        DropdownMenuItem(
                          value: "Penyewa",
                          child: Text("Penyewa"),
                        ),
                      ],
                      onChanged: (value) =>
                          setStateDialog(() => tempRumah = value),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    // Reset both temp and persistent filters
                    setState(() {
                      namaController.clear();
                      selectedStatus = null;
                      selectedRumah = null;
                      filteredList = List.from(keluargaList);
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
                    // Commit dialog values to the screen state and apply filter
                    setState(() {
                      namaController.text = tempNama;
                      selectedStatus = tempStatus;
                      selectedRumah = tempRumah;
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
    // Note: keluargaList is the full data, filteredList is shown in table.
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

            // Filter button
            Align(
              alignment: Alignment.topRight,
              child: ElevatedButton(
                onPressed: _openFilterDialog,
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
                      rows: filteredList.map((keluarga) {
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

            // Pagination
            _buildPagination(),
          ],
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
