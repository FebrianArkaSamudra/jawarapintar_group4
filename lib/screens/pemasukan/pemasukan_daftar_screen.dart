import 'package:flutter/material.dart';
import 'package:jawarapintar/screens/pemasukan/pemasukan_lain_detail_screen.dart';

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

  // Pagination (Slides)
  int _currentPage = 1;
  final int _itemsPerPage = 5;

  List<Map<String, String>> get _paginatedRows {
    final int startIndex = (_currentPage - 1) * _itemsPerPage;
    int endIndex = startIndex + _itemsPerPage;
    if (endIndex > _filteredRows.length) endIndex = _filteredRows.length;
    if (startIndex >= _filteredRows.length) return [];
    return _filteredRows.sublist(startIndex, endIndex);
  }

  int get _totalPages => (_filteredRows.isEmpty)
      ? 1
      : (_filteredRows.length / _itemsPerPage).ceil();

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
              insetPadding: const EdgeInsets.all(16),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: 600,
                  maxHeight: MediaQuery.of(context).size.height * 0.8,
                ),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Expanded(
                            child: Text(
                              'Filter Pemasukan Non Iuran',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
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
                                icon: const Icon(
                                  Icons.calendar_today,
                                  size: 20,
                                ),
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
                                icon: const Icon(
                                  Icons.calendar_today,
                                  size: 20,
                                ),
                                onPressed: () async {
                                  final DateTime? picked = await showDatePicker(
                                    context: context,
                                    initialDate:
                                        _sampaiTanggal ?? DateTime.now(),
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
      _currentPage = 1; // reset to first slide after filtering
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isMobile = constraints.maxWidth < 600;
        final double horizontalPadding = isMobile ? 8 : 16;
        final double verticalPadding = isMobile ? 12 : 24;
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
                  // Filter button
                  Align(
                    alignment: Alignment.topRight,
                    child: ElevatedButton.icon(
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
                  ),
                  SizedBox(height: isMobile ? 12 : 20),

                  // Table inside container
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
                                child: _buildDataTable(
                                  buttonFontSize: buttonFontSize,
                                ),
                              )
                            : _buildDataTable(),
                      ),
                    ),
                  ),
                  SizedBox(height: isMobile ? 12 : 20),
                  _buildPagination(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  DataTable _buildDataTable({double? buttonFontSize}) {
    final headerTextStyle = TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.black87,
      fontSize: buttonFontSize ?? 14,
    );

    final cellTextStyle = TextStyle(
      fontWeight: FontWeight.w400,
      color: Colors.black87,
      fontSize: buttonFontSize ?? 13,
    );

    return DataTable(
      headingTextStyle: headerTextStyle,
      dataTextStyle: cellTextStyle,
      columns: const [
        DataColumn(label: Text('No')),
        DataColumn(label: Text('Nama')),
        DataColumn(label: Text('Jenis Pemasukan')),
        DataColumn(label: Text('Tanggal')),
        DataColumn(label: Text('Nominal')),
        DataColumn(label: Text('Aksi')),
      ],
      rows: _paginatedRows.map((row) {
        return DataRow(
          cells: [
            DataCell(Text(row['no']!, style: cellTextStyle)),
            DataCell(Text(row['nama']!, style: cellTextStyle)),
            DataCell(Text(row['jenis']!, style: cellTextStyle)),
            DataCell(Text(row['tanggal']!, style: cellTextStyle)),
            DataCell(Text(row['nominal']!, style: cellTextStyle)),
            DataCell(
              PopupMenuButton<String>(
                icon: const Icon(Icons.more_horiz),
                onSelected: (value) {
                  if (value == 'detail') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => PemasukanLainDetailScreen(item: row),
                      ),
                    );
                  }
                },
                itemBuilder: (context) => const [
                  PopupMenuItem(value: 'detail', child: Text('Detail')),
                ],
              ),
            ),
          ],
        );
      }).toList(),
    );
  }

  Widget _buildPagination() {
    final bool isFirst = _currentPage <= 1;
    final bool isLast = _currentPage >= _totalPages;

    List<Widget> pageButtons = [];
    for (int i = 1; i <= _totalPages; i++) {
      final bool active = i == _currentPage;
      pageButtons.add(
        GestureDetector(
          onTap: () => setState(() => _currentPage = i),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 4),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: active ? const Color(0xFF3E6FAA) : const Color(0xFFF0F0F0),
              shape: BoxShape.circle,
            ),
            child: Text(
              '$i',
              style: TextStyle(
                color: active ? Colors.white : Colors.black87,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: isFirst
              ? null
              : () => setState(() => _currentPage = _currentPage - 1),
          icon: const Icon(Icons.chevron_left),
          color: isFirst ? Colors.grey : const Color(0xFF3E6FAA),
        ),
        ...pageButtons,
        IconButton(
          onPressed: isLast
              ? null
              : () => setState(() => _currentPage = _currentPage + 1),
          icon: const Icon(Icons.chevron_right),
          color: isLast ? Colors.grey : const Color(0xFF3E6FAA),
        ),
      ],
    );
  }
}
