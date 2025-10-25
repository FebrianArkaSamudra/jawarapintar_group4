import 'package:flutter/material.dart';
import 'detail_page.dart';
import 'tambah.dart';

class Daftar extends StatelessWidget {
  const Daftar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F7),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: ExpenseList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Tambah()),
          );
        },
        backgroundColor: Theme.of(context).primaryColor,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class ExpenseList extends StatefulWidget {
  const ExpenseList({super.key});

  @override
  State<ExpenseList> createState() => _ExpenseListState();
}

class _ExpenseListState extends State<ExpenseList> {
  final ScrollController _scrollController = ScrollController();
  bool _isLoading = false;

  // Sample data - replace with actual data from your backend
  final List<Map<String, String>> _data = [
    {
      'no': '1',
      'nama': 'adsad',
      'jenis': 'Pemeliharaan Fasilitas',
      'tanggal': '02 Oktober 2025',
      'nominal': 'Rp 2.112,00',
    },
    {
      'no': '2',
      'nama': 'test',
      'jenis': 'Pemeliharaan Fasilitas',
      'tanggal': '03 Oktober 2025',
      'nominal': 'Rp 3.000,00',
    },
    {
      'no': '3',
      'nama': 'contoh',
      'jenis': 'Pemeliharaan Fasilitas',
      'tanggal': '04 Oktober 2025',
      'nominal': 'Rp 1.500,00',
    },
  ];

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent &&
        !_isLoading) {
      setState(() {
        _isLoading = true;
      });

      // Simulating data loading with delay
      Future.delayed(const Duration(milliseconds: 500), () {
        setState(() {
          _isLoading = false;
        });
      });
    }
  }

  void _showFilterDialog(BuildContext context) async {
    await showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        TextEditingController startDateController = TextEditingController();
        TextEditingController endDateController = TextEditingController();
        String? selectedCategory;

        return AlertDialog(
          title: const Text('Filter Pengeluaran'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Cari Pengeluaran',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    labelText: 'Kategori',
                    prefixIcon: Icon(Icons.category),
                    border: OutlineInputBorder(),
                  ),
                  value: selectedCategory,
                  items: const [
                    DropdownMenuItem(
                      value: 'Pemeliharaan',
                      child: Text('Pemeliharaan'),
                    ),
                    DropdownMenuItem(
                      value: 'Operasional',
                      child: Text('Operasional'),
                    ),
                  ],
                  onChanged: (value) => selectedCategory = value,
                ),
                const SizedBox(height: 16),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.date_range),
                  title: const Text('Rentang Tanggal'),
                  subtitle: Text(
                    startDateController.text.isEmpty
                        ? 'Pilih rentang tanggal'
                        : '${startDateController.text} - ${endDateController.text}',
                  ),
                  onTap: () async {
                    DateTimeRange? dateRange = await showDateRangePicker(
                      context: context,
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    );
                    if (dateRange != null) {
                      startDateController.text =
                          '${dateRange.start.day}/${dateRange.start.month}/${dateRange.start.year}';
                      endDateController.text =
                          '${dateRange.end.day}/${dateRange.end.month}/${dateRange.end.year}';
                    }
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Reset'),
            ),
            FilledButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Terapkan'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Search and Filter Bar
        Container(
          margin: const EdgeInsets.only(bottom: 16),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Cari pengeluaran...',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              IconButton.filled(
                onPressed: () => _showFilterDialog(context),
                icon: const Icon(Icons.tune),
                style: IconButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ),
        ),
        
        // List Content
        Expanded(
          child: ListView.builder(
            controller: _scrollController,
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            itemCount: _data.length + (_isLoading ? 1 : 0),
            itemBuilder: (context, index) {
              if (index == _data.length) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: CircularProgressIndicator(),
                  ),
                );
              }

              final item = _data[index];
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailPage(item: item),
                      ),
                    );
                  },
                  borderRadius: BorderRadius.circular(12),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                item['tanggal']!,
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ),
                            Text(
                              item['nominal']!,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).primaryColor,
                                  ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          item['nama']!,
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    fontWeight: FontWeight.w500,
                                  ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          item['jenis']!,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(color: Colors.grey[600]),
                        ),
                        const SizedBox(height: 8),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton.icon(
                            style: TextButton.styleFrom(
                              foregroundColor: Theme.of(context).primaryColor,
                            ),
                            icon:
                                const Icon(Icons.visibility_outlined, size: 20),
                            label: const Text('Detail'),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      DetailPage(item: item),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}