import 'package:flutter/material.dart';
import 'edit_pengguna_screen.dart';
import '../../models/pengguna_repo.dart';

class RegistrasiPage extends StatefulWidget {
  const RegistrasiPage({super.key});

  @override
  State<RegistrasiPage> createState() => RegistrasiPageState();
}

class RegistrasiPageState extends State<RegistrasiPage> {
  final TextEditingController _namaController = TextEditingController();
  String? selectedStatus;

  List<Map<String, String>> _filteredUsers() {
    final all = PenggunaRepo.users;
    final q = _namaController.text.trim().toLowerCase();
    return all.where((row) {
      final nama = (row["nama"] ?? "").toLowerCase();
      final status = (row["status"] ?? "");
      final namaMatch = q.isEmpty || nama.contains(q);
      final statusMatch = selectedStatus == null || status == selectedStatus;
      return namaMatch && statusMatch;
    }).toList();
  }

  void _openFilterDialog() {
    showDialog(
      context: context,
      builder: (context) {
        final tmpName = TextEditingController(text: _namaController.text);
        String? tmpStatus = selectedStatus;
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Filter Manajemen Pengguna",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                const Text("Nama"),
                const SizedBox(height: 6),
                TextField(
                  controller: tmpName,
                  decoration: InputDecoration(
                    hintText: "Cari nama...",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                const Text("Status"),
                const SizedBox(height: 6),
                DropdownButtonFormField<String>(
                  value: tmpStatus ?? "",
                  items: const [
                    DropdownMenuItem(
                      value: "",
                      child: Text("-- Pilih Status --"),
                    ),
                    DropdownMenuItem(
                      value: "Diterima",
                      child: Text("Diterima"),
                    ),
                    DropdownMenuItem(value: "Pending", child: Text("Pending")),
                    DropdownMenuItem(value: "Ditolak", child: Text("Ditolak")),
                  ],
                  onChanged: (value) {
                    tmpStatus = (value != "" ? value : null);
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _namaController.text = tmpName.text;
                        selectedStatus = tmpStatus;
                      });
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6C63FF),
                    ),
                    child: const Text("Cari"),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _filteredUsers();

    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FB),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox.shrink(), // Add button is in sidebar
                ElevatedButton.icon(
                  onPressed: _openFilterDialog,
                  icon: const Icon(Icons.filter_list_alt, color: Colors.white),
                  label: const Text(""),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6C63FF),
                    padding: const EdgeInsets.all(12),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
              color: Colors.white,
              child: const Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Text(
                      "NO",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Text(
                      "NAMA",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Text(
                      "EMAIL",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Text(
                      "STATUS REGISTRASI",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      "AKSI",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),
            Expanded(
              child: ListView.builder(
                itemCount: filtered.length,
                itemBuilder: (context, index) {
                  final row = filtered[index];
                  return Column(
                    children: [
                      Container(
                        color: index == 0
                            ? Colors.grey.shade100
                            : Colors.transparent,
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 20,
                        ),
                        child: Row(
                          children: [
                            Expanded(flex: 1, child: Text(row["no"] ?? "")),
                            Expanded(flex: 3, child: Text(row["nama"] ?? "")),
                            Expanded(flex: 4, child: Text(row["email"] ?? "")),
                            Expanded(
                              flex: 3,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.green.shade100,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  row["status"] ?? "",
                                  style: const TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  PopupMenuButton<String>(
                                    onSelected: (value) async {
                                      if (value == 'detail') {
                                        Navigator.pushNamed(
                                          context,
                                          '/detailPage',
                                        );
                                      } else if (value == 'edit') {
                                        final res = await Navigator.push<bool>(
                                          context,
                                          MaterialPageRoute(
                                            builder: (ctx) =>
                                                EditPenggunaScreen(
                                                  pengguna: row,
                                                ),
                                          ),
                                        );
                                        if (res == true)
                                          setState(() {}); // refresh after edit
                                      }
                                    },
                                    itemBuilder: (context) => const [
                                      PopupMenuItem(
                                        value: 'detail',
                                        child: Text('Show Details'),
                                      ),
                                      PopupMenuItem(
                                        value: 'edit',
                                        child: Text('Edit'),
                                      ),
                                    ],
                                    child: const Icon(Icons.more_horiz),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Divider(height: 1),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
