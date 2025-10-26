import 'package:flutter/material.dart';

class TagihanScreen extends StatefulWidget {
  const TagihanScreen({super.key});

  @override
  State<TagihanScreen> createState() => _TagihanScreenState();
}

class _TagihanScreenState extends State<TagihanScreen> {
  final List<Map<String, dynamic>> allData = [
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
      'status': 'Sudah Dibayar',
    },
    {
      'no': 3,
      'nama': 'Keluarga Budi Santoso',
      'statusKeluarga': 'Nonaktif',
      'iuran': 'Harian',
      'kodeTagihan': 'TG003',
      'nominal': 'Rp 100.000',
      'periode': 'Februari 2025',
      'status': 'Belum Dibayar',
    },
  ];

  List<Map<String, dynamic>> filteredData = [];
  String? selectedStatusPembayaran;
  String? selectedStatusKeluarga;
  String? selectedIuran;
  String? searchNama;
  DateTime? selectedDate;

  @override
  void initState() {
    super.initState();
    filteredData = List.from(allData);
  }

  void _showFilterDialog() {
    final TextEditingController namaController = TextEditingController(
      text: searchNama,
    );

    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Filter Tagihan',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),

                  // Status Pembayaran
                  const Text('Status Pembayaran'),
                  const SizedBox(height: 6),
                  DropdownButtonFormField<String>(
                    value: selectedStatusPembayaran,
                    decoration: _inputDecoration(),
                    items: const [
                      DropdownMenuItem(
                        value: 'Sudah Dibayar',
                        child: Text('Sudah Dibayar'),
                      ),
                      DropdownMenuItem(
                        value: 'Belum Dibayar',
                        child: Text('Belum Dibayar'),
                      ),
                    ],
                    onChanged: (val) =>
                        setState(() => selectedStatusPembayaran = val),
                  ),
                  const SizedBox(height: 12),

                  // Status Keluarga
                  const Text('Status Keluarga'),
                  const SizedBox(height: 6),
                  DropdownButtonFormField<String>(
                    value: selectedStatusKeluarga,
                    decoration: _inputDecoration(),
                    items: const [
                      DropdownMenuItem(value: 'Aktif', child: Text('Aktif')),
                      DropdownMenuItem(
                        value: 'Nonaktif',
                        child: Text('Nonaktif'),
                      ),
                    ],
                    onChanged: (val) =>
                        setState(() => selectedStatusKeluarga = val),
                  ),
                  const SizedBox(height: 12),

                  // Nama Keluarga
                  const Text('Keluarga'),
                  const SizedBox(height: 6),
                  TextField(
                    controller: namaController,
                    decoration: _inputDecoration().copyWith(
                      hintText: 'Masukkan nama keluarga',
                    ),
                    onChanged: (val) => searchNama = val,
                  ),
                  const SizedBox(height: 12),

                  // Iuran
                  const Text('Iuran'),
                  const SizedBox(height: 6),
                  DropdownButtonFormField<String>(
                    value: selectedIuran,
                    decoration: _inputDecoration(),
                    items: const [
                      DropdownMenuItem(
                        value: 'Bulanan',
                        child: Text('Bulanan'),
                      ),
                      DropdownMenuItem(value: 'Harian', child: Text('Harian')),
                    ],
                    onChanged: (val) => setState(() => selectedIuran = val),
                  ),
                  const SizedBox(height: 12),

                  // Periode (Date picker)
                  const Text('Periode'),
                  const SizedBox(height: 6),
                  TextFormField(
                    readOnly: true,
                    decoration: _inputDecoration().copyWith(
                      hintText: selectedDate == null
                          ? 'Pilih tanggal'
                          : '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}',
                      suffixIcon: const Icon(Icons.calendar_today),
                    ),
                    onTap: () async {
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: selectedDate ?? DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                      );
                      if (picked != null) {
                        setState(() => selectedDate = picked);
                      }
                    },
                  ),
                  const SizedBox(height: 20),

                  // Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          setState(() {
                            selectedStatusPembayaran = null;
                            selectedStatusKeluarga = null;
                            selectedIuran = null;
                            searchNama = null;
                            selectedDate = null;
                            filteredData = List.from(allData);
                          });
                          Navigator.pop(context);
                        },
                        child: const Text('Reset'),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: () {
                          _applyFilter();
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF3E6FAA),
                        ),
                        child: const Text(
                          'Terapkan',
                          style: TextStyle(color: Colors.white),
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
  }

  void _applyFilter() {
    setState(() {
      filteredData = allData.where((item) {
        bool match = true;

        if (selectedStatusPembayaran != null &&
            item['status'] != selectedStatusPembayaran)
          match = false;

        if (selectedStatusKeluarga != null &&
            item['statusKeluarga'] != selectedStatusKeluarga)
          match = false;

        if (selectedIuran != null && item['iuran'] != selectedIuran)
          match = false;

        if (searchNama != null &&
            searchNama!.isNotEmpty &&
            !item['nama'].toLowerCase().contains(searchNama!.toLowerCase()))
          match = false;

        if (selectedDate != null &&
            !item['periode'].contains(
              '${_monthName(selectedDate!.month)} ${selectedDate!.year}',
            ))
          match = false;

        return match;
      }).toList();
    });
  }

  String _monthName(int month) {
    const months = [
      'Januari',
      'Februari',
      'Maret',
      'April',
      'Mei',
      'Juni',
      'Juli',
      'Agustus',
      'September',
      'Oktober',
      'November',
      'Desember',
    ];
    return months[month - 1];
  }

  InputDecoration _inputDecoration() {
    return InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    );
  }

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
        color: text == 'Sudah Dibayar' ? Colors.green[100] : Colors.yellow[100],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: text == 'Sudah Dibayar' ? Colors.green : Colors.orange,
          fontWeight: FontWeight.w600,
          fontSize: 12,
          fontFamily: 'Poppins',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
                  onPressed: _showFilterDialog,
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
                        DataColumn(label: Text('No')),
                        DataColumn(label: Text('Nama Keluarga')),
                        DataColumn(label: Text('Status Keluarga')),
                        DataColumn(label: Text('Iuran')),
                        DataColumn(label: Text('Kode Tagihan')),
                        DataColumn(label: Text('Nominal')),
                        DataColumn(label: Text('Periode')),
                        DataColumn(label: Text('Status')),
                        DataColumn(label: Text('Aksi')),
                      ],
                      rows: filteredData.map((item) {
                        return DataRow(
                          cells: [
                            DataCell(Text(item['no'].toString())),
                            DataCell(Text(item['nama'])),
                            DataCell(
                              statusKeluargaPill(item['statusKeluarga']),
                            ),
                            DataCell(Text(item['iuran'])),
                            DataCell(Text(item['kodeTagihan'])),
                            DataCell(Text(item['nominal'])),
                            DataCell(Text(item['periode'])),
                            DataCell(statusPill(item['status'])),
                            DataCell(
                              IconButton(
                                icon: const Icon(Icons.more_horiz),
                                onPressed: () {},
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
