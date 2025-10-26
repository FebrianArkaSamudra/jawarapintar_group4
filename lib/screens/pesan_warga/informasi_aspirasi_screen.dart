import 'package:flutter/material.dart';

// ===== MODEL =====
class _AspirasiItem {
  int no;
  String pengirim;
  String judul;
  String status;
  String tanggal;
  String deskripsi; // ✅ Tambahan kolom deskripsi

  _AspirasiItem({
    required this.no,
    required this.pengirim,
    required this.judul,
    required this.status,
    required this.tanggal,
    required this.deskripsi,
  });
}

// ===== MAIN SCREEN =====
class InformasiAspirasiScreen extends StatefulWidget {
  const InformasiAspirasiScreen({super.key});

  @override
  State<InformasiAspirasiScreen> createState() =>
      _InformasiAspirasiScreenState();
}

class _InformasiAspirasiScreenState extends State<InformasiAspirasiScreen> {
  final List<_AspirasiItem> _allItems = [
    _AspirasiItem(
      no: 1,
      pengirim: 'Slamet',
      judul: 'Uji Coba',
      status: 'Diterima',
      tanggal: '26 September 2025',
      deskripsi: 'Percobaan awal untuk sistem aspirasi warga.',
    ),
    _AspirasiItem(
      no: 2,
      pengirim: 'Murjoko',
      judul: 'Tes Jaringan',
      status: 'Pending',
      tanggal: '27 September 2025',
      deskripsi: 'Permintaan pengecekan jaringan di area kantor.',
    ),
    _AspirasiItem(
      no: 3,
      pengirim: 'Budianto',
      judul: 'Lampu Jalan Mati',
      status: 'Ditolak',
      tanggal: '28 September 2025',
      deskripsi: 'Lampu jalan di blok C padam selama 3 hari terakhir.',
    ),
    _AspirasiItem(
      no: 4,
      pengirim: 'Dewi Lestari',
      judul: 'Perbaikan Trotoar',
      status: 'Diterima',
      tanggal: '29 September 2025',
      deskripsi: 'Trotoar di depan sekolah dasar rusak dan perlu diperbaiki.',
    ),
    _AspirasiItem(
      no: 5,
      pengirim: 'Andi Saputra',
      judul: 'Penambahan Tempat Sampah',
      status: 'Pending',
      tanggal: '30 September 2025',
      deskripsi: 'Usulan penambahan tempat sampah di taman kota.',
    ),
    _AspirasiItem(
      no: 6,
      pengirim: 'Siti Nurhaliza',
      judul: 'Keamanan Lingkungan',
      status: 'Ditolak',
      tanggal: '1 Oktober 2025',
      deskripsi: 'Permintaan peningkatan patroli keamanan di malam hari.',
    ),
    _AspirasiItem(
      no: 7,
      pengirim: 'Rudi Hartono',
      judul: 'Perbaikan Saluran Air',
      status: 'Diterima',
      tanggal: '2 Oktober 2025',
      deskripsi: 'Saluran air di jalan utama sering tersumbat saat hujan.',
    ),
    _AspirasiItem(
      no: 8,
      pengirim: 'Lina Marlina',
      judul: 'Peningkatan Fasilitas Umum',
      status: 'Pending',
      tanggal: '3 Oktober 2025',
      deskripsi: 'Usulan penambahan fasilitas umum di area rekreasi.',
    ),
    _AspirasiItem(
      no: 9,
      pengirim: 'Agus Salim',
      judul: 'Perbaikan Jalan Rusak',
      status: 'Ditolak',
      tanggal: '4 Oktober 2025',
      deskripsi: 'Jalan di lingkungan perumahan banyak yang berlubang.',
    ),
    _AspirasiItem(
      no: 10,
      pengirim: 'Maya Sari',
      judul: 'Penghijauan Lingkungan',
      status: 'Diterima',
      tanggal: '5 Oktober 2025',
      deskripsi: 'Usulan penanaman pohon di sepanjang jalan utama.',
    ),
  ];

  List<_AspirasiItem> _filteredItems = [];
  _AspirasiItem? _selectedItem;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _filteredItems = List.from(_allItems);
  }

  // ===== BADGE STATUS =====
  Widget _buildStatusBadge(BuildContext context, String status) {
    Color color;
    Color textColor;
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;

    switch (status.toLowerCase()) {
      case 'diterima':
        color = const Color(0xFFE6F3EE);
        textColor = const Color(0xFF1E8449);
        break;
      case 'pending':
        color = const Color(0xFFFFFBEA);
        textColor = const Color(0xFFF39C12);
        break;
      case 'ditolak':
        color = const Color(0xFFFBEAEA);
        textColor = const Color(0xFFDC3545);
        break;
      default:
        color = const Color(0xFFE0E0E0);
        textColor = const Color(0xFF666666);
    }

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 6.0 : 8.0,
        vertical: 4.0,
      ),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color, width: 1.5),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.assignment_turned_in_outlined,
            color: textColor,
            size: isMobile ? 12 : 14,
          ),
          SizedBox(width: isMobile ? 4 : 6),
          Text(
            status,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.w600,
              fontSize: isMobile ? 11 : 13,
            ),
          ),
        ],
      ),
    );
  }

  // ===== FILTER MODAL =====
  void _showFilterModal(BuildContext context) {
    String? selectedStatus;
    final TextEditingController judulController = TextEditingController();
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;

    showDialog(
      context: context,
      builder: (dialogCtx) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          titlePadding: EdgeInsets.zero,
          contentPadding: EdgeInsets.all(isMobile ? 16 : 20),
          title: Padding(
            padding: EdgeInsets.all(isMobile ? 12 : 16).copyWith(bottom: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    'Filter Pesan Warga',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: isMobile ? 16 : 18,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () => Navigator.of(dialogCtx).pop(),
                  child: const Icon(Icons.close, size: 24),
                ),
              ],
            ),
          ),
          content: StatefulBuilder(
            builder: (context, setStateSB) {
              return SizedBox(
                width: isMobile ? double.maxFinite : 500,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 12),
                      const Text(
                        'Judul',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: judulController,
                        decoration: InputDecoration(
                          hintText: 'Cari judul...',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 12,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Status',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 8),
                      DropdownButtonFormField<String>(
                        value: selectedStatus,
                        hint: const Text('-- Pilih Status --'),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 12,
                          ),
                        ),
                        items: const ['Pending', 'Diterima', 'Ditolak']
                            .map(
                              (s) => DropdownMenuItem(value: s, child: Text(s)),
                            )
                            .toList(),
                        onChanged: (v) => setStateSB(() => selectedStatus = v),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () {
                                judulController.clear();
                                setStateSB(() => selectedStatus = null);
                                setState(
                                  () => _filteredItems = List.from(_allItems),
                                );
                              },
                              style: OutlinedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                ),
                              ),
                              child: const Text('Reset'),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.of(dialogCtx).pop();
                                setState(() {
                                  _filteredItems = _allItems.where((item) {
                                    final matchJudul =
                                        judulController.text.isEmpty ||
                                        item.judul.toLowerCase().contains(
                                          judulController.text.toLowerCase(),
                                        );
                                    final matchStatus =
                                        selectedStatus == null ||
                                        item.status == selectedStatus;
                                    return matchJudul && matchStatus;
                                  }).toList();
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                ),
                              ),
                              child: const Text('Terapkan'),
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
        );
      },
    );
  }

  // ===== ACTION MENU =====
  Widget _buildActionMenu(BuildContext context, _AspirasiItem item, int index) {
    return PopupMenuButton<String>(
      icon: const Icon(Icons.more_horiz, color: Color(0xFF999999)),
      offset: const Offset(0, 36),
      itemBuilder: (ctx) => [
        PopupMenuItem(
          value: 'Detail',
          child: const Row(
            children: [
              Icon(Icons.visibility_outlined, size: 18),
              SizedBox(width: 50),
              Text('Detail'),
            ],
          ),
          onTap: () => Future.delayed(Duration.zero, () {
            setState(() {
              _selectedItem = item;
              _isEditing = false;
            });
          }),
        ),
        PopupMenuItem(
          value: 'Edit',
          child: const Row(
            children: [
              Icon(Icons.edit_outlined, size: 18),
              SizedBox(width: 50),
              Text('Edit'),
            ],
          ),
          onTap: () => Future.delayed(Duration.zero, () {
            setState(() {
              _selectedItem = item;
              _isEditing = true;
            });
          }),
        ),
        PopupMenuItem(
          value: 'Hapus',
          child: const Row(
            children: [
              Icon(Icons.delete_outline_rounded, size: 18),
              SizedBox(width: 50),
              Text('Hapus'),
            ],
          ),
          onTap: () async {
            await Future.delayed(Duration.zero);
            final confirm = await showDialog<bool>(
              context: context,
              builder: (dctx) => AlertDialog(
                title: const Text('Hapus'),
                content: const Text('Yakin ingin menghapus item ini?'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(dctx, false),
                    child: const Text('Batal'),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(dctx, true),
                    child: const Text('Hapus'),
                  ),
                ],
              ),
            );
            if (confirm == true) {
              setState(() {
                _filteredItems.removeAt(index);
                _selectedItem = null;
              });
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text('Item dihapus')));
            }
          },
        ),
      ],
    );
  }

  // ===== DETAIL INLINE FOR MOBILE =====
  Widget _buildDetailSectionInline() {
    final item = _selectedItem!;
    return Column(
      children: [
        Row(
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => setState(() {
                _selectedItem = null;
                _isEditing = false;
              }),
            ),
            const Text(
              'Kembali ke Daftar',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Expanded(
          child: SingleChildScrollView(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFE0E0E0)),
              ),
              child: _isEditing ? _buildEditForm(item) : _buildDetailView(item),
            ),
          ),
        ),
      ],
    );
  }

  // ===== DETAIL / EDIT SECTION =====
  Widget _buildDetailSection() {
    if (_selectedItem == null) return const SizedBox();
    final item = _selectedItem!;
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;

    return Padding(
      padding: EdgeInsets.only(top: isMobile ? 12.0 : 16.0),
      child: Column(
        children: [
          const Divider(thickness: 1.5, height: 32),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(isMobile ? 12.0 : 16.0),
            decoration: BoxDecoration(
              color: const Color(0xFFF9F9F9),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFE0E0E0)),
            ),
            child: _isEditing ? _buildEditForm(item) : _buildDetailView(item),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailView(_AspirasiItem item) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Detail Informasi Aspirasi',
          style: TextStyle(
            fontSize: isMobile ? 14 : 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),
        _buildDetailRow('Pengirim', item.pengirim),
        _buildDetailRow('Judul', item.judul),
        _buildDetailRow('Status', item.status),
        _buildDetailRow('Tanggal', item.tanggal),
        _buildDetailRow('Deskripsi', item.deskripsi),
        SizedBox(height: isMobile ? 8 : 12),
        Align(
          alignment: isMobile ? Alignment.center : Alignment.centerRight,
          child: ElevatedButton.icon(
            onPressed: () => setState(() => _selectedItem = null),
            icon: const Icon(Icons.close, size: 18),
            label: const Text('Tutup'),
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 16 : 20,
                vertical: isMobile ? 10 : 12,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ===== FORM EDIT =====
  Widget _buildEditForm(_AspirasiItem item) {
    final TextEditingController judulController = TextEditingController(
      text: item.judul,
    );
    final TextEditingController deskripsiController = TextEditingController(
      text: item.deskripsi,
    );
    String? selectedStatus = item.status;
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Edit Informasi Aspirasi',
          style: TextStyle(
            fontSize: isMobile ? 14 : 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: judulController,
          decoration: InputDecoration(
            labelText: 'Judul Aspirasi',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 12,
            ),
          ),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: deskripsiController,
          maxLines: 3,
          decoration: InputDecoration(
            labelText: 'Deskripsi Aspirasi',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 12,
            ),
          ),
        ),
        const SizedBox(height: 12),
        DropdownButtonFormField<String>(
          value: selectedStatus,
          decoration: InputDecoration(
            labelText: 'Status Aspirasi',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 12,
            ),
          ),
          items: const [
            DropdownMenuItem(value: 'Pending', child: Text('Pending')),
            DropdownMenuItem(value: 'Diterima', child: Text('Diterima')),
            DropdownMenuItem(value: 'Ditolak', child: Text('Ditolak')),
          ],
          onChanged: (v) => selectedStatus = v,
        ),
        const SizedBox(height: 16),
        isMobile
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  OutlinedButton(
                    onPressed: () => setState(() {
                      _selectedItem = null;
                      _isEditing = false;
                    }),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: const Text('Batal'),
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton.icon(
                    onPressed: () {
                      setState(() {
                        item.judul = judulController.text;
                        item.deskripsi = deskripsiController.text;
                        item.status = selectedStatus ?? item.status;
                        _isEditing = false;
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Perubahan disimpan')),
                      );
                    },
                    icon: const Icon(Icons.save_outlined, size: 18),
                    label: const Text('Simpan'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ],
              )
            : Align(
                alignment: Alignment.centerRight,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    OutlinedButton(
                      onPressed: () => setState(() {
                        _selectedItem = null;
                        _isEditing = false;
                      }),
                      child: const Text('Batal'),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton.icon(
                      onPressed: () {
                        setState(() {
                          item.judul = judulController.text;
                          item.deskripsi = deskripsiController.text;
                          item.status = selectedStatus ?? item.status;
                          _isEditing = false;
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Perubahan disimpan')),
                        );
                      },
                      icon: const Icon(Icons.save_outlined, size: 18),
                      label: const Text('Simpan'),
                    ),
                  ],
                ),
              ),
      ],
    );
  }

  Widget _buildDetailRow(String label, String value) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;

    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: isMobile
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$label:',
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 4),
                Text(value, style: const TextStyle(fontSize: 13)),
              ],
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 130,
                  child: Text(
                    '$label:',
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
                Expanded(child: Text(value)),
              ],
            ),
    );
  }

  // ===== MAIN BUILD =====
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;

    return Padding(
      padding: EdgeInsets.all(isMobile ? 16.0 : 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              padding: EdgeInsets.all(isMobile ? 12.0 : 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (!isMobile)
                        const Text(
                          'Informasi Aspirasi Warga',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF333333),
                          ),
                        ),
                      OutlinedButton.icon(
                        onPressed: () => _showFilterModal(context),
                        icon: const Icon(Icons.filter_list, size: 18),
                        label: Text(isMobile ? 'Filter' : 'Filters'),
                        style: OutlinedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                            horizontal: isMobile ? 12 : 16,
                            vertical: isMobile ? 8 : 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: _selectedItem != null && isMobile
                        ? _buildDetailSectionInline()
                        : (isMobile
                              ? _buildMobileList()
                              : _buildDesktopTable()),
                  ),
                  if (!isMobile) _buildDetailSection(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ===== MOBILE CARD LIST =====
  Widget _buildMobileList() {
    if (_filteredItems.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.inbox_outlined, size: 64, color: Color(0xFFCCCCCC)),
            SizedBox(height: 16),
            Text(
              'Tidak ada data',
              style: TextStyle(fontSize: 16, color: Color(0xFF999999)),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 16),
      itemCount: _filteredItems.length,
      itemBuilder: (context, index) {
        final item = _filteredItems[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: const BorderSide(color: Color(0xFFE0E0E0), width: 0.5),
          ),
          child: InkWell(
            onTap: () {
              setState(() {
                _selectedItem = item;
                _isEditing = false;
              });
            },
            borderRadius: BorderRadius.circular(8),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF0F0F0),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          '#${item.no}',
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF666666),
                          ),
                        ),
                      ),
                      _buildActionMenu(context, item, index),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    item.judul,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF333333),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(
                        Icons.person_outline,
                        size: 14,
                        color: Color(0xFF999999),
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          item.pengirim,
                          style: const TextStyle(
                            fontSize: 13,
                            color: Color(0xFF666666),
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            const Icon(
                              Icons.calendar_today,
                              size: 14,
                              color: Color(0xFF999999),
                            ),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                item.tanggal,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Color(0xFF666666),
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      _buildStatusBadge(context, item.status),
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

  // ===== DESKTOP TABLE =====
  Widget _buildDesktopTable() {
    const headerStyle = TextStyle(
      fontWeight: FontWeight.w600,
      color: Color(0xFF666666),
      fontSize: 14,
    );
    const bodyStyle = TextStyle(color: Color(0xFF333333), fontSize: 14);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
          child: Row(
            children: const [
              SizedBox(width: 50, child: Text('No', style: headerStyle)),
              Expanded(flex: 2, child: Text('Pengirim', style: headerStyle)),
              Expanded(flex: 3, child: Text('Judul', style: headerStyle)),
              Expanded(
                flex: 2,
                child: Center(child: Text('Status', style: headerStyle)),
              ),
              Expanded(flex: 2, child: Text('Tanggal', style: headerStyle)),
              SizedBox(
                width: 50,
                child: Center(child: Text('Aksi', style: headerStyle)),
              ),
            ],
          ),
        ),
        const Divider(height: 1, thickness: 1, color: Color(0xFFE0E0E0)),
        const SizedBox(height: 6),
        Expanded(
          child: ListView.builder(
            itemCount: _filteredItems.length,
            itemBuilder: (context, index) {
              final it = _filteredItems[index];
              return _HoverableRow(
                data: it,
                bodyStyle: bodyStyle,
                buildStatusBadge: _buildStatusBadge,
                buildActionButton: _buildActionMenu,
                index: index,
              );
            },
          ),
        ),
      ],
    );
  }
}

// ===== HOVERABLE ROW =====
class _HoverableRow extends StatefulWidget {
  final _AspirasiItem data;
  final TextStyle bodyStyle;
  final Widget Function(BuildContext, String) buildStatusBadge;
  final Widget Function(BuildContext, _AspirasiItem, int) buildActionButton;
  final int index;

  const _HoverableRow({
    required this.data,
    required this.bodyStyle,
    required this.buildStatusBadge,
    required this.buildActionButton,
    required this.index,
  });

  @override
  State<_HoverableRow> createState() => _HoverableRowState();
}

class _HoverableRowState extends State<_HoverableRow> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final decoration = BoxDecoration(
      color: _hover ? const Color(0xFFF9F9F9) : Colors.white,
      boxShadow: _hover
          ? [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ]
          : null,
    );

    return Column(
      children: [
        MouseRegion(
          onEnter: (_) => setState(() => _hover = true),
          onExit: (_) => setState(() => _hover = false),
          cursor: SystemMouseCursors.click,
          child: Container(
            decoration: decoration,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 12.0,
                horizontal: 4.0,
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: 50,
                    child: Text('${widget.data.no}.', style: widget.bodyStyle),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      widget.data.pengirim,
                      style: widget.bodyStyle,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Text(
                      widget.data.judul,
                      style: widget.bodyStyle,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Center(
                      child: widget.buildStatusBadge(
                        context,
                        widget.data.status,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      widget.data.tanggal,
                      style: widget.bodyStyle,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(
                    width: 50,
                    child: Center(
                      child: widget.buildActionButton(
                        context,
                        widget.data,
                        widget.index,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const Divider(height: 1, color: Color(0xFFE0E0E0)),
      ],
    );
  }
}
