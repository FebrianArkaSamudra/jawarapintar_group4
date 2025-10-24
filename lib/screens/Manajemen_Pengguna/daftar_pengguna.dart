import 'package:flutter/material.dart';
import '../../models/pengguna_repo.dart';
import 'tambah_pengguna_screen.dart';
import 'edit_pengguna_screen.dart';
import 'pengguna_detail_screen.dart';

class RegistrasiPage extends StatefulWidget {
  const RegistrasiPage({super.key});

  @override
  State<RegistrasiPage> createState() => _RegistrasiPageState();
}

class _RegistrasiPageState extends State<RegistrasiPage> {
  List<Map<String, String>> _users = [];
  bool _loading = true;
  final TextEditingController _namaController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() => _loading = true);
    final List<Map<String, String>> converted = [];

    try {
      // try init if repo has it (ignore if not)
      try {
        await PenggunaRepo.init();
      } catch (_) {}

      dynamic items;
      // call getAll safely whether it returns Future or plain
      try {
        final maybe = PenggunaRepo.getAll();
        if (maybe is Future) {
          items = await maybe;
        } else {
          items = maybe;
        }
      } catch (_) {
        items = null;
      }

      if (items != null) {
        if (items is Iterable) {
          for (final it in items) {
            if (it is Map) {
              final Map<String, String> m = {};
              for (final entry in it.entries) {
                m[entry.key.toString()] = entry.value?.toString() ?? '';
              }
              converted.add(m);
            } else {
              converted.add({'value': it?.toString() ?? ''});
            }
          }
        } else if (items is Map) {
          for (final entry in items.entries) {
            final v = entry.value;
            if (v is Map) {
              final Map<String, String> m = {};
              for (final e in v.entries) {
                m[e.key.toString()] = e.value?.toString() ?? '';
              }
              m['no'] = entry.key.toString();
              converted.add(m);
            } else {
              converted.add({
                'no': entry.key.toString(),
                'value': v?.toString() ?? '',
              });
            }
          }
        } else {
          converted.add({'value': items?.toString() ?? ''});
        }
      }

      setState(() {
        _users = converted;
        _loading = false;
      });
    } catch (_) {
      // fallback sample data
      setState(() {
        _users = [
          {
            'no': '1',
            'nama': 'Hammam Abdullah',
            'email': 'Hammam@gmail.com',
            'noHp': '081234251261',
            'role': 'Admin',
            'status': 'Diterima',
          },
          {
            'no': '2',
            'nama': 'Arka love',
            'email': 'arka@gmail.com',
            'noHp': '081298763332',
            'role': 'Warga',
            'status': 'Diterima',
          },
          {
            'no': '3',
            'nama': 'baihaqi',
            'email': 'yuma@gmail.com',
            'noHp': '081298769999',
            'role': 'Warga',
            'status': 'Diterima',
          },
        ];
        _loading = false;
      });
    }
  }

  Future<void> _openTambah() async {
    final res = await Navigator.push<Map<String, String>>(
      context,
      MaterialPageRoute(
        builder: (_) => TambahPenggunaScreen(
          onUserAdded: (u) async {
            // Handle callback if needed
            return;
          },
        ),
      ),
    );
    if (res != null) {
      // try persist via repo if available
      try {
        await PenggunaRepo.add(res);
      } catch (_) {}
      setState(() => _users.insert(0, res));
    }
    return; // Add explicit return statement
  }

  void _openFilterDialog() {
    // Implement filter dialog
  }

  List<Map<String, String>> _filteredUsers() {
    final query = _namaController.text.toLowerCase();
    return _users.where((user) {
      final namaMatches = user['nama']?.toLowerCase().contains(query) ?? false;
      final emailMatches =
          user['email']?.toLowerCase().contains(query) ?? false;
      return namaMatches || emailMatches;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _filteredUsers();
    final theme = Theme.of(context);

    if (_loading) return const Center(child: CircularProgressIndicator());
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Search & Filter Bar
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: TextField(
                controller: _namaController,
                onChanged: (_) => setState(() {}),
                decoration: InputDecoration(
                  hintText: 'Cari pengguna...',
                  prefixIcon: const Icon(Icons.search, color: Colors.grey),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.filter_list),
                    onPressed: _openFilterDialog,
                    color: theme.primaryColor,
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Users List
            Expanded(
              child: ListView.builder(
                itemCount: filtered.length,
                itemBuilder: (context, index) {
                  final user = filtered[index];
                  final name = user['nama'] ?? '';
                  final initial = name.isNotEmpty ? name[0].toUpperCase() : '?';
                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      leading: CircleAvatar(
                        backgroundColor: theme.primaryColor.withOpacity(0.1),
                        child: Text(
                          initial,
                          style: TextStyle(
                            color: theme.primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      title: Text(
                        user['nama'] ?? '',
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 4),
                          Text(user['email'] ?? ''),
                          const SizedBox(height: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: _getStatusColor(user['status']),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              user['status'] ?? '',
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      trailing: PopupMenuButton<String>(
                        icon: const Icon(Icons.more_vert),
                        onSelected: (value) async {
                          if (value == 'detail') {
                            await Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) =>
                                    PenggunaDetailScreen(pengguna: user),
                              ),
                            );
                            // reload in case detail changed via edit inside detail screen
                            await _load();
                          } else if (value == 'edit') {
                            // expect Map<String,String> back from EditPenggunaScreen
                            final res = await Navigator.of(context)
                                .push<Map<String, String>>(
                                  MaterialPageRoute(
                                    builder: (_) =>
                                        EditPenggunaScreen(pengguna: user),
                                  ),
                                );
                            if (res != null) {
                              // try persist via repo if available (safe wrapped)
                              try {
                                await PenggunaRepo.add(res);
                              } catch (_) {}
                              setState(() => _users[index] = res);
                            }
                          }
                        },
                        itemBuilder: (context) => [
                          PopupMenuItem(
                            value: 'detail',
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: const [
                                Icon(Icons.visibility_outlined),
                                SizedBox(width: 8),
                                Text('Lihat Detail'),
                              ],
                            ),
                          ),
                          PopupMenuItem(
                            value: 'edit',
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: const [
                                Icon(Icons.edit_outlined),
                                SizedBox(width: 8),
                                Text('Edit'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(String? status) {
    switch (status?.toLowerCase()) {
      case 'diterima':
        return Colors.blue;
      case 'pending':
        return Colors.orange;
      case 'ditolak':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
