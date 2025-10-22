import 'package:flutter/material.dart';

// Small local model mirroring the attachment version
class _AspirasiItem {
  int no;
  String pengirim;
  String judul;
  String status;
  String tanggal;

  _AspirasiItem({
    required this.no,
    required this.pengirim,
    required this.judul,
    required this.status,
    required this.tanggal,
  });
}

class InformasiAspirasiScreen extends StatefulWidget {
  const InformasiAspirasiScreen({super.key});

  @override
  State<InformasiAspirasiScreen> createState() =>
      _InformasiAspirasiScreenState();
}

class _InformasiAspirasiScreenState extends State<InformasiAspirasiScreen> {
  // use a mutable list of model objects
  final List<_AspirasiItem> _items = [
    _AspirasiItem(
      no: 1,
      pengirim: 'Slamet',
      judul: 'Uji Coba',
      status: 'Diterima',
      tanggal: '26 September 2025',
    ),
    _AspirasiItem(
      no: 2,
      pengirim: 'Murjoko',
      judul: 'Tes Jaringan',
      status: 'Pending',
      tanggal: '27 September 2025',
    ),
    _AspirasiItem(
      no: 3,
      pengirim: 'Budianto',
      judul: 'Lampu Jalan Mati',
      status: 'Ditolak',
      tanggal: '28 September 2025',
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
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color, width: 1.5),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
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
            builder: (context, setState) {
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
                          .map(
                            (s) => DropdownMenuItem(value: s, child: Text(s)),
                          )
                          .toList(),
                      onChanged: (v) => setState(() => selectedStatus = v),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        OutlinedButton(
                          onPressed: () {
                            judulController.clear();
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

  // Action menu builder: triggers detail/edit/hapus
  Widget _buildActionMenu(BuildContext context, _AspirasiItem item, int index) {
    return PopupMenuButton<String>(
      icon: const Icon(Icons.more_horiz, color: Color(0xFF999999)),
      offset: const Offset(0, 36),
      onSelected: (value) async {
        // No-op here; we handle actions in onTap of menu items to ensure immediate response
      },
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
            // Show inline detail dialog
            Future.delayed(Duration.zero, () {
              showDialog(
                context: context,
                builder: (dctx) => AlertDialog(
                  title: const Text('Detail Informasi'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Pengirim: ${item.pengirim}'),
                      const SizedBox(height: 6),
                      Text('Judul: ${item.judul}'),
                      const SizedBox(height: 6),
                      Text('Status: ${item.status}'),
                      const SizedBox(height: 6),
                      Text('Tanggal: ${item.tanggal}'),
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(dctx),
                      child: const Text('Tutup'),
                    ),
                  ],
                ),
              );
            });
          },
        ),
        PopupMenuItem(
          value: 'Edit',
          child: Row(
            children: const [
              Icon(Icons.edit_outlined, size: 18),
              SizedBox(width: 50),
              Text('Edit'),
            ],
          ),
          onTap: () async {
            // Show edit dialog and update the item
            await Future.delayed(Duration.zero); // allow menu to close
            final controller = TextEditingController(text: item.judul);
            final res = await showDialog<bool>(
              context: context,
              builder: (dctx) => AlertDialog(
                title: const Text('Edit Judul'),
                content: TextField(controller: controller),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(dctx, false),
                    child: const Text('Batal'),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(dctx, true),
                    child: const Text('Simpan'),
                  ),
                ],
              ),
            );
            if (res == true) {
              setState(() {
                item.judul = controller.text;
              });
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text('Judul diperbarui')));
            }
          },
        ),
        PopupMenuItem(
          value: 'Hapus',
          child: Row(
            children: const [
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
                _items.removeAt(index);
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
                          flex: 2,
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              'Pengirim',
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
                              'Judul',
                              style: headerStyle,
                              textAlign: TextAlign.center
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
                        Expanded(
                          flex: 3,
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                            'Tanggal dibuat',
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
                      flex: 2,
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          widget.data.pengirim,
                          style: widget.bodyStyle,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Align(
                        alignment: Alignment.center,
                      child: Text(widget.data.judul, style: widget.bodyStyle),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Align(
                        alignment: Alignment.center,
                        child: widget.buildStatusBadge(
                          context,
                          widget.data.status,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(widget.data.tanggal, style: widget.bodyStyle),
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

// Keep StatusChip as earlier (kept for compatibility where used elsewhere)
class StatusChip extends StatelessWidget {
  final String status;

  const StatusChip({required this.status, super.key});

  Color _background(String s) {
    switch (s.toLowerCase()) {
      case 'approved':
      case 'diterima':
        return const Color(0xFFDFF7E6);
      case 'pending':
        return const Color(0xFFFFF4D9);
      case 'ditolak':
        return const Color(0xFFFEECEC);
      default:
        return const Color(0xFFECEFF6);
    }
  }

  Color _textColor(String s) {
    switch (s.toLowerCase()) {
      case 'approved':
      case 'diterima':
        return const Color(0xFF1B7A3A);
      case 'pending':
        return const Color(0xFFB97A00);
      case 'ditolak':
        return const Color(0xFFB00020);
      default:
        return Colors.black87;
    }
  }

  IconData _icon(String s) {
    switch (s.toLowerCase()) {
      case 'approved':
      case 'diterima':
        return Icons.check_circle_outline;
      case 'pending':
        return Icons.access_time;
      case 'ditolak':
        return Icons.close;
      default:
        return Icons.info_outline;
    }
  }

  @override
  Widget build(BuildContext context) {
    final bg = _background(status);
    final tc = _textColor(status);
    final icon = _icon(status);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: tc),
          const SizedBox(width: 6),
          Text(
            status,
            style: TextStyle(
              color: tc,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
