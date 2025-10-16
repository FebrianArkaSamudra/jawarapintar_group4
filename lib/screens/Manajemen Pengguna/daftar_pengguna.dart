import 'package:flutter/material.dart';

class RegistrasiPage extends StatefulWidget {
  const RegistrasiPage({Key? key}) : super(key: key);

  @override
  State<RegistrasiPage> createState() => _RegistrasiPageState();
}

class _RegistrasiPageState extends State<RegistrasiPage> {
  final TextEditingController _namaController = TextEditingController();
  String? selectedStatus;

  final List<Map<String, String>> data = [
    {
      "no": "1",
      "nama": "Rendha Putra Rahmadya",
      "email": "rendhazuper@gmail.com",
      "status": "Diterima",
    },
    {"no": "2", "nama": "bla", "email": "y@gmail.com", "status": "Diterima"},
    {
      "no": "3",
      "nama": "Anti Micin",
      "email": "antimicin3@gmail.com",
      "status": "Diterima",
    },
    {
      "no": "4",
      "nama": "ijat4",
      "email": "ijat4@gmail.com",
      "status": "Diterima",
    },
    {
      "no": "5",
      "nama": "ijat3",
      "email": "ijat3@gmail.com",
      "status": "Diterima",
    },
    {
      "no": "6",
      "nama": "ijat2",
      "email": "ijat2@gmail.com",
      "status": "Diterima",
    },
    {
      "no": "7",
      "nama": "AFIFAH KHOIRUNNISA",
      "email": "afi@gmail.com",
      "status": "Diterima",
    },
    {
      "no": "8",
      "nama": "Raudhil Firdaus Naufal",
      "email": "raudhilfirdausn@gmail.com",
      "status": "Diterima",
    },
    {
      "no": "9",
      "nama": "varizky naldiba rimra",
      "email": "zelectra1011@gmail.com",
      "status": "Diterima",
    },
  ];

  List<Map<String, String>> filteredData = [];

  @override
  void initState() {
    super.initState();
    filteredData = List.from(data);
  }

  void _openFilterDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Filter Manajemen Pengguna",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Nama input
                const Text(
                  "Nama",
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 6),
                TextField(
                  controller: _namaController,
                  decoration: InputDecoration(
                    hintText: "Cari nama...",
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

                // Status dropdown
                const Text(
                  "Status",
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 6),
                DropdownButtonFormField<String>(
                  value: selectedStatus,
                  items: const [
                    DropdownMenuItem(
                      value: null,
                      child: Text("-- Pilih Status --"),
                    ),
                    DropdownMenuItem(
                      value: "Diterima",
                      child: Text("Diterima"),
                    ),
                    DropdownMenuItem(value: "Pending", child: Text("Pending")),
                    DropdownMenuItem(value: "Ditolak", child: Text("Ditolak")),
                  ],
                  onChanged: (value) {
                    setState(() {
                      selectedStatus = value;
                    });
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 10,
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Search button
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6C63FF),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 28,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      _applyFilter();
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Cari",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _applyFilter() {
    setState(() {
      filteredData = data.where((row) {
        final namaMatch =
            _namaController.text.isEmpty ||
            row["nama"]!.toLowerCase().contains(
              _namaController.text.toLowerCase(),
            );
        final statusMatch =
            selectedStatus == null || row["status"] == selectedStatus;
        return namaMatch && statusMatch;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FB),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Top filter button row
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton.icon(
                      onPressed: _openFilterDialog,
                      icon: const Icon(
                        Icons.filter_list_alt,
                        color: Colors.white,
                      ),
                      label: const Text(""),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF6C63FF),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.all(12),
                      ),
                    ),
                  ],
                ),
              ),

              // Table header
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 14,
                  horizontal: 20,
                ),
                color: Colors.white,
                child: const Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Text(
                        "NO",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Text(
                        "NAMA",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Text(
                        "EMAIL",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Text(
                        "STATUS REGISTRASI",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        "AKSI",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(height: 1),

              // Table rows
              Expanded(
                child: ListView.builder(
                  itemCount: filteredData.length,
                  itemBuilder: (context, index) {
                    final row = filteredData[index];
                    return Column(
                      children: [
                        Container(
                          color: index == 0
                              ? Colors.grey.shade100
                              : Colors.transparent,
                          padding: const EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 20,
                          ),
                          child: Row(
                            children: [
                              Expanded(flex: 1, child: Text(row["no"]!)),
                              Expanded(flex: 3, child: Text(row["nama"]!)),
                              Expanded(flex: 4, child: Text(row["email"]!)),
                              Expanded(
                                flex: 3,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.green.shade100,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    row["status"]!,
                                    style: const TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    PopupMenuButton<String>(
                                      onSelected: (value) {
                                        if (value == 'detail') {
                                          Navigator.pushNamed(
                                            context,
                                            '/detailPage',
                                          );
                                        } else if (value == 'edit') {
                                          Navigator.pushNamed(
                                            context,
                                            '/editPage',
                                          );
                                        }
                                      },
                                      itemBuilder: (context) => [
                                        const PopupMenuItem(
                                          value: 'detail',
                                          child: Text('Show Details'),
                                        ),
                                        const PopupMenuItem(
                                          value: 'edit',
                                          child: Text('Edit'),
                                        ),
                                      ],
                                      child: const Icon(Icons.more_horiz),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Divider(height: 1),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
