import 'package:flutter/material.dart';
import 'detail_page.dart';

class Daftar extends StatelessWidget {
  const Daftar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F7),
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
      ),
      body: const Padding(padding: EdgeInsets.all(16.0), child: TablePage()),
    );
  }
}

class TablePage extends StatefulWidget {
  const TablePage({super.key});

  @override
  State<TablePage> createState() => _TablePageState();
}

class _TablePageState extends State<TablePage> {
  int currentPage = 1;
  final int itemsPerPage = 1;
  int? hoveredIndex;

  final List<Map<String, String>> data = [
    {
      'no': '1',
      'nama': 'adsad',
      'jenis': 'Pemeliharaan Fasilitas',
      'tanggal': '02 Oktober 2025',
      'nominal': 'Rp 2.112,00',
    },
    {
      'no': '2',
      'nama': 'test',
      'jenis': 'Pemeliharaan Fasilitas',
      'tanggal': '03 Oktober 2025',
      'nominal': 'Rp 3.000,00',
    },
    {
      'no': '3',
      'nama': 'contoh',
      'jenis': 'Pemeliharaan Fasilitas',
      'tanggal': '04 Oktober 2025',
      'nominal': 'Rp 1.500,00',
    },
  ];

  int get totalPages => (data.length / itemsPerPage).ceil();

  List<Map<String, String>> get paginatedData {
    int startIndex = (currentPage - 1) * itemsPerPage;
    int endIndex = startIndex + itemsPerPage;
    return data.sublist(startIndex, endIndex.clamp(0, data.length));
  }

  void nextPage() {
    if (currentPage < totalPages) {
      setState(() => currentPage++);
    }
  }

  void previousPage() {
    if (currentPage > 1) {
      setState(() => currentPage--);
    }
  }

void _showFilterDialog(BuildContext context) {
  final screenWidth = MediaQuery.of(context).size.width;
  final maxDialogWidth = 600.0; // agar tidak terlalu lebar
  final containerPadding = 16.0; // sama dengan padding kontainer utama

    showDialog(
      context: context,
      builder: (context) {
        // Form controllers
        TextEditingController nameController = TextEditingController();
        TextEditingController startDateController = TextEditingController();
        TextEditingController endDateController = TextEditingController();
        String? selectedCategory;

        return Dialog(
          insetPadding: EdgeInsets.only(
            left: containerPadding + 40, // geser sedikit ke kanan
            right: containerPadding + 40,
            top: 24,
            bottom: 24,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: maxDialogWidth,
              minWidth: 400,
            ),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Judul
                    const Text(
                      'Filter Pengeluaran',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Nama
                    const Text('Nama'),
                    TextField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        hintText: 'Cari nama...',
                      ),
                    ),
                    const SizedBox(height: 16),

                  // Kategori
                  const Text('Kategori'),
                  DropdownButtonFormField<String>(
                    value: selectedCategory,
                    items: const [
                      DropdownMenuItem(value: 'Pemeliharaan', child: Text('Pemeliharaan')),
                      DropdownMenuItem(value: 'Operasional', child: Text('Operasional')),
                    ],
                    onChanged: (value) {
                      selectedCategory = value;
                    },
                    decoration: const InputDecoration(
                      hintText: '-- Pilih Kategori --',
                    ),
                  ),
                  const SizedBox(height: 16),

                    // Dari Tanggal
                    const Text('Dari Tanggal'),
                    TextField(
                      controller: startDateController,
                      readOnly: true,
                      decoration: InputDecoration(
                        hintText: '--/--/----',
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.calendar_today),
                          onPressed: () async {
                            DateTime? picked = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2100),
                            );
                            if (picked != null) {
                              startDateController.text =
                                  '${picked.day}/${picked.month}/${picked.year}';
                            }
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Sampai Tanggal
                    const Text('Sampai Tanggal'),
                    TextField(
                      controller: endDateController,
                      readOnly: true,
                      decoration: InputDecoration(
                        hintText: '--/--/----',
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.calendar_today),
                          onPressed: () async {
                            DateTime? picked = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2100),
                            );
                            if (picked != null) {
                              endDateController.text =
                                  '${picked.day}/${picked.month}/${picked.year}';
                            }
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Tombol
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Reset Filter'),
                        ),
                        const SizedBox(width: 16),
                        ElevatedButton(
                          onPressed: () {
                            // Terapkan filter di sini
                            Navigator.pop(context);
                          },
                          child: const Text('Terapkan'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final double maxContentWidth = 1000;
    final screenWidth = MediaQuery.of(context).size.width;
    return Center(
      child: Container(
        width: screenWidth < maxContentWidth ? screenWidth : maxContentWidth,
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
          children: [
            // Tombol filter
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF6366F1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: IconButton(
                    onPressed: () {
                      _showFilterDialog(context);
                    },
                    icon: const Icon(Icons.tune),
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Bagian tabel
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: ConstrainedBox(
                  constraints: const BoxConstraints(minWidth: 800),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFEEF2FF),
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: Row(
                          children: [
                            _buildHeaderCell('NO', 60),
                            _buildHeaderCell('NAMA', 120),
                            _buildHeaderCell('JENIS PENGELUARAN', 230),
                            _buildHeaderCell('TANGGAL', 160),
                            _buildHeaderCell('NOMINAL', 140),
                            _buildHeaderCell('AKSI', 80),
                          ],
                        ),
                      ),
                      Container(height: 1, color: Colors.grey.shade300),
                      ...paginatedData.asMap().entries.map((entry) {
                        int index = entry.key;
                        var item = entry.value;

                        return MouseRegion(
                          onEnter: (_) => setState(() => hoveredIndex = index),
                          onExit: (_) => setState(() => hoveredIndex = null),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 150),
                            decoration: BoxDecoration(
                              color: hoveredIndex == index
                                  ? const Color(0xFFF3F4F6)
                                  : Colors.white,
                              border: Border(
                                bottom: BorderSide(color: Colors.grey.shade300),
                              ),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 14.0),
                            child: Row(
                              children: [
                                _buildCell(item['no']!, 60),
                                _buildCell(item['nama']!, 120),
                                _buildCell(item['jenis']!, 230),
                                _buildCell(item['tanggal']!, 160),
                                _buildCell(item['nominal']!, 140),
                                SizedBox(
                                  width: 80,
                                  child: PopupMenuButton<String>(
                                    onSelected: (value) {
                                      if (value == 'detail') {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                DetailPage(item: item),
                                          ),
                                        );
                                      }
                                    },
                                    itemBuilder: (BuildContext context) => [
                                      const PopupMenuItem(
                                        value: 'detail',
                                        child: Text('Detail'),
                                      ),
                                    ],
                                    icon: Icon(
                                      Icons.more_vert,
                                      color: Colors.grey[400],
                                      size: 20,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Divider(thickness: 1),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: previousPage,
                  icon: const Icon(Icons.chevron_left),
                ),
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: const Color(0xFF6366F1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      currentPage.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: nextPage,
                  icon: const Icon(Icons.chevron_right),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderCell(String text, double width) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        border: Border(right: BorderSide(color: Colors.grey.shade300)),
      ),
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Color(0xFF374151),
          fontSize: 13,
        ),
      ),
    );
  }

  Widget _buildCell(String text, double width) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        border: Border(right: BorderSide(color: Colors.grey.shade200)),
      ),
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Text(
        text,
        style: const TextStyle(color: Color(0xFF1F2937), fontSize: 14),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
