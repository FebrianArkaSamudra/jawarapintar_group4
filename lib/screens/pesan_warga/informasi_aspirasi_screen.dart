<<<<<<< HEAD
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
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color, width: 1.5),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.assignment_turned_in_outlined, color: textColor, size: 14),
          const SizedBox(width: 6),
          Text(
            status,
            textAlign: TextAlign.center,
            style: TextStyle(color: textColor, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  // ===== FILTER MODAL =====
  void _showFilterModal(BuildContext context) {
    String? selectedStatus;
    final TextEditingController judulController = TextEditingController();

    showDialog(
      context: context,
      builder: (dialogCtx) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          titlePadding: EdgeInsets.zero,
          contentPadding: const EdgeInsets.all(20),
          title: Padding(
            padding: const EdgeInsets.all(16).copyWith(bottom: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Filter Pesan Warga',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                InkWell(
                  onTap: () => Navigator.of(dialogCtx).pop(),
                  child: const Icon(Icons.close),
                ),
              ],
            ),
          ),
          content: StatefulBuilder(
            builder: (context, setStateSB) {
              return SizedBox(
                width: 500,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 12),
                    const Text(
                      'Judul',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: judulController,
                      decoration: InputDecoration(
                        hintText: 'Cari judul...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Status',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 8),
                    DropdownButtonFormField<String>(
                      value: selectedStatus,
                      hint: const Text('-- Pilih Status --'),
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
                        OutlinedButton(
                          onPressed: () {
                            judulController.clear();
                            setStateSB(() => selectedStatus = null);
                            setState(
                              () => _filteredItems = List.from(_allItems),
                            );
                          },
                          child: const Text('Reset Filter'),
                        ),
                        ElevatedButton(
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
                          child: const Text('Terapkan'),
                        ),
                      ],
                    ),
                  ],
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

  // ===== DETAIL / EDIT SECTION =====
  Widget _buildDetailSection() {
    if (_selectedItem == null) return const SizedBox();
    final item = _selectedItem!;
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Column(
        children: [
          const Divider(thickness: 1.5, height: 32),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16.0),
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Detail Informasi Aspirasi',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 12),
        _buildDetailRow('Pengirim', item.pengirim),
        _buildDetailRow('Judul', item.judul),
        _buildDetailRow('Status', item.status),
        _buildDetailRow('Tanggal', item.tanggal),
        _buildDetailRow('Deskripsi', item.deskripsi),
        const SizedBox(height: 12),
        Align(
          alignment: Alignment.centerRight,
          child: ElevatedButton.icon(
            onPressed: () => setState(() => _selectedItem = null),
            icon: const Icon(Icons.close),
            label: const Text('Tutup'),
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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Edit Informasi Aspirasi',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: judulController,
          decoration: InputDecoration(
            labelText: 'Judul Aspirasi',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
          ),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: deskripsiController,
          maxLines: 3,
          decoration: InputDecoration(
            labelText: 'Deskripsi Aspirasi',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
          ),
        ),
        const SizedBox(height: 12),
        DropdownButtonFormField<String>(
          value: selectedStatus,
          decoration: InputDecoration(
            labelText: 'Status Aspirasi',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
          ),
          items: const [
            DropdownMenuItem(value: 'Pending', child: Text('Pending')),
            DropdownMenuItem(value: 'Diterima', child: Text('Diterima')),
            DropdownMenuItem(value: 'Ditolak', child: Text('Ditolak')),
          ],
          onChanged: (v) => selectedStatus = v,
        ),
        const SizedBox(height: 16),
        Align(
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
                icon: const Icon(Icons.save_outlined),
                label: const Text('Simpan'),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDetailRow(String label, String value) => Padding(
    padding: const EdgeInsets.only(bottom: 8.0),
    child: Row(
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

  // ===== MAIN BUILD =====
  @override
  Widget build(BuildContext context) {
    const headerStyle = TextStyle(
      fontWeight: FontWeight.w600,
      color: Color(0xFF666666),
      fontSize: 14,
    );
    const bodyStyle = TextStyle(color: Color(0xFF333333), fontSize: 14);

    return Padding(
      padding: const EdgeInsets.all(24.0),
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
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: OutlinedButton.icon(
                      onPressed: () => _showFilterModal(context),
                      icon: const Icon(Icons.filter_list),
                      label: const Text('Filters'),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      children: const [
                        SizedBox(
                          width: 50,
                          child: Text('No', style: headerStyle),
                        ),
                        Expanded(
                          flex: 2,
                          child: Center(
                            child: Text('Pengirim', style: headerStyle),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Center(
                            child: Text('Judul', style: headerStyle),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Center(
                            child: Text('Status', style: headerStyle),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Center(
                            child: Text('Tanggal Dibuat', style: headerStyle),
                          ),
                        ),
                        SizedBox(
                          width: 50,
                          child: Center(
                            child: Text('Aksi', style: headerStyle),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    height: 1,
                    thickness: 1,
                    color: Color(0xFFE0E0E0),
                  ),
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
                  _buildDetailSection(),
                ],
              ),
            ),
          ),
        ],
      ),
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
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Row(
                children: [
                  SizedBox(
                    width: 50,
                    child: Text('${widget.data.no}.', style: widget.bodyStyle),
                  ),
                  Expanded(
                    flex: 2,
                    child: Center(
                      child: Text(
                        widget.data.pengirim,
                        style: widget.bodyStyle,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Center(
                      child: Text(widget.data.judul, style: widget.bodyStyle),
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
                    flex: 3,
                    child: Center(
                      child: Text(widget.data.tanggal, style: widget.bodyStyle),
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
=======
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
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color, width: 1.5),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.assignment_turned_in_outlined, color: textColor, size: 14),
          const SizedBox(width: 6),
          Text(
            status,
            textAlign: TextAlign.center,
            style: TextStyle(color: textColor, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  // ===== FILTER MODAL =====
  void _showFilterModal(BuildContext context) {
    String? selectedStatus;
    final TextEditingController judulController = TextEditingController();

    showDialog(
      context: context,
      builder: (dialogCtx) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          titlePadding: EdgeInsets.zero,
          contentPadding: const EdgeInsets.all(20),
          title: Padding(
            padding: const EdgeInsets.all(16).copyWith(bottom: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Filter Pesan Warga',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                InkWell(
                  onTap: () => Navigator.of(dialogCtx).pop(),
                  child: const Icon(Icons.close),
                ),
              ],
            ),
          ),
          content: StatefulBuilder(
            builder: (context, setStateSB) {
              return SizedBox(
                width: 500,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 12),
                    const Text('Judul',
                        style: TextStyle(fontWeight: FontWeight.w600)),
                    const SizedBox(height: 8),
                    TextField(
                      controller: judulController,
                      decoration: InputDecoration(
                        hintText: 'Cari judul...',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15)),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text('Status',
                        style: TextStyle(fontWeight: FontWeight.w600)),
                    const SizedBox(height: 8),
                    DropdownButtonFormField<String>(
                      value: selectedStatus,
                      hint: const Text('-- Pilih Status --'),
                      items: const ['Pending', 'Diterima', 'Ditolak']
                          .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                          .toList(),
                      onChanged: (v) => setStateSB(() => selectedStatus = v),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        OutlinedButton(
                          onPressed: () {
                            judulController.clear();
                            setStateSB(() => selectedStatus = null);
                            setState(() => _filteredItems = List.from(_allItems));
                          },
                          child: const Text('Reset Filter'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(dialogCtx).pop();
                            setState(() {
                              _filteredItems = _allItems.where((item) {
                                final matchJudul = judulController.text.isEmpty ||
                                    item.judul
                                        .toLowerCase()
                                        .contains(judulController.text.toLowerCase());
                                final matchStatus = selectedStatus == null ||
                                    item.status == selectedStatus;
                                return matchJudul && matchStatus;
                              }).toList();
                            });
                          },
                          child: const Text('Terapkan'),
                        ),
                      ],
                    ),
                  ],
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
                      child: const Text('Batal')),
                  TextButton(
                      onPressed: () => Navigator.pop(dctx, true),
                      child: const Text('Hapus')),
                ],
              ),
            );
            if (confirm == true) {
              setState(() {
                _filteredItems.removeAt(index);
                _selectedItem = null;
              });
              ScaffoldMessenger.of(context)
                  .showSnackBar(const SnackBar(content: Text('Item dihapus')));
            }
          },
        ),
      ],
    );
  }

  // ===== DETAIL / EDIT SECTION =====
  Widget _buildDetailSection() {
    if (_selectedItem == null) return const SizedBox();
    final item = _selectedItem!;
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Column(
        children: [
          const Divider(thickness: 1.5, height: 32),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16.0),
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Detail Informasi Aspirasi',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
        const SizedBox(height: 12),
        _buildDetailRow('Pengirim', item.pengirim),
        _buildDetailRow('Judul', item.judul),
        _buildDetailRow('Status', item.status),
        _buildDetailRow('Tanggal', item.tanggal),
        _buildDetailRow('Deskripsi', item.deskripsi),
        const SizedBox(height: 12),
        Align(
          alignment: Alignment.centerRight,
          child: ElevatedButton.icon(
            onPressed: () => setState(() => _selectedItem = null),
            icon: const Icon(Icons.close),
            label: const Text('Tutup'),
          ),
        ),
      ],
    );
  }

  // ===== FORM EDIT =====
  Widget _buildEditForm(_AspirasiItem item) {
    final TextEditingController judulController =
        TextEditingController(text: item.judul);
    final TextEditingController deskripsiController =
        TextEditingController(text: item.deskripsi);
    String? selectedStatus = item.status;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Edit Informasi Aspirasi',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
        const SizedBox(height: 12),
        TextField(
          controller: judulController,
          decoration: InputDecoration(
            labelText: 'Judul Aspirasi',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
          ),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: deskripsiController,
          maxLines: 3,
          decoration: InputDecoration(
            labelText: 'Deskripsi Aspirasi',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
          ),
        ),
        const SizedBox(height: 12),
        DropdownButtonFormField<String>(
          value: selectedStatus,
          decoration: InputDecoration(
            labelText: 'Status Aspirasi',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
          ),
          items: const [
            DropdownMenuItem(value: 'Pending', child: Text('Pending')),
            DropdownMenuItem(value: 'Diterima', child: Text('Diterima')),
            DropdownMenuItem(value: 'Ditolak', child: Text('Ditolak')),
          ],
          onChanged: (v) => selectedStatus = v,
        ),
        const SizedBox(height: 16),
        Align(
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
                icon: const Icon(Icons.save_outlined),
                label: const Text('Simpan'),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDetailRow(String label, String value) => Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
                width: 130,
                child: Text('$label:',
                    style: const TextStyle(fontWeight: FontWeight.w600))),
            Expanded(child: Text(value)),
          ],
        ),
      );

  // ===== MAIN BUILD =====
  @override
  Widget build(BuildContext context) {
    const headerStyle = TextStyle(
        fontWeight: FontWeight.w600, color: Color(0xFF666666), fontSize: 14);
    const bodyStyle = TextStyle(color: Color(0xFF333333), fontSize: 14);

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 5)),
              ],
            ),
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: OutlinedButton.icon(
                    onPressed: () => _showFilterModal(context),
                    icon: const Icon(Icons.filter_list),
                    label: const Text('Filters'),
                  ),
                ),
                const SizedBox(height: 6),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(children: const [
                    SizedBox(width: 50, child: Text('No', style: headerStyle)),
                    Expanded(
                        flex: 2,
                        child:
                            Center(child: Text('Pengirim', style: headerStyle))),
                    Expanded(
                        flex: 3,
                        child:
                            Center(child: Text('Judul', style: headerStyle))),
                    Expanded(
                        flex: 2,
                        child:
                            Center(child: Text('Status', style: headerStyle))),
                    Expanded(
                        flex: 3,
                        child:
                            Center(child: Text('Tanggal Dibuat', style: headerStyle))),
                    SizedBox(
                        width: 50,
                        child: Center(child: Text('Aksi', style: headerStyle))),
                  ]),
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
                _buildDetailSection(),
              ],
            ),
          ),
        ),
      ]),
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

    return Column(children: [
      MouseRegion(
        onEnter: (_) => setState(() => _hover = true),
        onExit: (_) => setState(() => _hover = false),
        cursor: SystemMouseCursors.click,
        child: Container(
          decoration: decoration,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: Row(children: [
              SizedBox(width: 50, child: Text('${widget.data.no}.', style: widget.bodyStyle)),
              Expanded(
                flex: 2,
                child: Center(child: Text(widget.data.pengirim, style: widget.bodyStyle)),
              ),
              Expanded(
                flex: 3,
                child: Center(child: Text(widget.data.judul, style: widget.bodyStyle)),
              ),
              Expanded(
                flex: 2,
                child: Center(
                    child: widget.buildStatusBadge(context, widget.data.status)),
              ),
              Expanded(
                flex: 3,
                child: Center(child: Text(widget.data.tanggal, style: widget.bodyStyle)),
              ),
              SizedBox(
                  width: 50,
                  child: Center(child: widget.buildActionButton(context, widget.data, widget.index))),
            ]),
          ),
        ),
      ),
      const Divider(height: 1, color: Color(0xFFE0E0E0)),
    ]);
  }
}
>>>>>>> 8631290c6f3983e5b9d182dbf1d96a36fad8a3ed
