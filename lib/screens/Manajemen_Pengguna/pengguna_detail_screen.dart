import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'edit_pengguna_screen.dart';

class PenggunaDetailScreen extends StatelessWidget {
  final Map<String, String> pengguna;
  const PenggunaDetailScreen({super.key, required this.pengguna});

  String _initials(String name) {
    final parts = name.trim().split(' ');
    if (parts.isEmpty) return '';
    if (parts.length == 1) return parts.first.substring(0, 1).toUpperCase();
    return (parts.first.substring(0, 1) + parts.last.substring(0, 1))
        .toUpperCase();
  }

  void _copy(BuildContext ctx, String text, String label) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(
      ctx,
    ).showSnackBar(SnackBar(content: Text('$label disalin')));
  }

  @override
  Widget build(BuildContext context) {
    final name = pengguna['nama'] ?? '-';
    final no = pengguna['no'] ?? '-';
    final email = pengguna['email'] ?? '-';
    final phone = pengguna['noHp'] ?? '-';
    final role = pengguna['role'] ?? '-';
    final status = pengguna['status'] ?? '-';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Pengguna'),
        actions: [
          IconButton(
            tooltip: 'Edit',
            icon: const Icon(Icons.edit),
            onPressed: () async {
              // open editor and expect a Map<String,String> back
              final res = await Navigator.of(context).push<Map<String, String>>(
                MaterialPageRoute(
                  builder: (_) => EditPenggunaScreen(pengguna: pengguna),
                ),
              );
              if (res != null) {
                // signal caller that something changed so it can refresh
                Navigator.of(context).pop(true);
              }
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 36,
                    backgroundColor: Theme.of(
                      context,
                    ).colorScheme.primary.withOpacity(0.12),
                    child: Text(
                      _initials(name),
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(email, style: TextStyle(color: Colors.grey[700])),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 8,
                          runSpacing: 6,
                          children: [
                            Chip(
                              label: Text(role),
                              avatar: const Icon(
                                Icons.account_circle,
                                size: 18,
                              ),
                              backgroundColor: Colors.blue.shade50,
                            ),
                            Chip(
                              label: Text(status),
                              avatar: const Icon(Icons.info_outline, size: 18),
                              backgroundColor:
                                  status.toLowerCase() == 'diterima'
                                  ? Colors.green.shade50
                                  : (status.toLowerCase() == 'pending'
                                        ? Colors.orange.shade50
                                        : Colors.red.shade50),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          _buildDetailRow(context, 'NO', no),
          const Divider(),
          _buildDetailRow(context, 'Nama', name),
          const Divider(),
          _buildDetailRowWithAction(
            context,
            'Email',
            email,
            actionIcon: Icons.copy,
            onAction: () => _copy(context, email, 'Email'),
          ),
          const Divider(),
          _buildDetailRowWithAction(
            context,
            'No HP',
            phone.isEmpty ? '-' : phone,
            actionIcon: Icons.copy,
            onAction: () => _copy(context, phone, 'No HP'),
          ),
          const Divider(),
          const SizedBox(height: 8),
          ElevatedButton.icon(
            onPressed: () {
              // quick action: start editing
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => EditPenggunaScreen(pengguna: pengguna),
                ),
              );
            },
            icon: const Icon(Icons.edit),
            label: const Text('Edit Pengguna'),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 12),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(BuildContext ctx, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 2),
      child: Row(
        children: [
          SizedBox(
            width: 110,
            child: Text(label, style: TextStyle(color: Colors.grey[600])),
          ),
          Expanded(child: Text(value, style: const TextStyle(fontSize: 16))),
        ],
      ),
    );
  }

  Widget _buildDetailRowWithAction(
    BuildContext ctx,
    String label,
    String value, {
    required IconData actionIcon,
    required VoidCallback onAction,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 2),
      child: Row(
        children: [
          SizedBox(
            width: 110,
            child: Text(label, style: TextStyle(color: Colors.grey[600])),
          ),
          Expanded(child: Text(value, style: const TextStyle(fontSize: 16))),
          IconButton(
            tooltip: 'Salin',
            onPressed: onAction,
            icon: Icon(actionIcon, size: 20, color: Colors.grey[700]),
          ),
        ],
      ),
    );
  }
}
