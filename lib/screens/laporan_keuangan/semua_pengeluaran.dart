import 'package:flutter/material.dart';
import 'detailpage.dart';

class SemuaPengeluaran extends StatelessWidget {
  const SemuaPengeluaran({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: TablePage(),
      ),
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
  final int itemsPerPage = 4;
  int? hoveredIndex;

  final List<Map<String, String>> data = [
    {
      'no': '1',
      'nama': 'Kerja Bakti',
      'jenis': 'Pemeliharaan Fasilitas',
      'tanggal': '19 Oct 2025 20:26',
      'nominal': 'Rp 50.000,00',
    },
    {
      'no': '2',
      'nama': 'Kerja Bakti',
      'jenis': 'Kegiatan Warga',
      'tanggal': '19 Oct 2025 20:26',
      'nominal': 'Rp 100.000,00',
    },
    {
      'no': '3',
      'nama': 'Arka',
      'jenis': 'Operasional RT/RW',
      'tanggal': '17 Oct 2025 02:31',
      'nominal': 'Rp 6,00',
    },
    {
      'no': '4',
      'nama': 'adsad',
      'jenis': 'Pemeliharaan Fasilitas',
      'tanggal': '10 Oct 2025 01:08',
      'nominal': 'Rp 2.112,00',
    },
  ];

  int get totalPages => (data.length / itemsPerPage).ceil();

  List<Map<String, String>> get paginatedData {
    int startIndex = (currentPage - 1) * itemsPerPage;
    int endIndex = startIndex + itemsPerPage;
    return data.sublist(startIndex, endIndex.clamp(0, data.length));
  }

  void nextPage() {
    if (currentPage < totalPages) setState(() => currentPage++);
  }

  void previousPage() {
    if (currentPage > 1) setState(() => currentPage--);
  }

  void _showFilterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        TextEditingController nameController = TextEditingController();
        String? selectedCategory;

        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Filter Pengeluaran',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      labelText: 'Nama',
                      hintText: 'Cari nama...',
                    ),
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    value: selectedCategory,
                    items: const [
                      DropdownMenuItem(
                        value: 'Pemeliharaan Fasilitas',
                        child: Text('Pemeliharaan Fasilitas'),
                      ),
                      DropdownMenuItem(
                        value: 'Kegiatan Warga',
                        child: Text('Kegiatan Warga'),
                      ),
                      DropdownMenuItem(
                        value: 'Operasional RT/RW',
                        child: Text('Operasional RT/RW'),
                      ),
                    ],
                    onChanged: (value) => selectedCategory = value,
                    decoration: const InputDecoration(labelText: 'Kategori'),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Reset'),
                      ),
                      const SizedBox(width: 12),
                      ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Terapkan'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          // Tombol Filter kanan atas
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF6366F1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: IconButton(
                  onPressed: () => _showFilterDialog(context),
                  icon: const Icon(Icons.tune, color: Colors.white),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // ✅ Table Full Width
          Expanded(
            child: Container(
              width: screenWidth,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Header
                    Container(
                      color: Colors.grey[50],
                      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                      child: Row(
                        children: const [
                          Expanded(flex: 1, child: Text('NO', style: _headerStyle)),
                          Expanded(flex: 2, child: Text('NAMA', style: _headerStyle)),
                          Expanded(flex: 3, child: Text('JENIS PENGELUARAN', style: _headerStyle)),
                          Expanded(flex: 3, child: Text('TANGGAL', style: _headerStyle)),
                          Expanded(flex: 3, child: Text('NOMINAL', style: _headerStyle)),
                          Expanded(flex: 1, child: Text('AKSI', style: _headerStyle)),
                        ],
                      ),
                    ),

                    // Rows
                    ...paginatedData.asMap().entries.map((entry) {
                      int index = entry.key;
                      var item = entry.value;
                      return MouseRegion(
                        onEnter: (_) => setState(() => hoveredIndex = index),
                        onExit: (_) => setState(() => hoveredIndex = null),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 150),
                          color: hoveredIndex == index ? Colors.grey[100] : Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                          child: Row(
                            children: [
                              Expanded(flex: 1, child: Text(item['no']!)),
                              Expanded(flex: 2, child: Text(item['nama']!)),
                              Expanded(flex: 3, child: Text(item['jenis']!)),
                              Expanded(flex: 3, child: Text(item['tanggal']!)),
                              Expanded(flex: 3, child: Text(item['nominal']!)),
                              Expanded(
                                flex: 1,
                                child: PopupMenuButton<String>(
                                  onSelected: (value) {
                                    if (value == 'detail') {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => detailPage(item: item),
                                        ),
                                      );
                                    }
                                  },
                                  itemBuilder: (BuildContext context) => const [
                                    PopupMenuItem(value: 'detail', child: Text('Detail')),
                                  ],
                                  icon: Icon(Icons.more_horiz, color: Colors.grey[700]),
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

          const SizedBox(height: 20),

          // Pagination
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: currentPage > 1 ? previousPage : null,
                icon: const Icon(Icons.chevron_left),
                color: currentPage > 1 ? Colors.grey[700] : Colors.grey[300],
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
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              IconButton(
                onPressed: currentPage < totalPages ? nextPage : null,
                icon: const Icon(Icons.chevron_right),
                color:
                    currentPage < totalPages ? Colors.grey[700] : Colors.grey[300],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

const TextStyle _headerStyle = TextStyle(
  fontWeight: FontWeight.w600,
  color: Colors.grey,
  fontSize: 13,
  letterSpacing: 0.5,
);
