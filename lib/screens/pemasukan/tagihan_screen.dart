import 'package:flutter/material.dart';

class TagihanScreen extends StatelessWidget {
  const TagihanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> data = [
      {
        'no': 1,
        'nama': 'Keluarga Habibie Ed Dien',
        'statusKeluarga': 'Aktif',
        'iuran': 'Bulanan',
        'kodeTagihan': 'TG001',
        'nominal': 'Rp 150.000',
        'periode': 'Januari 2025',
        'status': 'Belum Dibayar',
      },
      {
        'no': 2,
        'nama': 'Keluarga Mara Nunez',
        'statusKeluarga': 'Aktif',
        'iuran': 'Bulanan',
        'kodeTagihan': 'TG002',
        'nominal': 'Rp 150.000',
        'periode': 'Januari 2025',
        'status': 'Belum Dibayar',
      },
      {
        'no': 3,
        'nama': 'Keluarga Budi Santoso',
        'statusKeluarga': 'Aktif',
        'iuran': 'Bulanan',
        'kodeTagihan': 'TG003',
        'nominal': 'Rp 150.000',
        'periode': 'Januari 2025',
        'status': 'Belum Dibayar',
      },
      {
        'no': 4,
        'nama': 'Keluarga Sari Dewi',
        'statusKeluarga': 'Aktif',
        'iuran': 'Bulanan',
        'kodeTagihan': 'TG004',
        'nominal': 'Rp 150.000',
        'periode': 'Januari 2025',
        'status': 'Belum Dibayar',
      },
      {
        'no': 5,
        'nama': 'Keluarga Agus Salim',
        'statusKeluarga': 'Aktif',
        'iuran': 'Bulanan',
        'kodeTagihan': 'TG005',
        'nominal': 'Rp 150.000',
        'periode': 'Januari 2025',
        'status': 'Belum Dibayar',
      },
      {
        'no': 6,
        'nama': 'Keluarga Lina Marlina',
        'statusKeluarga': 'Aktif',
        'iuran': 'Bulanan',
        'kodeTagihan': 'TG006',
        'nominal': 'Rp 150.000',
        'periode': 'Januari 2025',
        'status': 'Belum Dibayar',
      },
      {
        'no': 7,
        'nama': 'Keluarga Dedi Kusnadi',
        'statusKeluarga': 'Aktif',
        'iuran': 'Bulanan',
        'kodeTagihan': 'TG007',
        'nominal': 'Rp 150.000',
        'periode': 'Januari 2025',
        'status': 'Belum Dibayar',
      },
      {
        'no': 8,
        'nama': 'Keluarga Rina Wulandari',
        'statusKeluarga': 'Aktif',
        'iuran': 'Bulanan',
        'kodeTagihan': 'TG008',
        'nominal': 'Rp 150.000',
        'periode': 'Januari 2025',
        'status': 'Belum Dibayar',
      },
      {
        'no': 9,
        'nama': 'Keluarga Joko Widodo',
        'statusKeluarga': 'Aktif',
        'iuran': 'Bulanan',
        'kodeTagihan': 'TG009',
        'nominal': 'Rp 150.000',
        'periode': 'Januari 2025',
        'status': 'Belum Dibayar',
      },
      {
        'no': 10,
        'nama': 'Keluarga Siti Aminah',
        'statusKeluarga': 'Aktif',
        'iuran': 'Bulanan',
        'kodeTagihan': 'TG010',
        'nominal': 'Rp 150.000',
        'periode': 'Januari 2025',
        'status': 'Belum Dibayar',
      },
    ];

    Widget statusKeluargaPill(String text) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.green[100],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.green,
            fontWeight: FontWeight.w600,
            fontSize: 12,
            fontFamily: 'Poppins',
          ),
        ),
      );
    }

    Widget statusPill(String text) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.yellow[100],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.orange,
            fontWeight: FontWeight.w600,
            fontSize: 12,
            fontFamily: 'Poppins',
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FC),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.filter_list),
                  label: const Text(
                    'Filter',
                    style: TextStyle(fontFamily: 'Poppins'),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF3E6FAA),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.picture_as_pdf),
                  label: const Text(
                    'Cetak PDF',
                    style: TextStyle(fontFamily: 'Poppins'),
                  ),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF3E6FAA),
                    side: const BorderSide(color: Color(0xFF3E6FAA)),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const [
                    BoxShadow(color: Colors.black12, blurRadius: 4),
                  ],
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      columnSpacing: 20,
                      headingRowHeight: 48,
                      dataRowHeight: 56,
                      columns: const [
                        DataColumn(
                          label: Text(
                            'No',
                            style: TextStyle(fontFamily: 'Poppins'),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Nama Keluarga',
                            style: TextStyle(fontFamily: 'Poppins'),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Status Keluarga',
                            style: TextStyle(fontFamily: 'Poppins'),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Iuran',
                            style: TextStyle(fontFamily: 'Poppins'),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Kode Tagihan',
                            style: TextStyle(fontFamily: 'Poppins'),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Nominal',
                            style: TextStyle(fontFamily: 'Poppins'),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Periode',
                            style: TextStyle(fontFamily: 'Poppins'),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Status',
                            style: TextStyle(fontFamily: 'Poppins'),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Aksi',
                            style: TextStyle(fontFamily: 'Poppins'),
                          ),
                        ),
                      ],
                      rows: data.map((item) {
                        return DataRow(
                          cells: [
                            DataCell(
                              Text(
                                item['no'].toString(),
                                style: const TextStyle(fontFamily: 'Poppins'),
                              ),
                            ),
                            DataCell(
                              Text(
                                item['nama'],
                                style: const TextStyle(fontFamily: 'Poppins'),
                              ),
                            ),
                            DataCell(
                              statusKeluargaPill(item['statusKeluarga']),
                            ),
                            DataCell(
                              Text(
                                item['iuran'],
                                style: const TextStyle(fontFamily: 'Poppins'),
                              ),
                            ),
                            DataCell(
                              Text(
                                item['kodeTagihan'],
                                style: const TextStyle(fontFamily: 'Poppins'),
                              ),
                            ),
                            DataCell(
                              Text(
                                item['nominal'],
                                style: const TextStyle(fontFamily: 'Poppins'),
                              ),
                            ),
                            DataCell(
                              Text(
                                item['periode'],
                                style: const TextStyle(fontFamily: 'Poppins'),
                              ),
                            ),
                            DataCell(statusPill(item['status'])),
                            DataCell(
                              IconButton(
                                icon: const Icon(Icons.more_horiz),
                                onPressed: () {},
                                tooltip: 'Detail',
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
          ],
        ),
      ),
    );
  }
}
