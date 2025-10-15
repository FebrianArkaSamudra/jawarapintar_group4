import 'package:flutter/material.dart';

class MenuItem {
  final String title;
  final IconData icon;
  final List<String>? subItems; // Submenu (jika ada)

  const MenuItem({
    required this.title,
    required this.icon,
    this.subItems,
  });
}

// Data statis menu
final List<MenuItem> primaryMenuItems = [
  const MenuItem(
    title: 'Dashboard',
    icon: Icons.dashboard_outlined,
    subItems: ['Keuangan', 'Kegiatan', 'Kependudukan'],
  ),
  const MenuItem(title: 'Data Warga & Rumah', icon: Icons.groups_outlined),
  const MenuItem(title: 'Pemasukan', icon: Icons.archive_outlined),
  const MenuItem(title: 'Pengeluaran', icon: Icons.upload_outlined),
  const MenuItem(title: 'Laporan Keuangan', icon: Icons.analytics_outlined),
  const MenuItem(title: 'Kegiatan & Broadcast', icon: Icons.calendar_today_outlined),
  const MenuItem(title: 'Pesan Warga', icon: Icons.people_alt_outlined),
  const MenuItem(title: 'Penerimaan Warga', icon: Icons.people_outline),
  const MenuItem(title: 'Mutasi Keluarga', icon: Icons.group_add_outlined),
  const MenuItem(title: 'Log Aktifitas', icon: Icons.watch_later_outlined),
  const MenuItem(title: 'Manajemen Pengguna', icon: Icons.manage_accounts_outlined),
  const MenuItem(title: 'Channel Transfer', icon: Icons.compare_arrows_outlined),
];