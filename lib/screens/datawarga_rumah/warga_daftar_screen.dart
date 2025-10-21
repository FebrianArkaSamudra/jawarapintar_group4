import 'package:flutter/material.dart';

class WargaDaftarScreen extends StatelessWidget {
  const WargaDaftarScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Data Warga",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      ElevatedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.filter_alt_outlined),
                        label: const Text("Filter"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
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
                      DataColumn(label: Text('NO')),
                      DataColumn(label: Text('NAMA')),
                      DataColumn(label: Text('NIK')),
                      DataColumn(label: Text('KELUARGA')),
                      DataColumn(label: Text('JENIS KELAMIN')),
                      DataColumn(label: Text('STATUS DOMISILI')),
                      DataColumn(label: Text('STATUS HIDUP')),
                      DataColumn(label: Text('AKSI')),
                    ],
                    rows: wargaData.map((data) {
                      return DataRow(cells: [
                        DataCell(Text(data['no']!)),
                        DataCell(Text(data['nama']!)),
                        DataCell(Text(data['nik']!)),
                        DataCell(Text(data['keluarga']!)),
                        DataCell(Text(data['jenisKelamin']!)),
                        DataCell(_buildStatusChip(data['statusDomisili']!)),
                        DataCell(_buildStatusChip(data['statusHidup']!)),
                        const DataCell(Icon(Icons.more_horiz, color: Colors.grey)),
                      ]);
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
      child: Text(status, style: TextStyle(color: textColor, fontWeight: FontWeight.w500)),
    );
  }

  Widget _buildPagination() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.chevron_left)),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(color: Colors.deepPurple, shape: BoxShape.circle),
            child: const Text('1', style: TextStyle(color: Colors.white)),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(color: Color(0xFFF0F0F0), shape: BoxShape.circle),
            child: const Text('2', style: TextStyle(color: Colors.black)),
          ),
          IconButton(onPressed: () {}, icon: const Icon(Icons.chevron_right)),
        ],
      ),
    );
  }
}
