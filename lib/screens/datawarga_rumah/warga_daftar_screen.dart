import 'package:flutter/material.dart';

class WargaDaftarScreen extends StatefulWidget {
  const WargaDaftarScreen({super.key});

  @override
  State<WargaDaftarScreen> createState() => _WargaDaftarScreenState();
}

// Colors
const _primaryColor = Color(0xFF673AB7);
const _backgroundColor = Color(0xFFF5F6FA);
const _headerTextStyle = TextStyle(
  fontWeight: FontWeight.w600,
  color: Colors.grey,
  fontSize: 12,
);
const _cellTextStyle = TextStyle(fontSize: 13, color: Colors.black87);

class _WargaDaftarScreenState extends State<WargaDaftarScreen> {
  // Sample data for demonstration, matching the image content
  final List<Map<String, dynamic>> _wargaData = [
    {
      'no': 1,
      'nama': 'syapri',
      'nik': '123456789134567',
      'keluarga': 'Keluarga Riris Naura',
      'jenis_kelamin': 'Perempuan',
      'status_domisili': 'Aktif',
      'status_hidup': 'Hidup',
    },
    {
      'no': 2,
      'nama': 'Stanley Naditha Ratna',
      'nik': '12377770730005',
      'keluarga': 'Keluarga Vitaliy Naditha Ratna',
      'jenis_kelamin': 'Laki-laki',
      'status_domisili': 'Aktif',
      'status_hidup': 'Hidup',
    },
    {
      'no': 3,
      'nama': 'Tes',
      'nik': '222222222222222',
      'keluarga': 'Keluarga Tes',
      'jenis_kelamin': 'Laki-laki',
      'status_domisili': 'Aktif',
      'status_hidup': 'Meninggal',
    },
    {
      'no': 4,
      'nama': 'Firman',
      'nik': '4567890234564356',
      'keluarga': 'Keluarga Firman',
      'jenis_kelamin': 'Laki-laki',
      'status_domisili': 'Aktif',
      'status_hidup': 'Hidup',
    },
    {
      'no': 5,
      'nama': 'Nardho Putra Anomadya',
      'nik': '3907511909010022',
      'keluarga': 'Keluarga Nardho Putra Anomadya',
      'jenis_kelamin': 'Laki-laki',
      'status_domisili': 'Aktif',
      'status_hidup': 'Hidup',
    },
    {
      'no': 6,
      'nama': 'Ardi Mirin',
      'nik': '1234567890987654',
      'keluarga': 'Keluarga Ardi Mirin',
      'jenis_kelamin': 'Laki-laki',
      'status_domisili': 'Aktif',
      'status_hidup': 'Hidup',
    },
    {
      'no': 7,
      'nama': 'Stanley naditha ritna',
      'nik': '1234123412341234',
      'keluarga': 'Keluarga vitaliy naditha ritna',
      'jenis_kelamin': 'Perempuan',
      'status_domisili': 'Aktif',
      'status_hidup': 'Hidup',
    },
    {
      'no': 8,
      'nama': 'Udinau',
      'nik': '1234567890123456',
      'keluarga': 'Keluarga jait',
      'jenis_kelamin': 'Perempuan',
      'status_domisili': 'Meninggal',
      'status_hidup': 'Hidup',
    },
    {
      'no': 9,
      'nama': 'Iqbal',
      'nik': '2023502050010235',
      'keluarga': 'Keluarga Iqbal',
      'jenis_kelamin': 'Laki-laki',
      'status_domisili': 'Meninggal',
      'status_hidup': 'Hidup',
    },
    {
      'no': 10,
      'nama': 'Rochdil Firman Nurdani',
      'nik': '3201190710150002',
      'keluarga': 'Keluarga Rochdil Firman Nurdani',
      'jenis_kelamin': 'Laki-laki',
      'status_domisili': 'Aktif',
      'status_hidup': 'Hidup',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            elevation: 3,
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Data Warga",
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 20,
                              color: Colors.black87,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.filter_alt_outlined,
                              color: Colors.grey,
                              size: 26,
                            ),
                            onPressed: () {
                              // TODO: Implement filter action
                            },
                            tooltip: "Filter",
                          ),
                        ],
                      ),
                    ),
                    const Divider(
                      height: 1,
                      thickness: 1,
                      color: Color(0xFFF0F0F0),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: _MinimalistDataTable(
                        data: _wargaData,
                        buildStatusChip: _buildStatusChip,
                      ),
                    ),
                    _buildPagination(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Minimalist status chip builder
  Widget _buildStatusChip(String status, {required String type}) {
    Color chipColor;
    Color textColor;
    if (type == 'domisili') {
      if (status == 'Aktif') {
        chipColor = const Color(0xFFE8F5E9);
        textColor = const Color(0xFF4CAF50);
      } else {
        chipColor = const Color(0xFFF2F2F2);
        textColor = const Color(0xFF9E9E9E);
      }
    } else {
      if (status == 'Hidup') {
        chipColor = const Color(0xFFE8F5E9);
        textColor = const Color(0xFF4CAF50);
      } else {
        chipColor = const Color(0xFFF2F2F2);
        textColor = const Color(0xFF9E9E9E);
      }
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: chipColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        status == 'Meninggal' ? 'Wafat' : status,
        style: TextStyle(
          color: textColor,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  // Pagination bar
  Widget _buildPagination() {
    return Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 8),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _PaginationIconButton(
              icon: Icons.chevron_left,
              onTap: () {},
              enabled: false,
            ),
            const SizedBox(width: 8),
            _PaginationPageButton(label: '1', selected: true, onTap: () {}),
            const SizedBox(width: 4),
            _PaginationPageButton(label: '2', selected: false, onTap: () {}),
            const SizedBox(width: 8),
            _PaginationIconButton(
              icon: Icons.chevron_right,
              onTap: () {},
              enabled: true,
            ),
          ],
        ),
      ),
    );
  }
}

// Minimalist DataTable with dividers and vertical padding
class _MinimalistDataTable extends StatelessWidget {
  final List<Map<String, dynamic>> data;
  final Widget Function(String, {required String type}) buildStatusChip;
  const _MinimalistDataTable({
    required this.data,
    required this.buildStatusChip,
  });

  @override
  Widget build(BuildContext context) {
    final columns = [
      'NO',
      'NAMA',
      'NIK',
      'KELUARGA',
      'JENIS KELAMIN',
      'STATUS DOMISILI',
      'STATUS HIDUP',
      'AKSI',
    ];
    return DataTableTheme(
      data: DataTableThemeData(
        headingRowColor: MaterialStateProperty.all(Colors.white),
        dataRowColor: MaterialStateProperty.all(Colors.white),
        dividerThickness: 0,
      ),
      child: DataTable(
        headingRowHeight: 44,
        dataRowMinHeight: 44,
        dataRowMaxHeight: 60,
        horizontalMargin: 16,
        columnSpacing: 20,
        columns: [
          DataColumn(label: Text('NO', style: _headerTextStyle)),
          DataColumn(label: Text('NAMA', style: _headerTextStyle)),
          DataColumn(label: Text('NIK', style: _headerTextStyle)),
          DataColumn(label: Text('KELUARGA', style: _headerTextStyle)),
          DataColumn(label: Text('JENIS KELAMIN', style: _headerTextStyle)),
          DataColumn(label: Text('STATUS DOMISILI', style: _headerTextStyle)),
          DataColumn(label: Text('STATUS HIDUP', style: _headerTextStyle)),
          DataColumn(label: Text('AKSI', style: _headerTextStyle)),
        ],
        rows: List.generate(data.length, (i) {
          final d = data[i];
          return DataRow(
            cells: [
              DataCell(
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(d['no'].toString(), style: _cellTextStyle),
                  ),
                ),
              ),
              DataCell(
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(d['nama'], style: _cellTextStyle),
                  ),
                ),
              ),
              DataCell(
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(d['nik'], style: _cellTextStyle),
                  ),
                ),
              ),
              DataCell(
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(d['keluarga'], style: _cellTextStyle),
                  ),
                ),
              ),
              DataCell(
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(d['jenis_kelamin'], style: _cellTextStyle),
                  ),
                ),
              ),
              DataCell(
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Align(
                    alignment: Alignment.center,
                    child: buildStatusChip(
                      d['status_domisili'],
                      type: 'domisili',
                    ),
                  ),
                ),
              ),
              DataCell(
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Align(
                    alignment: Alignment.center,
                    child: buildStatusChip(d['status_hidup'], type: 'hidup'),
                  ),
                ),
              ),
              DataCell(
                Center(
                  child: PopupMenuButton<String>(
                    tooltip: 'Opsi',
                    onSelected: (value) {
                      if (value == 'detail') {
                        // TODO: Navigate to detail
                      }
                    },
                    itemBuilder: (BuildContext context) =>
                        <PopupMenuEntry<String>>[
                          const PopupMenuItem<String>(
                            value: 'detail',
                            height: 30,
                            child: Text(
                              'Detail',
                              style: TextStyle(fontSize: 13),
                            ),
                          ),
                        ],
                    icon: const Icon(Icons.more_horiz, color: Colors.grey),
                  ),
                ),
              ),
            ],
            // Add divider below each row except last
            color: MaterialStateProperty.all(Colors.white),
          );
        }),
        // Remove default divider, we add custom one below
        showBottomBorder: false,
      ),
    );
  }
}

class _PaginationIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final bool enabled;
  const _PaginationIconButton({
    required this.icon,
    required this.onTap,
    this.enabled = true,
  });
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: enabled ? onTap : null,
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: enabled ? Colors.grey[100] : Colors.grey[50],
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: enabled ? Colors.grey : Colors.grey[300],
          size: 22,
        ),
      ),
    );
  }
}

class _PaginationPageButton extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;
  const _PaginationPageButton({
    required this.label,
    required this.selected,
    required this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: selected ? null : onTap,
      child: Container(
        width: 36,
        height: 36,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: selected
              ? _primaryColor.withOpacity(0.14)
              : Colors.transparent,
          shape: BoxShape.circle,
        ),
        child: Text(
          label,
          style: TextStyle(
            color: selected ? _primaryColor : Colors.grey,
            fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
            fontSize: 15,
          ),
        ),
      ),
    );
  }
}
