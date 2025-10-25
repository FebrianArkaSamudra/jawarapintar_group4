import 'package:flutter/material.dart';
import 'detailpage2.dart';

class BroadcastDaftar extends StatefulWidget {
  const BroadcastDaftar({super.key});

  @override
  State<BroadcastDaftar> createState() => _BroadcastDaftarState();
}

class _BroadcastDaftarState extends State<BroadcastDaftar> {
  int currentPage = 1;
  final int itemsPerPage = 3;
  String? _filterQuery;
  String? _filterKategori;

  final List<Map<String, String>> data = [
    {
      'no': '1',
      'pengirim': 'Admin Jawara',
      'judul': 'Pengumuman',
      'tanggal': '21 Oktober 2025',
    },
    {
      'no': '2',
      'pengirim': 'Admin Jawara',
      'judul': 'DJ BAWS',
      'tanggal': '17 Oktober 2025',
    },
    {
      'no': '3',
      'pengirim': 'Admin Jawara',
      'judul': 'Gotong Royong',
      'tanggal': '14 Oktober 2025',
    },
  ];

  List<Map<String, String>> get displayedData {
    final q = _filterQuery?.toLowerCase();
    final k = _filterKategori;
    return data.where((item) {
      final matchesQuery = q == null || q.isEmpty
          ? true
          : item.values.any((v) => v.toLowerCase().contains(q));
      final matchesKategori = k == null || k == 'Semua'
          ? true
          : (item['kategori']?.toLowerCase() == k.toLowerCase());
      return matchesQuery && matchesKategori;
    }).toList();
  }

  Future<void> _openFilterDialog() async {
    final result = await showDialog<Map<String, String?>>(
      context: context,
      builder: (_) => const FilterDialog(),
    );
    if (result != null) {
      setState(() {
        _filterQuery = result['query'];
        _filterKategori = result['kategori'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    final bool isMobile = screenWidth < 600;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FB),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              // Header + Filter button
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6557FF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.all(12),
                    ),
                    onPressed: () => _openFilterDialog(),
                    child: const Icon(
                      Icons.filter_list,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              Expanded(
                child: isMobile
                    ? ListView.separated(
                        itemCount: displayedData.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 8),
                        padding: EdgeInsets.only(
                          bottom:
                              MediaQuery.of(context).viewPadding.bottom + 16,
                        ),
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final item = displayedData[index];
                          return Card(
                            elevation: 1,
                            margin: const EdgeInsets.symmetric(vertical: 4),
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item['judul']!,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.account_circle,
                                        size: 16,
                                        color: Colors.grey,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        item['pengirim']!,
                                        style: TextStyle(
                                          color: Colors.grey[600],
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.calendar_today,
                                        size: 16,
                                        color: Colors.grey,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        item['tanggal']!,
                                        style: TextStyle(
                                          color: Colors.grey[600],
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
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
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.1),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            // Table header
                            Container(
                              color: const Color(0xFFF9FAFB),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 32,
                                vertical: 12,
                              ),
                              child: const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      "NO",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      "PENGIRIM",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      "JUDUL",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      "TANGGAL",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      "AKSI",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // Table rows
                            Expanded(
                              child: ListView.separated(
                                itemCount: displayedData.length,
                                separatorBuilder: (context, index) =>
                                    const Divider(
                                      height: 1,
                                      color: Color(0xFFE5E7EB),
                                    ),
                                itemBuilder: (context, index) {
                                  final item = displayedData[index];
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 32,
                                      vertical: 12,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(child: Text(item['no']!)),
                                        Expanded(
                                          child: Text(item['pengirim']!),
                                        ),
                                        Expanded(child: Text(item['judul']!)),
                                        Expanded(child: Text(item['tanggal']!)),
                                        Expanded(
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: IconButton(
                                              onPressed: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        DetailPage(item: item),
                                                  ),
                                                );
                                              },
                                              icon: const Icon(
                                                Icons.more_horiz,
                                                color: Colors.black87,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
              ),

              // Pagination
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.chevron_left, color: Colors.grey),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF6557FF),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      child: const Text(
                        "1",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.chevron_right, color: Colors.grey),
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
}
