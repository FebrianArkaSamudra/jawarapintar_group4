import 'package:flutter/material.dart';

class KategoriIuranScreen extends StatefulWidget {
  const KategoriIuranScreen({super.key});

  @override
  State<KategoriIuranScreen> createState() => _KategoriIuranScreenState();
}

class _KategoriIuranScreenState extends State<KategoriIuranScreen> {
  final List<Map<String, dynamic>> iuranList = [
    {'no': 1, 'nama': 'asad', 'jenis': 'Iuran Khusus', 'nominal': 'Rp3.000,00'},
    {'no': 2, 'nama': 'yyy', 'jenis': 'Iuran Bulanan', 'nominal': 'Rp5.000,00'},
    {'no': 3, 'nama': 'Harian', 'jenis': 'Iuran Khusus', 'nominal': 'Rp2,00'},
    {
      'no': 4,
      'nama': 'Kerja Bakti',
      'jenis': 'Iuran Khusus',
      'nominal': 'Rp5,00',
    },
    {
      'no': 5,
      'nama': 'Bersih Desa',
      'jenis': 'Iuran Khusus',
      'nominal': 'Rp200.000,00',
    },
    {
      'no': 6,
      'nama': 'Mingguan',
      'jenis': 'Iuran Khusus',
      'nominal': 'Rp12,00',
    },
    {
      'no': 7,
      'nama': 'Agustusan',
      'jenis': 'Iuran Khusus',
      'nominal': 'Rp15,00',
    },
    {
      'no': 8,
      'nama': 'Bulanan',
      'jenis': 'Iuran Khusus',
      'nominal': 'Rp20,000',
    },
  ];

  void _showEditDialog(Map<String, dynamic> item) {
    final TextEditingController namaController = TextEditingController(
      text: item['nama'],
    );
    final TextEditingController jumlahController = TextEditingController(
      text: item['nominal'].replaceAll(RegExp(r'[^0-9]'), ''),
    );
    String selectedJenis = item['jenis'];

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Edit Iuran',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                const Text(
                  'Ubah data iuran yang diperlukan.',
                  style: TextStyle(color: Colors.black54),
                ),
                const SizedBox(height: 20),

                // Nama Iuran
                const Text(
                  'Nama Iuran',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
                ),
                const SizedBox(height: 6),
                TextField(
                  controller: namaController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 10,
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Jumlah
                const Text(
                  'Jumlah',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
                ),
                const SizedBox(height: 6),
                TextField(
                  controller: jumlahController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 10,
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Kategori Iuran
                const Text(
                  'Kategori Iuran',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
                ),
                const SizedBox(height: 6),
                DropdownButtonFormField<String>(
                  value: selectedJenis,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 10,
                    ),
                  ),
                  items: const [
                    DropdownMenuItem(
                      value: 'Iuran Bulanan',
                      child: Text('Iuran Bulanan'),
                    ),
                    DropdownMenuItem(
                      value: 'Iuran Khusus',
                      child: Text('Iuran Khusus'),
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      selectedJenis = value!;
                    });
                  },
                ),
                const SizedBox(height: 24),

                // Buttons
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
                          item['nama'] = namaController.text;
                          item['jenis'] = selectedJenis;
                          item['nominal'] = "Rp${jumlahController.text},00";
                        });
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF3E6FAA),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
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
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Info Box
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFFDDE9FF),
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.all(16),
              child: const Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'Info: Iuran Bulanan: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text:
                          'Dibayar setiap bulan sekali secara rutin.\nIuran Khusus: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text:
                          'Dibayar sesuai jadwal atau kebutuhan tertentu, misalnya iuran untuk acara khusus, renovasi, atau kegiatan lain yang tidak rutin.',
                    ),
                  ],
                ),
                style: TextStyle(color: Colors.black87, fontSize: 14),
              ),
            ),
            const SizedBox(height: 20),

            // Header row with title + filter button
            Wrap(
              alignment: WrapAlignment.spaceBetween,
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 8,
              runSpacing: 8,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(Icons.category, color: Color(0xFF3E6FAA)),
                    SizedBox(width: 8),
                    Text(
                      "Kategori Iuran",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                ElevatedButton.icon(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF3E6FAA),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  icon: const Icon(Icons.filter_list, color: Colors.white),
                  label: const Text(
                    "Filter",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Table Content
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: DataTable(
                    columnSpacing: 40,
                    headingRowHeight: 56,
                    dataRowMinHeight: 48,
                    dataRowMaxHeight: 56,
                    columns: const [
                      DataColumn(
                        label: Text(
                          'No',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Nama Iuran',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Jenis Iuran',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Nominal',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Aksi',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                    rows: iuranList.map((item) {
                      return DataRow(
                        cells: [
                          DataCell(Text(item['no'].toString())),
                          DataCell(Text(item['nama'])),
                          DataCell(Text(item['jenis'])),
                          DataCell(Text(item['nominal'])),
                          DataCell(
                            Row(
                              children: [
                                IconButton(
                                  icon: const Icon(
                                    Icons.edit,
                                    color: Color(0xFF3E6FAA),
                                  ),
                                  tooltip: 'Edit',
                                  onPressed: () => _showEditDialog(item),
                                ),
                                IconButton(
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                  tooltip: 'Hapus',
                                  onPressed: () {
                                    setState(() {
                                      iuranList.remove(item);
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    }).toList(),
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
