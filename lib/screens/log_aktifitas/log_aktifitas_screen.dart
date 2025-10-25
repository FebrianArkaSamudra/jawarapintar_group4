import 'package:flutter/material.dart';

class LogAktifitasScreen extends StatefulWidget {
  const LogAktifitasScreen({super.key});

  @override
  State<LogAktifitasScreen> createState() => _LogAktifitasScreenState();
}

class _LogAktifitasScreenState extends State<LogAktifitasScreen> {
  final int _rowsPerPage = 10;
  int _currentPage = 1;

  late final List<Map<String, String>> _allItems;
  late List<Map<String, String>> _filteredItems;

  // Filter state
  final TextEditingController _searchController = TextEditingController();
  DateTime? _filterStart;
  DateTime? _filterEnd;
  String? _filterAktor;

  @override
  void initState() {
    super.initState();
    // Example data to mirror screenshot
    _allItems = List.generate(180, (i) {
      final no = (i + 1).toString();
      return {
        'no': no,
        'deskripsi': i % 6 == 0
            ? 'Membuat broadcast baru: Pengumuman'
            : 'Menugaskan tagihan : Mingguan periode Oktober 2025 sebesar Rp. 12',
        'aktor': 'Admin Jawara',
        'tanggal': '21 Oktober 2025',
      };
    });
    // initial filtered items is the full list
    _filteredItems = List<Map<String, String>>.from(_allItems);
  }

  List<Map<String, String>> get _pagedItems {
    final start = (_currentPage - 1) * _rowsPerPage;
    final end = (_currentPage * _rowsPerPage).clamp(0, _filteredItems.length);
    return _filteredItems.sublist(start, end);
  }

  int get _pageCount => (_allItems.length / _rowsPerPage).ceil();

  void _goToPage(int p) {
    setState(() {
      _currentPage = p.clamp(1, _pageCount);
    });
  }

  // Apply filter criteria to _allItems and update _filteredItems
  void _applyFilter({
    String? keyword,
    String? aktor,
    DateTime? start,
    DateTime? end,
  }) {
    setState(() {
      _filterAktor = aktor;
      _filterStart = start;
      _filterEnd = end;
      _searchController.text = keyword ?? '';

      _filteredItems = _allItems.where((item) {
        // keyword filter against deskripsi and aktor
        final q = (keyword ?? '').toLowerCase().trim();
        if (q.isNotEmpty) {
          final matches =
              (item['deskripsi'] ?? '').toLowerCase().contains(q) ||
              (item['aktor'] ?? '').toLowerCase().contains(q) ||
              (item['tanggal'] ?? '').toLowerCase().contains(q);
          if (!matches) return false;
        }

        if (aktor != null && aktor.isNotEmpty) {
          if ((item['aktor'] ?? '') != aktor) return false;
        }

        // date parsing: our sample uses '21 Oktober 2025' - we'll try a simple contains check if start/end provided
        if (start != null || end != null) {
          // attempt to parse day number out of string
          try {
            // fallback: use DateTime.now() for all sample items (they're identical)
            // if real data exists, developer can replace parsing with proper format
            final itemDate = DateTime.now();
            if (start != null && itemDate.isBefore(start)) return false;
            if (end != null && itemDate.isAfter(end)) return false;
          } catch (_) {
            // ignore parsing errors
          }
        }

        return true;
      }).toList();

      // reset to first page
      _currentPage = 1;
    });
  }

  void _resetFilter() {
    setState(() {
      _filterAktor = null;
      _filterStart = null;
      _filterEnd = null;
      _searchController.clear();
      _filteredItems = List<Map<String, String>>.from(_allItems);
      _currentPage = 1;
    });
  }

  Future<void> _openFilterDialog() async {
    String tempKeyword = _searchController.text;
    String? tempAktor = _filterAktor;
    DateTime? tempStart = _filterStart;
    DateTime? tempEnd = _filterEnd;

    await showDialog<void>(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 700),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Filter Log Aktifitas',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text('Kata kunci (deskripsi / aktor / tanggal)'),
                      TextField(
                        controller: TextEditingController.fromValue(
                          TextEditingValue(text: tempKeyword),
                        ),
                        onChanged: (v) => tempKeyword = v,
                        decoration: const InputDecoration(hintText: 'Cari...'),
                      ),
                      const SizedBox(height: 12),
                      const Text('Aktor'),
                      DropdownButtonFormField<String>(
                        value: tempAktor,
                        items:
                            <String>{..._allItems.map((e) => e['aktor'] ?? '')}
                                .map(
                                  (e) => DropdownMenuItem(
                                    value: e,
                                    child: Text(e),
                                  ),
                                )
                                .toList(),
                        onChanged: (v) => setStateDialog(() => tempAktor = v),
                        decoration: const InputDecoration(
                          hintText: '-- semua aktor --',
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Dari Tanggal'),
                                const SizedBox(height: 6),
                                InkWell(
                                  onTap: () async {
                                    final picked = await showDatePicker(
                                      context: context,
                                      initialDate: tempStart ?? DateTime.now(),
                                      firstDate: DateTime(2000),
                                      lastDate: DateTime(2100),
                                    );
                                    if (picked != null)
                                      setStateDialog(() => tempStart = picked);
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 10,
                                      horizontal: 12,
                                    ),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.grey.shade300,
                                      ),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Text(
                                      tempStart != null
                                          ? '${tempStart!.day}/${tempStart!.month}/${tempStart!.year}'
                                          : '--/--/----',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Sampai Tanggal'),
                                const SizedBox(height: 6),
                                InkWell(
                                  onTap: () async {
                                    final picked = await showDatePicker(
                                      context: context,
                                      initialDate: tempEnd ?? DateTime.now(),
                                      firstDate: DateTime(2000),
                                      lastDate: DateTime(2100),
                                    );
                                    if (picked != null)
                                      setStateDialog(() => tempEnd = picked);
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 10,
                                      horizontal: 12,
                                    ),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.grey.shade300,
                                      ),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Text(
                                      tempEnd != null
                                          ? '${tempEnd!.day}/${tempEnd!.month}/${tempEnd!.year}'
                                          : '--/--/----',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 18),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {
                              _resetFilter();
                              Navigator.of(context).pop();
                            },
                            child: const Text('Reset'),
                          ),
                          const SizedBox(width: 12),
                          ElevatedButton(
                            onPressed: () {
                              _applyFilter(
                                keyword: tempKeyword,
                                aktor: tempAktor,
                                start: tempStart,
                                end: tempEnd,
                              );
                              Navigator.of(context).pop();
                            },
                            child: const Text('Terapkan'),
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
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 700;
    // Light theme colors tuned to match the provided screenshot
    const bgCard = Colors.white;
    const innerTableBg = Colors.white;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1400),
          child: Card(
            color: bgCard,
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 12.0,
                horizontal: 14.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Header: title + search + filter
                  // header: title + small metadata + search/filter
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Log Aktifitas',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${_filteredItems.length} entri',
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      const SizedBox(width: 12),
                      OutlinedButton.icon(
                        onPressed: () => _openFilterDialog(),
                        icon: const Icon(
                          Icons.filter_list,
                          color: Colors.black87,
                        ),
                        label: const Text(
                          'Filter',
                          style: TextStyle(color: Colors.black87),
                        ),
                        style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.white,
                          side: BorderSide(color: Colors.grey.shade300),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Table container
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: innerTableBg,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey.shade200),
                      ),
                      child: Column(
                        children: [
                          // For small screens we show a card/list layout; for larger screens keep the table
                          isMobile
                              ? Expanded(
                                  child: _filteredItems.isEmpty
                                      ? Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(24.0),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Icon(
                                                  Icons.inbox,
                                                  size: 48,
                                                  color: Colors.grey.shade400,
                                                ),
                                                const SizedBox(height: 12),
                                                Text(
                                                  'Tidak ada log yang sesuai filter',
                                                  style: TextStyle(
                                                    color: Colors.grey.shade600,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      : ListView.separated(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 8,
                                            horizontal: 6,
                                          ),
                                          itemCount: _filteredItems.length,
                                          separatorBuilder: (_, __) => Divider(
                                            height: 8,
                                            color: Colors.grey.shade200,
                                          ),
                                          itemBuilder: (context, index) {
                                            final item = _filteredItems[index];
                                            return Card(
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                    vertical: 4,
                                                  ),
                                              child: ListTile(
                                                contentPadding:
                                                    const EdgeInsets.symmetric(
                                                      vertical: 12,
                                                      horizontal: 12,
                                                    ),
                                                leading: CircleAvatar(
                                                  backgroundColor:
                                                      Colors.grey.shade200,
                                                  child: Text(item['no'] ?? ''),
                                                ),
                                                title: Text(
                                                  item['deskripsi'] ?? '',
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                subtitle: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                        top: 6.0,
                                                      ),
                                                  child: Text(
                                                    '${item['tanggal'] ?? ''} • ${item['aktor'] ?? ''}',
                                                  ),
                                                ),
                                                trailing: PopupMenuButton<String>(
                                                  onSelected: (v) {
                                                    if (v == 'detail') {
                                                      showDialog<void>(
                                                        context: context,
                                                        builder: (ctx) => AlertDialog(
                                                          title: const Text(
                                                            'Detail Log',
                                                          ),
                                                          content: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                'No: ${item['no']}',
                                                              ),
                                                              const SizedBox(
                                                                height: 6,
                                                              ),
                                                              Text(
                                                                'Tanggal: ${item['tanggal']}',
                                                              ),
                                                              const SizedBox(
                                                                height: 6,
                                                              ),
                                                              Text(
                                                                'Aktor: ${item['aktor']}',
                                                              ),
                                                              const SizedBox(
                                                                height: 6,
                                                              ),
                                                              const Text(
                                                                'Deskripsi:',
                                                              ),
                                                              const SizedBox(
                                                                height: 4,
                                                              ),
                                                              Text(
                                                                item['deskripsi'] ??
                                                                    '',
                                                              ),
                                                            ],
                                                          ),
                                                          actions: [
                                                            TextButton(
                                                              onPressed: () =>
                                                                  Navigator.of(
                                                                    ctx,
                                                                  ).pop(),
                                                              child: const Text(
                                                                'Tutup',
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      );
                                                    }
                                                  },
                                                  itemBuilder: (_) => const [
                                                    PopupMenuItem(
                                                      value: 'detail',
                                                      child: Text('Detail'),
                                                    ),
                                                  ],
                                                  icon: Icon(
                                                    Icons.more_vert,
                                                    color: Colors.black54,
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                )
                              : Expanded(
                                  child: _filteredItems.isEmpty
                                      ? Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(24.0),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Icon(
                                                  Icons.inbox,
                                                  size: 48,
                                                  color: Colors.grey.shade400,
                                                ),
                                                const SizedBox(height: 12),
                                                Text(
                                                  'Tidak ada log yang sesuai filter',
                                                  style: TextStyle(
                                                    color: Colors.grey.shade600,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      : ListView.separated(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 8,
                                          ),
                                          itemCount: _pagedItems.length,
                                          separatorBuilder: (_, __) => Divider(
                                            height: 1,
                                            color: Colors.grey.shade200,
                                          ),
                                          itemBuilder: (context, index) {
                                            final item = _pagedItems[index];
                                            final rowIndex =
                                                index +
                                                1 +
                                                (_currentPage - 1) *
                                                    _rowsPerPage;
                                            return Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    vertical: 12,
                                                    horizontal: 12,
                                                  ),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Expanded(
                                                    flex: 1,
                                                    child: Text(
                                                      rowIndex.toString(),
                                                      style: const TextStyle(
                                                        color: Colors.black87,
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 3,
                                                    child: Text(
                                                      item['tanggal'] ?? '',
                                                      style: const TextStyle(
                                                        color: Colors.black87,
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 6,
                                                    child: Text(
                                                      item['deskripsi'] ?? '',
                                                      style: const TextStyle(
                                                        color: Colors.black87,
                                                      ),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 3,
                                                    child: Text(
                                                      item['aktor'] ?? '',
                                                      style: const TextStyle(
                                                        color: Colors.black87,
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 1,
                                                    child: Align(
                                                      alignment:
                                                          Alignment.center,
                                                      child: PopupMenuButton<String>(
                                                        onSelected: (v) {
                                                          if (v == 'detail') {
                                                            showDialog<void>(
                                                              context: context,
                                                              builder: (ctx) => AlertDialog(
                                                                title: const Text(
                                                                  'Detail Log',
                                                                ),
                                                                content: Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .min,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                      'No: ${item['no']}',
                                                                    ),
                                                                    const SizedBox(
                                                                      height: 6,
                                                                    ),
                                                                    Text(
                                                                      'Tanggal: ${item['tanggal']}',
                                                                    ),
                                                                    const SizedBox(
                                                                      height: 6,
                                                                    ),
                                                                    Text(
                                                                      'Aktor: ${item['aktor']}',
                                                                    ),
                                                                    const SizedBox(
                                                                      height: 6,
                                                                    ),
                                                                    Text(
                                                                      'Deskripsi:',
                                                                    ),
                                                                    const SizedBox(
                                                                      height: 4,
                                                                    ),
                                                                    Text(
                                                                      item['deskripsi'] ??
                                                                          '',
                                                                    ),
                                                                  ],
                                                                ),
                                                                actions: [
                                                                  TextButton(
                                                                    onPressed: () =>
                                                                        Navigator.of(
                                                                          ctx,
                                                                        ).pop(),
                                                                    child:
                                                                        const Text(
                                                                          'Tutup',
                                                                        ),
                                                                  ),
                                                                ],
                                                              ),
                                                            );
                                                          }
                                                        },
                                                        itemBuilder: (_) =>
                                                            const [
                                                              PopupMenuItem(
                                                                value: 'detail',
                                                                child: Text(
                                                                  'Detail',
                                                                ),
                                                              ),
                                                            ],
                                                        icon: Icon(
                                                          Icons.more_vert,
                                                          color: Colors.black54,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        ),
                                ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Pagination
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: _currentPage > 1
                            ? () => _goToPage(_currentPage - 1)
                            : null,
                        icon: const Icon(Icons.chevron_left),
                        color: Colors.white70,
                      ),
                      const SizedBox(width: 8),
                      for (
                        var p = 1;
                        p <= (_pageCount <= 5 ? _pageCount : 5);
                        p++
                      )
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                          child: OutlinedButton(
                            onPressed: () => _goToPage(p),
                            style: OutlinedButton.styleFrom(
                              backgroundColor: _currentPage == p
                                  ? const Color(0xFF2B3A66)
                                  : Colors.transparent,
                              foregroundColor: Colors.white,
                              side: const BorderSide(color: Color(0xFF2B3A66)),
                              minimumSize: const Size(36, 36),
                              padding: EdgeInsets.zero,
                            ),
                            child: Text(p.toString()),
                          ),
                        ),
                      const SizedBox(width: 8),
                      IconButton(
                        onPressed: _currentPage < _pageCount
                            ? () => _goToPage(_currentPage + 1)
                            : null,
                        icon: const Icon(Icons.chevron_right),
                        color: Colors.white70,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
