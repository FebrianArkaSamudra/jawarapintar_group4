import 'package:flutter/material.dart';

class PemasukanDaftarScreen extends StatefulWidget {
  const PemasukanDaftarScreen({super.key});

  @override
  State<PemasukanDaftarScreen> createState() => _PemasukanDaftarScreenState();
}

class _PemasukanDaftarScreenState extends State<PemasukanDaftarScreen> {
  final List<Map<String, String>> rows = [
    {
      'no': '1',
      'nama': 'aaaaa',
      'jenis': 'Dana Bantuan Pemerintah',
      'tanggal': '15 Oktober 2025',
      'nominal': 'Rp11,00',
    },
    {
      'no': '2',
      'nama': 'Joki by firman',
      'jenis': 'Pendapatan Lainnya',
      'tanggal': '13 Oktober 2025',
      'nominal': 'Rp49.999.997,00',
    },
    {
      'no': '3',
      'nama': 'tes',
      'jenis': 'Pendapatan Lainnya',
      'tanggal': '12 Agustus 2025',
      'nominal': 'Rp10.000,00',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final headerTextStyle = const TextStyle(
      fontWeight: FontWeight.w500,
      color: Colors.black87,
      fontSize: 14,
    );

    final cellTextStyle = const TextStyle(
      fontWeight: FontWeight.w400,
      color: Colors.black87,
      fontSize: 13,
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Pemasukan Lain - Daftar')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [
              BoxShadow(
                color: Color(0x1A000000),
                blurRadius: 8,
                offset: Offset(0, 4),
              ),
            ],
          ),
          padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6A3AB7),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    padding: const EdgeInsets.all(8),
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    elevation: 0,
                  ),
                  child: const Icon(
                    Icons.filter_list,
                    size: 20,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minWidth: MediaQuery.of(context).size.width - 64,
                    ),
                    child: DataTable(
                      headingRowHeight: 44,
                      dataRowHeight: 48,
                      horizontalMargin: 16,
                      columnSpacing: 24,
                      headingTextStyle: headerTextStyle,
                      dividerThickness: 1,
                      headingRowColor: MaterialStateProperty.all(
                        const Color(0xFFF8F9FB),
                      ),
                      dataRowColor: MaterialStateProperty.resolveWith<Color?>((
                        Set<MaterialState> states,
                      ) {
                        if (states.contains(MaterialState.selected)) {
                          return Colors.blue.withOpacity(0.1);
                        }
                        return null;
                      }),
                      columns: const [
                        DataColumn(label: Text('NO')),
                        DataColumn(label: Text('NAMA')),
                        DataColumn(label: Text('JENIS PEMASUKAN')),
                        DataColumn(label: Text('TANGGAL')),
                        DataColumn(label: Text('NOMINAL')),
                        DataColumn(label: Text('AKSI')),
                      ],
                      rows: List<DataRow>.generate(rows.length, (index) {
                        final row = rows[index];
                        final isEven = index % 2 == 0;
                        return DataRow(
                          color: MaterialStateProperty.all(
                            isEven ? Colors.white : const Color(0xFFF7F7F7),
                          ),
                          cells: [
                            DataCell(Text(row['no']!, style: cellTextStyle)),
                            DataCell(Text(row['nama']!, style: cellTextStyle)),
                            DataCell(Text(row['jenis']!, style: cellTextStyle)),
                            DataCell(
                              Text(row['tanggal']!, style: cellTextStyle),
                            ),
                            DataCell(
                              Text(row['nominal']!, style: cellTextStyle),
                            ),
                            DataCell(
                              IconButton(
                                icon: const Icon(Icons.more_horiz),
                                onPressed: () {},
                                color: Colors.black54,
                                splashRadius: 20,
                                padding: EdgeInsets.zero,
                                constraints: const BoxConstraints(),
                              ),
                            ),
                          ],
                        );
                      }),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: null,
                    icon: const Icon(Icons.arrow_left),
                    color: Colors.grey,
                    splashRadius: 20,
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6A3AB7),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      elevation: 0,
                      minimumSize: const Size(40, 32),
                    ),
                    child: const Text(
                      '1',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    onPressed: null,
                    icon: const Icon(Icons.arrow_right),
                    color: Colors.grey,
                    splashRadius: 20,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
