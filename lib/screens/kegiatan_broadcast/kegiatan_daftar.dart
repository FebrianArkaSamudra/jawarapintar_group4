import 'package:flutter/material.dart';
import 'detailpage.dart';

class KegiatanDaftar extends StatelessWidget {
  const KegiatanDaftar({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(child: KegiatanTable()),
    );
  }
}

class KegiatanTable extends StatefulWidget {
  const KegiatanTable({super.key});

  @override
  State<KegiatanTable> createState() => _KegiatanTableState();
}

class _KegiatanTableState extends State<KegiatanTable> {
  int currentPage = 1;
  final int itemsPerPage = 5;
  int? hoveredIndex;

  final List<Map<String, String>> data = [
    {
      'no': '1',
      'nama': 'Seminar AI',
      'kategori': 'Akademik',
      'tanggal': '20 Okt 2025 09:00',
      'status': 'Selesai',
    },
    {
      'no': '2',
      'nama': 'Pelatihan Flutter',
      'kategori': 'Teknologi',
      'tanggal': '15 Okt 2025 14:30',
      'status': 'Berlangsung',
    },
    {
      'no': '3',
      'nama': 'Lomba UI/UX',
      'kategori': 'Kompetisi',
      'tanggal': '10 Okt 2025 08:00',
      'status': 'Pendaftaran',
    },
  ];

  int get totalPages => (data.length / itemsPerPage).ceil();

  List<Map<String, String>> get paginatedData {
    int start = (currentPage - 1) * itemsPerPage;
    int end = start + itemsPerPage;
    return data.sublist(start, end.clamp(0, data.length));
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
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Filter Kegiatan',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Nama Kegiatan',
                    hintText: 'Cari nama kegiatan...',
                  ),
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  items: const [
                    DropdownMenuItem(
                      value: 'Akademik',
                      child: Text('Akademik'),
                    ),
                    DropdownMenuItem(
                      value: 'Teknologi',
                      child: Text('Teknologi'),
                    ),
                    DropdownMenuItem(
                      value: 'Kompetisi',
                      child: Text('Kompetisi'),
                    ),
                  ],
                  onChanged: (_) {},
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
          // Tombol filter kanan atas
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

          // Mobile view with cards or desktop view with table
          Flexible(
            child: screenWidth < 600
                ? ListView.separated(
                    itemCount: paginatedData.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 8),
                    padding: EdgeInsets.only(
                      top: 8,
                      bottom: MediaQuery.of(context).viewPadding.bottom + 16,
                    ),
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final item = paginatedData[index];
                      Color statusColor;
                      switch (item['status']?.toLowerCase()) {
                        case 'selesai':
                          statusColor = Colors.green;
                          break;
                        case 'berlangsung':
                          statusColor = Colors.blue;
                          break;
                        case 'pendaftaran':
                          statusColor = Colors.orange;
                          break;
                        default:
                          statusColor = Colors.grey;
                      }

                      return Card(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 0,
                          vertical: 6,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          item['nama']!,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          '${item['kategori']} • ${item['tanggal']}',
                                          style: TextStyle(
                                            color: Colors.grey[600],
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: statusColor.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Text(
                                      item['status']!,
                                      style: TextStyle(
                                        color: statusColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              DetailPage(item: item),
                                        ),
                                      );
                                    },
                                    child: const Text('Detail'),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  )
                : Container(
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
                          // Header tabel
                          Container(
                            color: Colors.grey[50],
                            padding: const EdgeInsets.symmetric(
                              vertical: 16,
                              horizontal: 16,
                            ),
                            child: Row(
                              children: const [
                                Expanded(
                                  flex: 1,
                                  child: Text('NO', style: _headerStyle),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Text(
                                    'NAMA KEGIATAN',
                                    style: _headerStyle,
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Text('KATEGORI', style: _headerStyle),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Text('TANGGAL', style: _headerStyle),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text('STATUS', style: _headerStyle),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Text('AKSI', style: _headerStyle),
                                ),
                              ],
                            ),
                          ),

                          // Data baris
                          ...paginatedData.asMap().entries.map((entry) {
                            int index = entry.key;
                            var item = entry.value;

                            return MouseRegion(
                              onEnter: (_) =>
                                  setState(() => hoveredIndex = index),
                              onExit: (_) =>
                                  setState(() => hoveredIndex = null),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 150),
                                color: hoveredIndex == index
                                    ? Colors.grey[100]
                                    : Colors.white,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 16,
                                  horizontal: 16,
                                ),
                                child: Row(
                                  children: [
                                    Expanded(flex: 1, child: Text(item['no']!)),
                                    Expanded(
                                      flex: 3,
                                      child: Text(item['nama']!),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: Text(item['kategori']!),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: Text(item['tanggal']!),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Text(item['status']!),
                                    ),
                                    Expanded(
                                      flex: 1,
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
                                        itemBuilder: (context) => const [
                                          PopupMenuItem(
                                            value: 'detail',
                                            child: Text('Detail'),
                                          ),
                                        ],
                                        icon: Icon(
                                          Icons.more_horiz,
                                          color: Colors.grey[700],
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
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              IconButton(
                onPressed: currentPage < totalPages ? nextPage : null,
                icon: const Icon(Icons.chevron_right),
                color: currentPage < totalPages
                    ? Colors.grey[700]
                    : Colors.grey[300],
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
