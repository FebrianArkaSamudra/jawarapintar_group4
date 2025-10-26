import 'package:flutter/material.dart';

class WargaDaftarScreen extends StatefulWidget {
  const WargaDaftarScreen({super.key});

  @override
  State<WargaDaftarScreen> createState() => _WargaDaftarScreenState();
}

class _WargaDaftarScreenState extends State<WargaDaftarScreen> {
  int _currentPage = 1;

  final TextEditingController _namaController = TextEditingController();
  String? selectedGender;
  String? selectedStatus;
  String? selectedKeluarga;
  List<Map<String, String>> filteredData = [];

  final List<Map<String, String>> wargaData = [
    {
      "no": "1",
      "nama": "yyyyy",
      "nik": "1234567891234567",
      "keluarga": "Keluarga Mara Nunez",
      "jenisKelamin": "Perempuan",
      "statusDomisili": "Aktif",
      "statusHidup": "Hidup",
    },
    {
      "no": "2",
      "nama": "Varizky Naldiba Rimra",
      "nik": "137111011030005",
      "keluarga": "Keluarga Varizky Naldiba Rimra",
      "jenisKelamin": "Laki-laki",
      "statusDomisili": "Aktif",
      "statusHidup": "Hidup",
    },
    {
      "no": "3",
      "nama": "Tes",
      "nik": "2222222222222222",
      "keluarga": "Keluarga Tes",
      "jenisKelamin": "Laki-laki",
      "statusDomisili": "Aktif",
      "statusHidup": "Wafat",
    },
  ];

  @override
  void initState() {
    super.initState();
    filteredData = List.from(wargaData);
  }

  void applyFilter() {
    setState(() {
      filteredData = wargaData.where((item) {
        final matchesNama =
            _namaController.text.isEmpty ||
            item['nama']!.toLowerCase().contains(
              _namaController.text.toLowerCase(),
            );
        final matchesGender =
            selectedGender == null || item['jenisKelamin'] == selectedGender;
        final matchesStatus =
            selectedStatus == null ||
            item['statusDomisili'] == selectedStatus ||
            item['statusHidup'] == selectedStatus;
        final matchesKeluarga =
            selectedKeluarga == null || item['keluarga'] == selectedKeluarga;
        return matchesNama && matchesGender && matchesStatus && matchesKeluarga;
      }).toList();
    });
  }

  void resetFilter() {
    setState(() {
      _namaController.clear();
      selectedGender = null;
      selectedStatus = null;
      selectedKeluarga = null;
      filteredData = List.from(wargaData);
    });
  }

  // DETAIL DIALOG
  void _showWargaDetail(Map<String, String> warga) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          insetPadding: const EdgeInsets.all(16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: 1000,
              maxHeight: MediaQuery.of(context).size.height * 0.9,
            ),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Detail Warga',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  _detailRow('Nama Lengkap', warga['nama'] ?? '-'),
                  _detailRow('NIK', warga['nik'] ?? '-'),
                  _detailRow('Keluarga', warga['keluarga'] ?? '-'),
                  _detailRow('Jenis Kelamin', warga['jenisKelamin'] ?? '-'),
                  _detailRow('Status Domisili', warga['statusDomisili'] ?? '-'),
                  _detailRow('Status Hidup', warga['statusHidup'] ?? '-'),
                  const SizedBox(height: 12),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Tutup'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _detailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 220,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  // EDIT DIALOG
  void _showWargaEdit(int index) {
    final original = Map<String, String>.from(wargaData[index]);

    final namaCtrl = TextEditingController(text: original['nama'] ?? '');
    final nikCtrl = TextEditingController(text: original['nik'] ?? '');
    final keluargaCtrl = TextEditingController(
      text: original['keluarga'] ?? '',
    );
    String? jenisKelamin = original['jenisKelamin'];
    String? statusDomisili = original['statusDomisili'];
    String? statusHidup = original['statusHidup'];

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            final bottomInset = MediaQuery.of(context).viewInsets.bottom;
            return Dialog(
              insetPadding: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: 800,
                  maxHeight: MediaQuery.of(context).size.height * 0.9,
                ),
                child: SingleChildScrollView(
                  padding: EdgeInsets.fromLTRB(24, 24, 24, 24 + bottomInset),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Edit Warga',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text('Nama Lengkap'),
                      const SizedBox(height: 6),
                      TextField(
                        controller: namaCtrl,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 10,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text('NIK'),
                      const SizedBox(height: 6),
                      TextField(
                        controller: nikCtrl,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 10,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text('Keluarga'),
                      const SizedBox(height: 6),
                      TextField(
                        controller: keluargaCtrl,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 10,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text('Jenis Kelamin'),
                      const SizedBox(height: 6),
                      DropdownButtonFormField<String>(
                        value: jenisKelamin,
                        items: const [
                          DropdownMenuItem(
                            value: 'Laki-laki',
                            child: Text('Laki-laki'),
                          ),
                          DropdownMenuItem(
                            value: 'Perempuan',
                            child: Text('Perempuan'),
                          ),
                        ],
                        onChanged: (v) =>
                            setDialogState(() => jenisKelamin = v),
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 10,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text('Status Domisili'),
                      const SizedBox(height: 6),
                      DropdownButtonFormField<String>(
                        value: statusDomisili,
                        items: const [
                          DropdownMenuItem(
                            value: 'Aktif',
                            child: Text('Aktif'),
                          ),
                          DropdownMenuItem(
                            value: 'Nonaktif',
                            child: Text('Nonaktif'),
                          ),
                        ],
                        onChanged: (v) =>
                            setDialogState(() => statusDomisili = v),
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 10,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text('Status Hidup'),
                      const SizedBox(height: 6),
                      DropdownButtonFormField<String>(
                        value: statusHidup,
                        items: const [
                          DropdownMenuItem(
                            value: 'Hidup',
                            child: Text('Hidup'),
                          ),
                          DropdownMenuItem(
                            value: 'Wafat',
                            child: Text('Wafat'),
                          ),
                        ],
                        onChanged: (v) => setDialogState(() => statusHidup = v),
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 10,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('Batal'),
                          ),
                          const SizedBox(width: 8),
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                wargaData[index] = {
                                  'no': original['no'] ?? '${index + 1}',
                                  'nama': namaCtrl.text.trim(),
                                  'nik': nikCtrl.text.trim(),
                                  'keluarga': keluargaCtrl.text.trim(),
                                  'jenisKelamin':
                                      jenisKelamin ??
                                      original['jenisKelamin'] ??
                                      '-',
                                  'statusDomisili':
                                      statusDomisili ??
                                      original['statusDomisili'] ??
                                      '-',
                                  'statusHidup':
                                      statusHidup ??
                                      original['statusHidup'] ??
                                      '-',
                                };
                                applyFilter();
                              });
                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF3E6FAA),
                            ),
                            child: const Text(
                              'Simpan',
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
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: [
                // Header with title and filter button
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 16,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Data Warga",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              title: const Text(
                                'Filter Penerimaan Warga',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  TextField(
                                    controller: _namaController,
                                    decoration: InputDecoration(
                                      labelText: 'Nama',
                                      hintText: 'Cari nama...',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                            horizontal: 12,
                                          ),
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  DropdownButtonFormField<String>(
                                    decoration: InputDecoration(
                                      labelText: 'Jenis Kelamin',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    value: selectedGender,
                                    items: const [
                                      DropdownMenuItem(
                                        value: 'Laki-laki',
                                        child: Text('Laki-laki'),
                                      ),
                                      DropdownMenuItem(
                                        value: 'Perempuan',
                                        child: Text('Perempuan'),
                                      ),
                                    ],
                                    onChanged: (v) =>
                                        setState(() => selectedGender = v),
                                  ),
                                  const SizedBox(height: 12),
                                  DropdownButtonFormField<String>(
                                    decoration: InputDecoration(
                                      labelText: 'Status',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    value: selectedStatus,
                                    items: const [
                                      DropdownMenuItem(
                                        value: 'Aktif',
                                        child: Text('Aktif'),
                                      ),
                                      DropdownMenuItem(
                                        value: 'Nonaktif',
                                        child: Text('Nonaktif'),
                                      ),
                                      DropdownMenuItem(
                                        value: 'Hidup',
                                        child: Text('Hidup'),
                                      ),
                                      DropdownMenuItem(
                                        value: 'Wafat',
                                        child: Text('Wafat'),
                                      ),
                                    ],
                                    onChanged: (v) =>
                                        setState(() => selectedStatus = v),
                                  ),
                                  const SizedBox(height: 12),
                                  DropdownButtonFormField<String>(
                                    decoration: InputDecoration(
                                      labelText: 'Keluarga',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    value: selectedKeluarga,
                                    items: const [
                                      DropdownMenuItem(
                                        value: 'Keluarga Mara Nunez',
                                        child: Text('Keluarga Mara Nunez'),
                                      ),
                                      DropdownMenuItem(
                                        value: 'Keluarga Varizky Naldiba Rimra',
                                        child: Text(
                                          'Keluarga Varizky Naldiba Rimra',
                                        ),
                                      ),
                                      DropdownMenuItem(
                                        value: 'Keluarga Tes',
                                        child: Text('Keluarga Tes'),
                                      ),
                                    ],
                                    onChanged: (v) =>
                                        setState(() => selectedKeluarga = v),
                                  ),
                                ],
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    resetFilter();
                                    Navigator.pop(context);
                                  },
                                  child: const Text(
                                    'Reset Filter',
                                    style: TextStyle(
                                      color: Colors.black87,
                                      fontFamily: 'Poppins',
                                    ),
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    applyFilter();
                                    Navigator.pop(context);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF3E6FAA),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: const Text(
                                    'Terapkan',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF3E6FAA),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 10,
                          ),
                        ),
                        child: const Row(
                          children: [
                            Icon(
                              Icons.filter_list,
                              size: 20,
                              color: Colors.white,
                            ),
                            SizedBox(width: 6),
                            Text(
                              'Filter',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const Divider(height: 1, color: Color(0xFFF0F0F0)),

                // Table
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columns: const [
                      DataColumn(
                        label: Text(
                          'NO',
                          style: TextStyle(fontFamily: 'Poppins'),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'NAMA',
                          style: TextStyle(fontFamily: 'Poppins'),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'NIK',
                          style: TextStyle(fontFamily: 'Poppins'),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'KELUARGA',
                          style: TextStyle(fontFamily: 'Poppins'),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'JENIS KELAMIN',
                          style: TextStyle(fontFamily: 'Poppins'),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'STATUS DOMISILI',
                          style: TextStyle(fontFamily: 'Poppins'),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'STATUS HIDUP',
                          style: TextStyle(fontFamily: 'Poppins'),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'AKSI',
                          style: TextStyle(fontFamily: 'Poppins'),
                        ),
                      ),
                    ],
                    rows: filteredData.map((data) {
                      return DataRow(
                        cells: [
                          DataCell(
                            Text(
                              data['no']!,
                              style: const TextStyle(fontFamily: 'Poppins'),
                            ),
                          ),
                          DataCell(
                            Text(
                              data['nama']!,
                              style: const TextStyle(fontFamily: 'Poppins'),
                            ),
                          ),
                          DataCell(
                            Text(
                              data['nik']!,
                              style: const TextStyle(fontFamily: 'Poppins'),
                            ),
                          ),
                          DataCell(
                            Text(
                              data['keluarga']!,
                              style: const TextStyle(fontFamily: 'Poppins'),
                            ),
                          ),
                          DataCell(
                            Text(
                              data['jenisKelamin']!,
                              style: const TextStyle(fontFamily: 'Poppins'),
                            ),
                          ),
                          DataCell(_buildStatusChip(data['statusDomisili']!)),
                          DataCell(_buildStatusChip(data['statusHidup']!)),
                          DataCell(
                            PopupMenuButton<String>(
                              icon: const Icon(
                                Icons.more_horiz,
                                color: Colors.grey,
                              ),
                              itemBuilder: (context) => const [
                                PopupMenuItem(
                                  value: 'detail',
                                  child: Text('Detail'),
                                ),
                                PopupMenuItem(
                                  value: 'edit',
                                  child: Text('Edit'),
                                ),
                              ],
                              onSelected: (value) {
                                if (value == 'detail') {
                                  _showWargaDetail(data);
                                } else if (value == 'edit') {
                                  final idx = wargaData.indexWhere(
                                    (e) => e['no'] == data['no'],
                                  );
                                  if (idx != -1) {
                                    _showWargaEdit(idx);
                                  }
                                }
                              },
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                ),

                const SizedBox(height: 10),
                _buildPagination(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatusChip(String status) {
    Color bgColor;
    Color textColor = Colors.black87;

    switch (status) {
      case 'Aktif':
        bgColor = const Color(0xFFD6F5D6);
        textColor = Colors.green;
        break;
      case 'Nonaktif':
        bgColor = const Color(0xFFE6E6E6);
        textColor = Colors.black54;
        break;
      case 'Hidup':
        bgColor = const Color(0xFFD6F5D6);
        textColor = Colors.green;
        break;
      case 'Wafat':
        bgColor = const Color(0xFFE6E6E6);
        textColor = Colors.black54;
        break;
      default:
        bgColor = Colors.grey.shade200;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: textColor,
          fontWeight: FontWeight.w500,
          fontFamily: 'Poppins',
        ),
      ),
    );
  }

  Widget _buildPagination() {
    const int totalPages = 2; // example
    List<Widget> buttons = [];

    for (int i = 1; i <= totalPages; i++) {
      final isActive = i == _currentPage;
      buttons.add(
        GestureDetector(
          onTap: () => setState(() => _currentPage = i),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 4),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: isActive
                  ? const Color(0xFF3E6FAA)
                  : const Color(0xFFF0F0F0),
              shape: BoxShape.circle,
            ),
            child: Text(
              '$i',
              style: TextStyle(
                color: isActive ? Colors.white : Colors.black,
                fontFamily: 'Poppins',
              ),
            ),
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: _currentPage > 1
                ? () => setState(() => _currentPage--)
                : null,
            icon: const Icon(Icons.chevron_left),
          ),
          ...buttons,
          IconButton(
            onPressed: _currentPage < totalPages
                ? () => setState(() => _currentPage++)
                : null,
            icon: const Icon(Icons.chevron_right),
          ),
        ],
      ),
    );
  }
}
