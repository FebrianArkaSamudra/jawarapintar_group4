import 'dart:io';
import 'package:flutter/material.dart';
import 'tambahChannel.dart';

class DaftarChannelPage extends StatelessWidget {
  const DaftarChannelPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Channel Transfer > Daftar Channel',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2B3674),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton.icon(
                  icon: const Icon(Icons.add),
                  label: const Text('Tambah Channel'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4318FF),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                  ),
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const TambahChannelPage(),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const ChannelListSection(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChannelListSection extends StatefulWidget {
  const ChannelListSection({Key? key}) : super(key: key);

  @override
  State<ChannelListSection> createState() => _ChannelListSectionState();
}

class _ChannelListSectionState extends State<ChannelListSection> {
  final List<Map<String, String>> _channels = [
    {
      'name': 'Bank BCA',
      'type': 'Bank',
      'owner': 'Bendahara RT',
      'account': '1234567890',
      'desc': 'Rekening utama RT untuk iuran warga',
      'status': 'Aktif',
    },
    {
      'name': 'Bank Mandiri',
      'type': 'Bank',
      'owner': 'Kas RT',
      'account': '0987654321',
      'desc': 'Rekening cadangan RT',
      'status': 'Aktif',
    },
    {
      'name': 'DANA',
      'type': 'E-Wallet',
      'owner': 'Bendahara RT',
      'account': '081234567890',
      'desc': 'E-wallet untuk pembayaran digital',
      'status': 'Aktif',
    },
    {
      'name': 'QRIS RT',
      'type': 'QRIS',
      'owner': 'Kas RT',
      'account': 'ID10002',
      'desc': 'Pembayaran menggunakan scan QR',
      'status': 'Aktif',
    },
    {
      'name': 'GoPay',
      'type': 'E-Wallet',
      'owner': 'Bendahara RT',
      'account': '085678901234',
      'desc': 'E-wallet alternatif',
      'status': 'Non-Aktif',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: _channels.length,
      separatorBuilder: (_, __) => const Divider(height: 1),
      itemBuilder: (context, index) {
        final channel = _channels[index];
        return ListTile(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          leading: CircleAvatar(
            backgroundColor: const Color(0xFFE9EDF7),
            child: Icon(
              _getChannelIcon(channel['type'] ?? ''),
              color: const Color(0xFF4318FF),
            ),
          ),
          title: Text(
            channel['name'] ?? '',
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: Color(0xFF2B3674),
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 4),
              Text(
                '${channel['owner']} • ${channel['account']}',
                style: TextStyle(color: Colors.grey[600]),
              ),
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: channel['status'] == 'Aktif'
                      ? const Color(0xFFE6EED6)
                      : const Color(0xFFFFE7E7),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  channel['status'] ?? '',
                  style: TextStyle(
                    fontSize: 12,
                    color: channel['status'] == 'Aktif'
                        ? const Color(0xFF519C2F)
                        : const Color(0xFFCC3535),
                  ),
                ),
              ),
            ],
          ),
          trailing: PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert, color: Color(0xFF2B3674)),
            onSelected: (value) => _handleMenuAction(value, channel, index),
            itemBuilder: (BuildContext context) => [
              const PopupMenuItem(value: 'detail', child: Text('Lihat Detail')),
              const PopupMenuItem(value: 'edit', child: Text('Edit')),
              const PopupMenuItem(
                value: 'delete',
                child: Text('Hapus', style: TextStyle(color: Colors.red)),
              ),
            ],
          ),
        );
      },
    );
  }

  IconData _getChannelIcon(String type) {
    switch (type) {
      case 'Bank':
        return Icons.account_balance;
      case 'E-Wallet':
        return Icons.account_balance_wallet;
      case 'QRIS':
        return Icons.qr_code;
      default:
        return Icons.payment;
    }
  }

  Future<void> _handleMenuAction(
    String action,
    Map<String, String> channel,
    int index,
  ) async {
    switch (action) {
      case 'detail':
        _showDetailDialog(channel);
        break;
      case 'edit':
        final result = await Navigator.push<Map<String, String>>(
          context,
          MaterialPageRoute(
            builder: (_) => TambahChannelPage(initialData: channel),
          ),
        );
        if (result != null) {
          setState(() => _channels[index] = result);
        }
        break;
      case 'delete':
        final confirm = await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Konfirmasi Hapus'),
            content: Text('Yakin ingin menghapus channel ${channel['name']}?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('Batal'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                child: const Text('Hapus', style: TextStyle(color: Colors.red)),
              ),
            ],
          ),
        );
        if (confirm == true) {
          setState(() => _channels.removeAt(index));
        }
        break;
    }
  }

  void _showDetailDialog(Map<String, String> channel) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(channel['name'] ?? ''),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _detailRow('Tipe', channel['type']),
            _detailRow('Pemilik', channel['owner']),
            _detailRow('Nomor Rekening/ID', channel['account']),
            _detailRow('Status', channel['status']),
            _detailRow('Keterangan', channel['desc']),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Tutup'),
          ),
        ],
      ),
    );
  }

  Widget _detailRow(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF2B3674),
            ),
          ),
          const SizedBox(height: 4),
          Text(value ?? '-'),
        ],
      ),
    );
  }
}
