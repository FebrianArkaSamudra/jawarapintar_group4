import 'package:flutter/material.dart';

// Small local model mirroring the attachment version
class _PenerimaanWargaItem {
  int no;
  String Nama;
  String NIK;
  String Email;
  String Jenis_Kelamin;
  String Foto_Identitas;
  String status;

  _PenerimaanWargaItem({
    required this.no,
    required this.Nama,
    required this.NIK,
    required this.Email,
    required this.Jenis_Kelamin,
    required this.Foto_Identitas,
    required this.status,
  });
}

class InformasiPenerimaanWargaScreen extends StatefulWidget {
  const InformasiPenerimaanWargaScreen({super.key});

  @override
  State<InformasiPenerimaanWargaScreen> createState() =>
      _InformasiPenerimaanWargaScreenState();
}

class _InformasiPenerimaanWargaScreenState
    extends State<InformasiPenerimaanWargaScreen> {
  // Data utama
  final List<_PenerimaanWargaItem> _items = [
    _PenerimaanWargaItem(
        no: 1,
        Nama: 'Slamet',
        NIK: '23417202556',
        Email: 'Slamet@gmail.com',
        Jenis_Kelamin: 'Laki-laki',
        Foto_Identitas: '-',
        status: 'Diterima'),
    _PenerimaanWargaItem(
        no: 2,
        Nama: 'Murjoko',
        NIK: '23417202552',
        Email: 'Joko@gmail.com',
        Jenis_Kelamin: 'Laki-laki',
        Foto_Identitas: '-',
        status: 'Pending'),
    _PenerimaanWargaItem(
        no: 3,
        Nama: 'Budianto',
        NIK: '23417202550',
        Email: 'Budianti@gmail.com',
        Jenis_Kelamin: 'Laki-Laki',
        Foto_Identitas: '-',
        status: 'Ditolak'),
    _PenerimaanWargaItem(
        no: 4,
        Nama: 'Mamat Edi',
        NIK: '23417202550',
        Email: 'Madimamat@gmail.com',
        Jenis_Kelamin: 'Laki-Laki',
        Foto_Identitas: '-',
        status: 'Diterima'),
    _PenerimaanWargaItem(
        no: 5,
        Nama: 'Putri Ikan',
        NIK: '23417202550',
        Email: 'Syahputri@gmail.com',
        Jenis_Kelamin: 'Perempuan',
        Foto_Identitas: '-',
        status: 'Pending'),
    _PenerimaanWargaItem(
        no: 6,
        Nama: 'Siti Aminah',
        NIK: '23417202550',
        Email: 'sitimiminah@gmail.com',
        Jenis_Kelamin: 'Perempuan',
        Foto_Identitas: '-',
        status: 'Ditolak'),
    _PenerimaanWargaItem(
        no: 7,
        Nama: 'Andi Susanto',
        NIK: '23417202551',
        Email: 'Andiabi@gmail.com',
        Jenis_Kelamin: 'Laki-Laki',
        Foto_Identitas: '-',
        status: 'Diterima'),
    _PenerimaanWargaItem(
        no: 8,
        Nama: 'Dewi Lestari',
        NIK: '23417202553',
        Email: 'dewisrilestari@gmail.com',
        Jenis_Kelamin: 'Perempuan',
        Foto_Identitas: '-',
        status: 'Pending'),
    _PenerimaanWargaItem(
        no: 9,
        Nama: 'Rina Marlina',
        NIK: '23417202554',
        Email: 'RinaMarsuki@gmail.com',
        Jenis_Kelamin: 'Perempuan',
        Foto_Identitas: '-', 
        status: 'Ditolak'),
    _PenerimaanWargaItem(
        no: 10,
        Nama: 'Agus Salim',
        NIK: '23417202555',
        Email: 'Agussamania@gmail.com',
        Jenis_Kelamin: 'Laki-Laki',
        Foto_Identitas: '-',
        status: 'Diterima'),
  ];

  // Tambahkan list filtered
  List<_PenerimaanWargaItem> _filteredItems = [];

  @override
  void initState() {
    super.initState();
    _filteredItems = List.from(_items); // awal: tampil semua
  }

  // Fungsi untuk menerapkan filter
  void _applyFilter(String? nama, String? kelamin, String? status) {
    setState(() {
      _filteredItems = _items.where((item) {
        final matchNama = nama == null || nama.isEmpty
            ? true
            : item.Nama.toLowerCase().contains(nama.toLowerCase());
        final matchKelamin = kelamin == null || kelamin.isEmpty
            ? true
            : item.Jenis_Kelamin.toLowerCase().contains(kelamin.toLowerCase());
        final matchStatus = status == null || status.isEmpty
            ? true
            : item.status.toLowerCase() == status.toLowerCase();

        return matchNama && matchKelamin && matchStatus;
      }).toList();
    });
  }

  // Widget status badge
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
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.assignment_turned_in_outlined, color: textColor, size: 14),
          const SizedBox(width: 6),
          Text(status,
              style: TextStyle(color: textColor, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  // ===================== FILTER MODAL =====================
  void _showFilterModal(BuildContext context) {
    String? selectedStatus;
    final TextEditingController NamaController = TextEditingController();
    final TextEditingController KelaminController = TextEditingController();

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
                const Text('Filter Penerimaan Warga',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                InkWell(
                    onTap: () => Navigator.of(dialogCtx).pop(),
                    child: const Icon(Icons.close)),
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
                    const Text('Nama',
                        style: TextStyle(fontWeight: FontWeight.w600)),
                    const SizedBox(height: 8),
                    TextField(
                      controller: NamaController,
                      decoration: InputDecoration(
                        hintText: 'Cari Nama',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text('Jenis Kelamin',
                        style: TextStyle(fontWeight: FontWeight.w600)),
                    const SizedBox(height: 8),
                    TextField(
                      controller: KelaminController,
                      decoration: InputDecoration(
                        hintText: '-- Pilih Jenis Kelamin --',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8)),
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
                          .map((s) => DropdownMenuItem(
                                value: s,
                                child: Text(s),
                              ))
                          .toList(),
                      onChanged: (v) => setStateSB(() => selectedStatus = v),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        OutlinedButton(
                          onPressed: () {
                            NamaController.clear();
                            KelaminController.clear();
                            setState(() {
                              _filteredItems = List.from(_items);
                            });
                            setStateSB(() {
                              selectedStatus = null;
                            });
                          },
                          child: const Text('Reset Filter'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            _applyFilter(NamaController.text,
                                KelaminController.text, selectedStatus);
                            Navigator.of(dialogCtx).pop();
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

  // Variable detail view
  _PenerimaanWargaItem? SelectedItem;

  Widget _buildActionMenu(
      BuildContext context, _PenerimaanWargaItem item, int index) {
    return PopupMenuButton<String>(
      icon: const Icon(Icons.more_horiz, color: Color(0xFF999999)),
      offset: const Offset(0, 36),
      itemBuilder: (ctx) => [
        PopupMenuItem(
          value: 'Detail',
          child: Row(
            children: const [
              Icon(Icons.visibility_outlined, size: 18),
              SizedBox(width: 50),
              Text('Detail'),
            ],
          ),
          onTap: () {
            Future.delayed(Duration.zero, () {
              setState(() => SelectedItem = item);
            });
          },
        ),
      ],
    );
  }

  Widget _buildDetailSection() {
    if (SelectedItem == null) return const SizedBox();
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Column(
        children: [
          const Divider(thickness: 1.5, height: 32),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFF9F9F9),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFE0E0E0)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Detail Penerimaan Warga',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                const SizedBox(height: 12),
                _buildDetailRow('Nama', SelectedItem!.Nama),
                _buildDetailRow('NIK', SelectedItem!.NIK),
                _buildDetailRow('Email', SelectedItem!.Email),
                _buildDetailRow('Jenis Kelamin', SelectedItem!.Jenis_Kelamin),
                _buildDetailRow('Foto Identitas', SelectedItem!.Foto_Identitas),
                _buildDetailRow('Status', SelectedItem!.status),
                const SizedBox(height: 12),
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton.icon(
                    onPressed: () => setState(() => SelectedItem = null),
                    icon: const Icon(Icons.close),
                    label: const Text('Tutup'),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          SizedBox(
              width: 130,
              child:
                  Text('$label:', style: const TextStyle(fontWeight: FontWeight.w600))),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const headerStyle = TextStyle(
        fontWeight: FontWeight.w600, color: Color(0xFF666666), fontSize: 14);
    const bodyStyle = TextStyle(color: Color(0xFF333333), fontSize: 14);

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.04),
                        blurRadius: 10,
                        offset: const Offset(0, 5))
                  ]),
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
                  const SizedBox(height: 20),
                  // header tabel
                  Row(
                    children: const [
                      SizedBox(width: 50, child: Text('No', style: headerStyle)),
                      Expanded(
                          flex: 3,
                          child: Center(child: Text('Nama', style: headerStyle))),
                      Expanded(
                          flex: 3,
                          child: Center(child: Text('NIK', style: headerStyle))),
                      Expanded(
                          flex: 3,
                          child:
                              Center(child: Text('Email', style: headerStyle))),
                      Expanded(
                          flex: 3,
                          child: Center(
                              child: Text('Jenis Kelamin', style: headerStyle))),
                      Expanded(
                          flex: 3,
                          child: Center(
                              child: Text('Foto Identitas', style: headerStyle))),
                      Expanded(
                          flex: 2,
                          child: Center(
                              child: Text('Status', style: headerStyle))),
                      SizedBox(
                          width: 50,
                          child: Center(
                              child: Text('Aksi', style: headerStyle))),
                    ],
                  ),
                  const Divider(height: 17,thickness: 1, color: Color(0xFFE0E0E0)),
                  Expanded(
                    child: Column(
                      children: [
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HoverableRow extends StatefulWidget {
  final _PenerimaanWargaItem data;
  final TextStyle bodyStyle;
  final Widget Function(BuildContext, String) buildStatusBadge;
  final Widget Function(BuildContext, _PenerimaanWargaItem, int)
      buildActionButton;
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
    );

    return Column(
      children: [
        MouseRegion(
          onEnter: (_) => setState(() => _hover = true),
          onExit: (_) => setState(() => _hover = false),
          child: Container(
            decoration: decoration,
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Row(
              children: [
                SizedBox(width: 50, child: Text('${widget.data.no}.')),
                Expanded(
                    flex: 3,
                    child: Center(child: Text(widget.data.Nama))),
                Expanded(
                    flex: 3,
                    child: Center(child: Text(widget.data.NIK))),
                Expanded(
                    flex: 3,
                    child: Center(child: Text(widget.data.Email))),
                Expanded(
                    flex: 3,
                    child: Center(child: Text(widget.data.Jenis_Kelamin))),
                Expanded(
                    flex: 3,
                    child: Center(child: Text(widget.data.Foto_Identitas))),
                Expanded(
                    flex: 2,
                    child:
                        widget.buildStatusBadge(context, widget.data.status)),
                SizedBox(
                    width: 50,
                    child: widget.buildActionButton(
                        context, widget.data, widget.index)),
              ],
            ),
          ),
        ),
        const Divider(height: 1, thickness: 1, color: Color(0xFFF0F0F0))
      ],
    );
  }
}
