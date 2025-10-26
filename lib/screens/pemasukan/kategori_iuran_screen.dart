import 'package:flutter/material.dart';

class KategoriIuranScreen extends StatefulWidget {
  const KategoriIuranScreen({super.key});

  @override
  State<KategoriIuranScreen> createState() => _KategoriIuranScreenState();
}

class _KategoriIuranScreenState extends State<KategoriIuranScreen> {
  final List<Map<String, dynamic>> iuranList = [
    {'no': 1, 'nama': 'Asad', 'jenis': 'Iuran Khusus', 'nominal': 'Rp3.000,00'},
    {'no': 2, 'nama': 'YYY', 'jenis': 'Iuran Bulanan', 'nominal': 'Rp5.000,00'},
    {'no': 3, 'nama': 'Harian', 'jenis': 'Iuran Khusus', 'nominal': 'Rp2,00'},
    {
      'no': 4,
      'nama': 'Kerja Bakti',
      'jenis': 'Iuran Khusus',
      'nominal': 'Rp5,00',
    },
    {
      'no': 5,
      'nama': 'Bersih Desa',
      'jenis': 'Iuran Khusus',
      'nominal': 'Rp200.000,00',
    },
    {
      'no': 6,
      'nama': 'Mingguan',
      'jenis': 'Iuran Khusus',
      'nominal': 'Rp12,00',
    },
    {
      'no': 7,
      'nama': 'Agustusan',
      'jenis': 'Iuran Khusus',
      'nominal': 'Rp15,00',
    },
    {
      'no': 8,
      'nama': 'Bulanan',
      'jenis': 'Iuran Bulanan',
      'nominal': 'Rp20.000,00',
    },
  ];

  // FILTER STATE VARIABLES
  List<Map<String, dynamic>> filteredList = [];
  String? selectedJenis = "Semua";
  TextEditingController namaController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredList = List<Map<String, dynamic>>.from(iuranList);
  }

  void _applyFilter() {
    String namaFilter = namaController.text.trim().toLowerCase();
    String? jenisFilter = selectedJenis;
    setState(() {
      filteredList = iuranList.where((item) {
        final namaMatch = namaFilter.isEmpty
            ? true
            : (item['nama'] as String).toLowerCase().contains(namaFilter);
        final jenisMatch = (jenisFilter == null || jenisFilter == "Semua")
            ? true
            : item['jenis'] == jenisFilter;
        return namaMatch && jenisMatch;
      }).toList();
    });
  }

  void _resetFilter() {
    setState(() {
      namaController.clear();
      selectedJenis = "Semua";
      filteredList = List<Map<String, dynamic>>.from(iuranList);
    });
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          title: const Text(
            "Filter Iuran",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Nama Iuran",
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 6),
                TextField(
                  controller: namaController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 10,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  "Jenis Iuran",
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 6),
                DropdownButtonFormField<String>(
                  value: selectedJenis ?? "Semua",
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 10,
                    ),
                  ),
                  items: const [
                    DropdownMenuItem(value: "Semua", child: Text("Semua")),
                    DropdownMenuItem(
                      value: "Iuran Bulanan",
                      child: Text("Iuran Bulanan"),
                    ),
                    DropdownMenuItem(
                      value: "Iuran Khusus",
                      child: Text("Iuran Khusus"),
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      selectedJenis = value;
                    });
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                _resetFilter();
                Navigator.of(context).pop();
              },
              child: const Text("Reset Filter"),
            ),
            ElevatedButton(
              onPressed: () {
                _applyFilter();
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF3E6FAA),
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
  }

  void _showEditDialog(Map<String, dynamic> item) {
    final TextEditingController namaController = TextEditingController(
      text: item['nama'],
    );
    final TextEditingController jumlahController = TextEditingController(
      text: item['nominal'].replaceAll(RegExp(r'[^0-9]'), ''),
    );
    String selectedJenis = item['jenis'];

    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Edit Iuran',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              const Text(
                'Ubah data iuran yang diperlukan.',
                style: TextStyle(color: Colors.black54, fontSize: 13),
              ),
              const SizedBox(height: 16),

              // Nama
              const Text(
                'Nama Iuran',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 6),
              TextField(
                controller: namaController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // Jumlah
              const Text(
                'Jumlah',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 6),
              TextField(
                controller: jumlahController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // Jenis
              const Text(
                'Kategori Iuran',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 6),
              DropdownButtonFormField<String>(
                value: selectedJenis,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
                ),
                items: const [
                  DropdownMenuItem(
                    value: 'Iuran Bulanan',
                    child: Text('Iuran Bulanan'),
                  ),
                  DropdownMenuItem(
                    value: 'Iuran Khusus',
                    child: Text('Iuran Khusus'),
                  ),
                ],
                onChanged: (value) => selectedJenis = value!,
              ),
              const SizedBox(height: 20),

              // Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Batal'),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        item['nama'] = namaController.text;
                        item['jenis'] = selectedJenis;
                        item['nominal'] = "Rp${jumlahController.text},00";
                      });
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF3E6FAA),
                    ),
                    child: const Text(
                      'Simpan',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _confirmDelete(Map<String, dynamic> item) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Konfirmasi Hapus', style: TextStyle(fontSize: 16)),
        content: Text('Yakin ingin menghapus iuran "${item['nama']}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                iuranList.remove(item);
                filteredList.remove(item);
              });
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Hapus', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isMobile = constraints.maxWidth < 600;
        final double horizontalPadding = isMobile ? 8 : 16;
        final double verticalPadding = isMobile ? 12 : 24;
        final double titleFontSize = isMobile ? 16 : 20;
        final double infoFontSize = isMobile ? 10 : 12;
        final double infoTextFontSize = isMobile ? 11 : 13;
        final double buttonFontSize = isMobile ? 12 : 14;
        final double buttonIconSize = isMobile ? 18 : 24;

        return Scaffold(
          backgroundColor: const Color(0xFFF5F7FA),
          body: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding,
              vertical: verticalPadding,
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Info Box
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color(0xFFDDE9FF),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: EdgeInsets.all(isMobile ? 10 : 14),
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'Info: ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text: 'Iuran Bulanan: ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text: 'Dibayar setiap bulan sekali secara rutin. ',
                          ),
                          TextSpan(
                            text: 'Iuran Khusus: ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text:
                                'Dibayar sesuai jadwal atau kebutuhan tertentu.',
                          ),
                        ],
                      ),
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: infoFontSize,
                      ),
                    ),
                  ),
                  SizedBox(height: isMobile ? 12 : 20),

                  // Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Kategori Iuran",
                        style: TextStyle(
                          fontSize: titleFontSize,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      ElevatedButton.icon(
                        onPressed: _showFilterDialog,
                        icon: Icon(
                          Icons.filter_list,
                          color: Colors.white,
                          size: buttonIconSize,
                        ),
                        label: Text(
                          "Filter",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: buttonFontSize,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF3E6FAA),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: isMobile ? 12 : 16,
                            vertical: isMobile ? 8 : 10,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: isMobile ? 12 : 20),

                  // Table inside vertical SingleChildScrollView
                  SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      padding: EdgeInsets.all(isMobile ? 8 : 12),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: isMobile
                            ? FittedBox(
                                fit: BoxFit.scaleDown,
                                alignment: Alignment.centerLeft,
                                child: DataTable(
                                  headingTextStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                    fontSize: buttonFontSize,
                                  ),
                                  dataTextStyle: TextStyle(
                                    fontSize: buttonFontSize,
                                  ),
                                  columns: const [
                                    DataColumn(label: Text("No")),
                                    DataColumn(label: Text("Nama Iuran")),
                                    DataColumn(label: Text("Jenis Iuran")),
                                    DataColumn(label: Text("Nominal")),
                                    DataColumn(label: Text("Aksi")),
                                  ],
                                  rows: filteredList.map((item) {
                                    return DataRow(
                                      cells: [
                                        DataCell(Text(item['no'].toString())),
                                        DataCell(Text(item['nama'])),
                                        DataCell(Text(item['jenis'])),
                                        DataCell(Text(item['nominal'])),
                                        DataCell(
                                          Row(
                                            children: [
                                              IconButton(
                                                icon: Icon(
                                                  Icons.edit,
                                                  color: const Color(
                                                    0xFF3E6FAA,
                                                  ),
                                                  size: buttonIconSize,
                                                ),
                                                onPressed: () =>
                                                    _showEditDialog(item),
                                              ),
                                              IconButton(
                                                icon: Icon(
                                                  Icons.delete,
                                                  color: Colors.red,
                                                  size: buttonIconSize,
                                                ),
                                                onPressed: () =>
                                                    _confirmDelete(item),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    );
                                  }).toList(),
                                ),
                              )
                            : DataTable(
                                headingTextStyle: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                                columns: const [
                                  DataColumn(label: Text("No")),
                                  DataColumn(label: Text("Nama Iuran")),
                                  DataColumn(label: Text("Jenis Iuran")),
                                  DataColumn(label: Text("Nominal")),
                                  DataColumn(label: Text("Aksi")),
                                ],
                                rows: filteredList.map((item) {
                                  return DataRow(
                                    cells: [
                                      DataCell(Text(item['no'].toString())),
                                      DataCell(Text(item['nama'])),
                                      DataCell(Text(item['jenis'])),
                                      DataCell(Text(item['nominal'])),
                                      DataCell(
                                        Row(
                                          children: [
                                            IconButton(
                                              icon: const Icon(
                                                Icons.edit,
                                                color: Color(0xFF3E6FAA),
                                                size: 20,
                                              ),
                                              onPressed: () =>
                                                  _showEditDialog(item),
                                            ),
                                            IconButton(
                                              icon: const Icon(
                                                Icons.delete,
                                                color: Colors.red,
                                                size: 20,
                                              ),
                                              onPressed: () =>
                                                  _confirmDelete(item),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  );
                                }).toList(),
                              ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
