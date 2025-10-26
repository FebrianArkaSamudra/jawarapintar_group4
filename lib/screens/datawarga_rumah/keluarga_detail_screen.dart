import 'package:flutter/material.dart';

class KeluargaDetailScreen extends StatelessWidget {
  final Map<String, String> keluarga;

  const KeluargaDetailScreen({super.key, required this.keluarga});

  @override
  Widget build(BuildContext context) {
    final bool isActive = (keluarga['status'] ?? '').toLowerCase() == 'aktif';
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;
    final horizontalPadding = isMobile ? 12.0 : 24.0;
    final containerPadding = isMobile ? 16.0 : 20.0;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF5F7FA),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Kembali', style: TextStyle(color: Colors.black87)),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding,
          vertical: 16,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 8,
                offset: Offset(0, 2),
              ),
            ],
          ),
          padding: EdgeInsets.all(containerPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Detail Keluarga',
                style: TextStyle(
                  fontSize: isMobile ? 18 : 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),

              _infoRow('Nama Keluarga:', keluarga['nama'] ?? '-', isMobile),
              _infoRow('Kepala Keluarga:', keluarga['kepala'] ?? '-', isMobile),
              _infoRow('Rumah Saat Ini:', keluarga['alamat'] ?? '-', isMobile),
              _infoRow(
                'Status Kepemilikan:',
                keluarga['kepemilikan'] ?? '-',
                isMobile,
              ),
              isMobile
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(bottom: 6),
                          child: Text(
                            'Status Keluarga:',
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ),
                        _statusChip(
                          isActive ? 'Aktif' : (keluarga['status'] ?? '-'),
                        ),
                        const SizedBox(height: 10),
                      ],
                    )
                  : Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            width: 180,
                            child: Text(
                              'Status Keluarga:',
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ),
                          _statusChip(
                            isActive ? 'Aktif' : (keluarga['status'] ?? '-'),
                          ),
                        ],
                      ),
                    ),

              const SizedBox(height: 16),
              const Text(
                'Anggota Keluarga:',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),

              // Simple anggota card (head as example)
              _anggotaCard(
                nama: keluarga['kepala'] ?? '-',
                nik: '-',
                peran: 'Kepala Keluarga',
                jenisKelamin: '-',
                tanggalLahir: '-',
                status: keluarga['status'] ?? '-',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoRow(String label, String value, bool isMobile) {
    if (isMobile) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 4),
            Text(value),
          ],
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 180,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  Widget _statusChip(String status) {
    final bool isActive = status.toLowerCase() == 'aktif';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: isActive ? const Color(0xFFD6F5D6) : const Color(0xFFEDEDED),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: isActive ? Colors.green : Colors.black54,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _anggotaCard({
    required String nama,
    required String nik,
    required String peran,
    required String jenisKelamin,
    required String tanggalLahir,
    required String status,
  }) {
    final bool isActive = status.toLowerCase() == 'aktif';

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFF7F9FC),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFE6E8EB)),
      ),
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(nama, style: const TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 6),
          Text('NIK: $nik'),
          Text('Peran: $peran'),
          Text('Jenis Kelamin: $jenisKelamin'),
          Text('Tanggal Lahir: $tanggalLahir'),
          const SizedBox(height: 6),
          _statusChip(isActive ? 'Aktif' : status),
        ],
      ),
    );
  }
}
