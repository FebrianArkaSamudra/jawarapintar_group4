import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CetakLaporan extends StatefulWidget {
  const CetakLaporan({super.key});

  @override
  State<CetakLaporan> createState() => _CetakLaporanState();
}

class _CetakLaporanState extends State<CetakLaporan> {
  DateTime? startDate;
  DateTime? endDate;
  String? selectedJenis = 'Semua';

  final List<String> jenisLaporan = ['Semua', 'Pemasukan', 'Pengeluaran'];

  final dateFormat = DateFormat('dd/MM/yyyy');

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );

    if (picked != null) {
      setState(() {
        if (isStartDate) {
          startDate = picked;
        } else {
          endDate = picked;
        }
      });
    }
  }

  void _resetForm() {
    setState(() {
      startDate = null;
      endDate = null;
      selectedJenis = 'Semua';
    });
  }

  void _downloadPDF() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('PDF berhasil diunduh (simulasi)')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isMobile = MediaQuery.of(context).size.width < 600;
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Center(
            child: Container(
              width: double.infinity,
              constraints: const BoxConstraints(maxWidth: 1200),
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Cetak Laporan Keuangan",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 24),

                  // Tanggal mulai & akhir: tampilkan sebagai Row di desktop, Column di mobile
                  if (!isMobile)
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Tanggal Mulai"),
                              const SizedBox(height: 8),
                              TextFormField(
                                readOnly: true,
                                decoration: InputDecoration(
                                  hintText: "--/--/----",
                                  suffixIcon: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      if (startDate != null)
                                        IconButton(
                                          icon: const Icon(Icons.clear),
                                          onPressed: () =>
                                              setState(() => startDate = null),
                                        ),
                                      IconButton(
                                        icon: const Icon(
                                          Icons.calendar_today_outlined,
                                        ),
                                        onPressed: () =>
                                            _selectDate(context, true),
                                      ),
                                    ],
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                controller: TextEditingController(
                                  text: startDate != null
                                      ? dateFormat.format(startDate!)
                                      : '',
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 24),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Tanggal Akhir"),
                              const SizedBox(height: 8),
                              TextFormField(
                                readOnly: true,
                                decoration: InputDecoration(
                                  hintText: "--/--/----",
                                  suffixIcon: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      if (endDate != null)
                                        IconButton(
                                          icon: const Icon(Icons.clear),
                                          onPressed: () =>
                                              setState(() => endDate = null),
                                        ),
                                      IconButton(
                                        icon: const Icon(
                                          Icons.calendar_today_outlined,
                                        ),
                                        onPressed: () =>
                                            _selectDate(context, false),
                                      ),
                                    ],
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                controller: TextEditingController(
                                  text: endDate != null
                                      ? dateFormat.format(endDate!)
                                      : '',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  else
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Tanggal Mulai"),
                        const SizedBox(height: 8),
                        TextFormField(
                          readOnly: true,
                          decoration: InputDecoration(
                            hintText: "--/--/----",
                            suffixIcon: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                if (startDate != null)
                                  IconButton(
                                    icon: const Icon(Icons.clear),
                                    onPressed: () =>
                                        setState(() => startDate = null),
                                  ),
                                IconButton(
                                  icon: const Icon(
                                    Icons.calendar_today_outlined,
                                  ),
                                  onPressed: () => _selectDate(context, true),
                                ),
                              ],
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          controller: TextEditingController(
                            text: startDate != null
                                ? dateFormat.format(startDate!)
                                : '',
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text("Tanggal Akhir"),
                        const SizedBox(height: 8),
                        TextFormField(
                          readOnly: true,
                          decoration: InputDecoration(
                            hintText: "--/--/----",
                            suffixIcon: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                if (endDate != null)
                                  IconButton(
                                    icon: const Icon(Icons.clear),
                                    onPressed: () =>
                                        setState(() => endDate = null),
                                  ),
                                IconButton(
                                  icon: const Icon(
                                    Icons.calendar_today_outlined,
                                  ),
                                  onPressed: () => _selectDate(context, false),
                                ),
                              ],
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          controller: TextEditingController(
                            text: endDate != null
                                ? dateFormat.format(endDate!)
                                : '',
                          ),
                        ),
                      ],
                    ),

                  const SizedBox(height: 24),

                  // Jenis Laporan
                  const Text("Jenis Laporan"),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<String>(
                    value: selectedJenis,
                    items: jenisLaporan.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (newValue) =>
                        setState(() => selectedJenis = newValue),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Tombol
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: _downloadPDF,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF6366F1),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 14,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          "Download PDF",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      OutlinedButton(
                        onPressed: _resetForm,
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 14,
                          ),
                        ),
                        child: const Text("Reset"),
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
