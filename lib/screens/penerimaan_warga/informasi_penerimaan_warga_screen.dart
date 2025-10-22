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
  // use a mutable list of model objects
  final List<_PenerimaanWargaItem> _items = [
    _PenerimaanWargaItem(
      no: 1,
      Nama: 'Slamet',
      NIK: '23417202556',
      Email: 'Slamet@gmail.com',
      Jenis_Kelamin: 'Laki-laki',
      Foto_Identitas: '-',
      status: 'Diterima',
    ),
    _PenerimaanWargaItem(
      no: 2,
      Nama: 'Murjoko',
      NIK: '23417202552',
      Email: 'Joko@gmail.com',
      Jenis_Kelamin: 'Laki-laki',
      Foto_Identitas: '-',
      status: 'Pending',
    ),
    _PenerimaanWargaItem(
      no: 3,
      Nama: 'Budianto',
      NIK: '23417202550',
      Email: 'Budianti@gmail.com',
      Jenis_Kelamin: 'Laki-Laki',
      Foto_Identitas: '-',
      status: 'Ditolak',
    ),
  ];

  // Build status badge like in the attachment
  Widget _buildStatusBadge(BuildContext context, String status) {
    Color color;
    Color textColor;

    switch (status.toLowerCase()) {
      case 'diterima':
      case 'approved':
        color = const Color(0xFFE6F3EE);
        textColor = const Color(0xFF1E8449);
        break;
      case 'pending':
        color = const Color(0xFFFFFBEA);
        textColor = const Color(0xFFF39C12);
        break;
      case 'ditolak':
      case 'rejected':
        color = const Color(0xFFFBEAEA);
        textColor = const Color(0xFFDC3545);
        break;
      default:
        color = const Color(0xFFE0E0E0);
        textColor = const Color(0xFF666666);
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color, width: 1.5),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
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

  // Filter modal from attachment
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
                const Text(
                  'Filter Penerimaan Warga',
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
            builder: (context, setState) {
              return SizedBox(
                width: 500,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 12),
                    const Text(
                      'Nama',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: NamaController,
                      decoration: InputDecoration(
                        hintText: 'Cari Nama',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Jenis Kelamin',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: KelaminController,
                      decoration: InputDecoration(
                        hintText: '-- Pilih Jenis Kelamin --',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
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
                          .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                          .toList(),
                      onChanged: (v) => setState(() => selectedStatus = v),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        OutlinedButton(
                          onPressed: () {
                            NamaController.clear();
                            setState(() {
                              selectedStatus = null;
                            });
                          },
                          child: const Text('Reset Filter'),
                        ),
                        ElevatedButton(
                          onPressed: () {
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

  // variable to hold selected item for detail view
  _PenerimaanWargaItem? SelectedItem;

  // Action menu builder: triggers detail/edit/hapus
  Widget _buildActionMenu(
    BuildContext context,
    _PenerimaanWargaItem item,
    int index,
  ) {
    return PopupMenuButton<String>(
      icon: const Icon(Icons.more_horiz, color: Color(0xFF999999)),
      offset: const Offset(0, 36),
      onSelected: (value) {},
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
              setState(() {
                SelectedItem = item;
              });
            });
          },
        ),
      ],
    );
  }

  // widget detail muncul di bawah tabel
  Widget _buildDetailSection() {
    if (SelectedItem == null) return const SizedBox();

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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Detail Penerimaan Warga',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
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
                    onPressed: () {
                      setState(() {
                        SelectedItem = null;
                      });
                    },
                    icon: const Icon(Icons.close),
                    label: const Text('Tutup'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // helper untuk membangun baris detail
  Widget _buildDetailRow(String label, String value) {
    return Padding(
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
  }

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
                    color: Colors.black.withOpacity(0.04),
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
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      children: const [
                        SizedBox(
                          width: 50,
                          child: Text('No', style: headerStyle),
                        ),
                        Expanded(
                          flex: 3,
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              'Nama',
                              style: headerStyle,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              'NIK',
                              style: headerStyle,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              'Email',
                              style: headerStyle,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              'Jenis Kelamin',
                              style: headerStyle,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              'Foto Identitas',
                              style: headerStyle,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              'Status',
                              style: headerStyle,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 50,
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              'Aksi',
                              style: headerStyle,
                              textAlign: TextAlign.center,
                            ),
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
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            itemCount: _items.length,
                            itemBuilder: (context, index) {
                              final it = _items[index];
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
            child: InkWell(
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: Row(
                  children: [
                    SizedBox(
                      width: 50,
                      child: Text(
                        '${widget.data.no}.',
                        style: widget.bodyStyle,
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          widget.data.Nama,
                          style: widget.bodyStyle,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(widget.data.NIK, style: widget.bodyStyle),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(widget.data.Email, style: widget.bodyStyle),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          widget.data.Jenis_Kelamin,
                          style: widget.bodyStyle,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          widget.data.Foto_Identitas,
                          style: widget.bodyStyle,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: widget.buildStatusBadge(
                        context,
                        widget.data.status,
                      ),
                    ),
                    SizedBox(
                      width: 50,
                      child: widget.buildActionButton(
                        context,
                        widget.data,
                        widget.index,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        const Divider(height: 1, thickness: 0.5, color: Color(0xFFF0F0F0)),
      ],
    );
  }
}
