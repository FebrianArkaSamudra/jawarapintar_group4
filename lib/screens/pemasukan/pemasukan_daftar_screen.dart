import 'package:flutter/material.dart';

class PemasukanDaftarScreen extends StatefulWidget {
  const PemasukanDaftarScreen({super.key});

  @override
  State<PemasukanDaftarScreen> createState() => _PemasukanDaftarScreenState();
}

class _PemasukanDaftarScreenState extends State<PemasukanDaftarScreen> {
  // Filter controllers and variables
  final TextEditingController _namaFilterController = TextEditingController();
  final TextEditingController _dariTanggalController = TextEditingController();
  final TextEditingController _sampaiTanggalController =
      TextEditingController();
  String? _selectedKategoriFilter;
  DateTime? _dariTanggal;
  DateTime? _sampaiTanggal;

  final List<String> _kategoriList = [
    'Gaji',
    'Bonus',
    'Hadiah',
    'Lainnya',
    'Dana Bantuan Pemerintah',
    'Pendapatan Lainnya',
  ];

  final List<Map<String, String>> _allRows = [
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
    {
      'no': '4',
      'nama': 'sumbangan warga',
      'jenis': 'Dana Bantuan Pemerintah',
      'tanggal': '10 Agustus 2025',
      'nominal': 'Rp5.000,00',
    },
  ];

  List<Map<String, String>> _filteredRows = [];

  @override
  void initState() {
    super.initState();
    _filteredRows = List.from(_allRows);
  }

  @override
  void dispose() {
    _namaFilterController.dispose();
    _dariTanggalController.dispose();
    _sampaiTanggalController.dispose();
    super.dispose();
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Container(
                width: 600,
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Filter Pemasukan Non Iuran',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () => Navigator.pop(context),
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    // Nama field
                    const Text(
                      'Nama',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _namaFilterController,
                      decoration: InputDecoration(
                        hintText: 'Cari nama...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            color: Color(0xFF3E6FAA),
                            width: 2,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            color: Color(0xFF3E6FAA),
                            width: 2,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            color: Color(0xFF3E6FAA),
                            width: 2,
                          ),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Kategori field
                    const Text(
                      'Kategori',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    DropdownButtonFormField<String>(
                      value: _selectedKategoriFilter,
                      decoration: InputDecoration(
                        hintText: '-- Pilih Kategori --',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                      ),
                      items: _kategoriList
                          .map(
                            (kategori) => DropdownMenuItem(
                              value: kategori,
                              child: Text(kategori),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        setDialogState(() {
                          _selectedKategoriFilter = value;
                        });
                      },
                    ),
                    const SizedBox(height: 20),
                    // Dari Tanggal field
                    const Text(
                      'Dari Tanggal',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _dariTanggalController,
                      readOnly: true,
                      decoration: InputDecoration(
                        hintText: '--/--/----',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        suffixIcon: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (_dariTanggalController.text.isNotEmpty)
                              IconButton(
                                icon: const Icon(Icons.clear, size: 20),
                                onPressed: () {
                                  setDialogState(() {
                                    _dariTanggal = null;
                                    _dariTanggalController.clear();
                                  });
                                },
                              ),
                            IconButton(
                              icon: const Icon(Icons.calendar_today, size: 20),
                              onPressed: () async {
                                final DateTime? picked = await showDatePicker(
                                  context: context,
                                  initialDate: _dariTanggal ?? DateTime.now(),
                                  firstDate: DateTime(2020),
                                  lastDate: DateTime(2030),
                                );
                                if (picked != null) {
                                  setDialogState(() {
                                    _dariTanggal = picked;
                                    _dariTanggalController.text =
                                        "${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}";
                                  });
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Sampai Tanggal field
                    const Text(
                      'Sampai Tanggal',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _sampaiTanggalController,
                      readOnly: true,
                      decoration: InputDecoration(
                        hintText: '--/--/----',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        suffixIcon: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (_sampaiTanggalController.text.isNotEmpty)
                              IconButton(
                                icon: const Icon(Icons.clear, size: 20),
                                onPressed: () {
                                  setDialogState(() {
                                    _sampaiTanggal = null;
                                    _sampaiTanggalController.clear();
                                  });
                                },
                              ),
                            IconButton(
                              icon: const Icon(Icons.calendar_today, size: 20),
                              onPressed: () async {
                                final DateTime? picked = await showDatePicker(
                                  context: context,
                                  initialDate: _sampaiTanggal ?? DateTime.now(),
                                  firstDate: DateTime(2020),
                                  lastDate: DateTime(2030),
                                );
                                if (picked != null) {
                                  setDialogState(() {
                                    _sampaiTanggal = picked;
                                    _sampaiTanggalController.text =
                                        "${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}";
                                  });
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () {
                            setDialogState(() {
                              _namaFilterController.clear();
                              _selectedKategoriFilter = null;
                              _dariTanggal = null;
                              _sampaiTanggal = null;
                              _dariTanggalController.clear();
                              _sampaiTanggalController.clear();
                            });
                          },
                          child: const Text(
                            'Reset Filter',
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            _applyFilter();
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF5B7FBD),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 32,
                              vertical: 12,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text(
                            'Terapkan',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _applyFilter() {
    setState(() {
      _filteredRows = _allRows.where((row) {
        // Filter by name
        if (_namaFilterController.text.isNotEmpty) {
          if (!row['nama']!.toLowerCase().contains(
            _namaFilterController.text.toLowerCase(),
          )) {
            return false;
          }
        }

        // Filter by category
        if (_selectedKategoriFilter != null &&
            _selectedKategoriFilter!.isNotEmpty) {
          if (row['jenis'] != _selectedKategoriFilter) {
            return false;
          }
        }

        // Filter by date range
        if (_dariTanggal != null || _sampaiTanggal != null) {
          // Parse the date string (format: "15 Oktober 2025")
          final dateStr = row['tanggal']!;
          final parts = dateStr.split(' ');
          if (parts.length == 3) {
            final day = int.tryParse(parts[0]);
            final monthName = parts[1];
            final year = int.tryParse(parts[2]);

            final monthMap = {
              'Januari': 1,
              'Februari': 2,
              'Maret': 3,
              'April': 4,
              'Mei': 5,
              'Juni': 6,
              'Juli': 7,
              'Agustus': 8,
              'September': 9,
              'Oktober': 10,
              'November': 11,
              'Desember': 12,
            };

            final month = monthMap[monthName];

            if (day != null && month != null && year != null) {
              final rowDate = DateTime(year, month, day);

              if (_dariTanggal != null && rowDate.isBefore(_dariTanggal!)) {
                return false;
              }

              if (_sampaiTanggal != null && rowDate.isAfter(_sampaiTanggal!)) {
                return false;
              }
            }
          }
        }

        return true;
      }).toList();
    });
  }

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
                  onPressed: _showFilterDialog,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF3E6FAA),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    elevation: 0,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(Icons.filter_list, size: 20, color: Colors.white),
                      SizedBox(width: 6),
                      Text(
                        'Filter',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
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
                      rows: List<DataRow>.generate(_filteredRows.length, (
                        index,
                      ) {
                        final row = _filteredRows[index];
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
                      backgroundColor: const Color(0xFF3E6FAA),
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
