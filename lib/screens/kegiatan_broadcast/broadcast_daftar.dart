import 'package:flutter/material.dart';

class BroadcastDaftar extends StatefulWidget {
  const BroadcastDaftar({super.key});

  @override
  State<BroadcastDaftar> createState() => _BroadcastDaftarState();
}

class _BroadcastDaftarState extends State<BroadcastDaftar> {
  int currentPage = 1;
  final int itemsPerPage = 3;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FB),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Container(
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
                // Header + Filter button
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF6557FF),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          padding: const EdgeInsets.all(12),
                        ),
                        onPressed: () {},
                        child: const Icon(Icons.filter_list,
                            color: Colors.white, size: 18),
                      ),
                    ],
                  ),
                ),

                // Table header
                Container(
                  color: const Color(0xFFF9FAFB),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(child: Text("NO", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12))),
                      Expanded(child: Text("PENGIRIM", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12))),
                      Expanded(child: Text("JUDUL", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12))),
                      Expanded(child: Text("TANGGAL", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12))),
                      Expanded(child: Text("AKSI", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12))),
                    ],
                  ),
                ),

                // Table rows
                Expanded(
                  child: ListView.separated(
                    itemCount: data.length,
                    separatorBuilder: (context, index) => const Divider(
                      height: 1,
                      color: Color(0xFFE5E7EB),
                    ),
                    itemBuilder: (context, index) {
                      final item = data[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 32, vertical: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(child: Text(item['no']!)),
                            Expanded(child: Text(item['pengirim']!)),
                            Expanded(child: Text(item['judul']!)),
                            Expanded(child: Text(item['tanggal']!)),
                            Expanded(
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.more_horiz,
                                      color: Colors.black87),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
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
                            horizontal: 16, vertical: 8),
                        child: const Text(
                          "1",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.chevron_right,
                            color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
