import 'package:flutter/material.dart';

class WargaDaftarScreen extends StatefulWidget {
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
                        onPressed: () {},
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
                        child: Row(
                          children: const [
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
                    rows: wargaData.map((data) {
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
                          const DataCell(
                            Icon(Icons.more_horiz, color: Colors.grey),
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
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.chevron_left)),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
              color: Color(0xFF3E6FAA),
              shape: BoxShape.circle,
            ),
            child: const Text(
              '1',
              style: TextStyle(color: Colors.white, fontFamily: 'Poppins'),
            ),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
              color: Color(0xFFF0F0F0),
              shape: BoxShape.circle,
            ),
            child: const Text(
              '2',
              style: TextStyle(color: Colors.black, fontFamily: 'Poppins'),
            ),
          ),
          IconButton(onPressed: () {}, icon: const Icon(Icons.chevron_right)),
        ],
      ),
    );
  }
}
