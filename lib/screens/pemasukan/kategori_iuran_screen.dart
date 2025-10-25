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
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Expanded(
                        child: Text(
                          'Edit Iuran',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close, size: 20),
                        onPressed: () => Navigator.pop(context),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Ubah data iuran yang diperlukan.',
                    style: TextStyle(color: Colors.black54, fontSize: 13),
                  ),
                  const SizedBox(height: 16),

                  // Nama Iuran
                  const Text(
                    'Nama Iuran',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 13),
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
                    style: const TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 12),

                  // Jumlah
                  const Text(
                    'Jumlah',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 13),
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
                    style: const TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 12),

                  // Kategori Iuran
                  const Text(
                    'Kategori Iuran',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 13),
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
                    style: const TextStyle(fontSize: 14, color: Colors.black),
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
                      selectedJenis = value!;
                    },
                  ),
                  const SizedBox(height: 20),

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
                            horizontal: 16,
                            vertical: 10,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        child: const Text(
                          'Simpan',
                          style: TextStyle(color: Colors.white, fontSize: 14),
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

  void _confirmDelete(Map<String, dynamic> item) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Konfirmasi Hapus', style: TextStyle(fontSize: 16)),
        content: Text(
          'Yakin ingin menghapus iuran "${item['nama']}"?',
          style: const TextStyle(fontSize: 14),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                iuranList.remove(item);
              });
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Hapus', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Column(
        children: [
          // Info Box
          Container(
            width: double.infinity,
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFDDE9FF),
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.all(14),
            child: const Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: 'Info: ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: 'Iuran Bulanan: ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: 'Dibayar setiap bulan sekali secara rutin. '),
                  TextSpan(
                    text: 'Iuran Khusus: ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: 'Dibayar sesuai jadwal atau kebutuhan tertentu.',
                  ),
                ],
              ),
              style: TextStyle(color: Colors.black87, fontSize: 12),
            ),
          ),

          // Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: const [
                    Icon(Icons.category, color: Color(0xFF3E6FAA), size: 20),
                    SizedBox(width: 8),
                    Text(
                      "Kategori Iuran",
                      style: TextStyle(
                        fontSize: 16,
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
                      horizontal: 12,
                      vertical: 8,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  icon: const Icon(
                    Icons.filter_list,
                    color: Colors.white,
                    size: 18,
                  ),
                  label: const Text(
                    "Filter",
                    style: TextStyle(color: Colors.white, fontSize: 13),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Card List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: iuranList.length,
              itemBuilder: (context, index) {
                final item = iuranList[index];
                final isBulanan = item['jenis'] == 'Iuran Bulanan';

                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Header with name and actions
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item['nama'],
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: isBulanan
                                          ? Colors.blue.shade50
                                          : Colors.orange.shade50,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      item['jenis'],
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: isBulanan
                                            ? Colors.blue.shade700
                                            : Colors.orange.shade700,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                IconButton(
                                  icon: const Icon(
                                    Icons.edit,
                                    color: Color(0xFF3E6FAA),
                                    size: 20,
                                  ),
                                  tooltip: 'Edit',
                                  onPressed: () => _showEditDialog(item),
                                  padding: EdgeInsets.zero,
                                  constraints: const BoxConstraints(),
                                ),
                                const SizedBox(width: 12),
                                IconButton(
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                    size: 20,
                                  ),
                                  tooltip: 'Hapus',
                                  onPressed: () => _confirmDelete(item),
                                  padding: EdgeInsets.zero,
                                  constraints: const BoxConstraints(),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),

                        // Nominal
                        Row(
                          children: [
                            const Text(
                              'Nominal:',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              item['nominal'],
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: Color(0xFF3E6FAA),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
