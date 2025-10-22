import 'package:flutter/material.dart';

class MenuItem {
  final String title;
  final IconData icon;
  final List<String>? subItems; // Submenu (jika ada)

  const MenuItem({required this.title, required this.icon, this.subItems});
}

// Data statis menu
final List<MenuItem> primaryMenuItems = [
  const MenuItem(
    title: 'Dashboard',
    icon: Icons.dashboard_outlined,
    subItems: ['Keuangan', 'Kegiatan', 'Kependudukan'],
  ),
  const MenuItem(
    title: 'Data Warga & Rumah',
    icon: Icons.groups_outlined,
    subItems: [
      'Warga - Daftar',
      'Warga - Tambah',
      'Keluarga',
      'Rumah - Daftar',
      'Rumah - Tambah',
    ],
  ),
  const MenuItem(
    title: 'Pemasukan',
    icon: Icons.archive_outlined,
    subItems: [
      'Kategori Iuran',
      'Tagih Iuran',
      'Tagihan',
      'Pemasukan Lain - Daftar',
      'Pemasukan Lain - Tambah',
    ],
  ),
  const MenuItem(
    title: 'Pengeluaran',
    icon: Icons.upload_outlined,
    subItems: ['Daftar', 'Tambah'],
  ),
  const MenuItem(
    title: 'Laporan Keuangan',
    icon: Icons.analytics_outlined,
    subItems: ['Semua Pemasukan', 'Semua Pemasukan', 'Cetak laporan'],
  ),
  const MenuItem(
    title: 'Kegiatan & Broadcast',
    icon: Icons.calendar_today_outlined,
    subItems: [
      'Kegiatan - Daftar',
      'Kegiatan - Tambah',
      'Broadcast - Daftar',
      'Broadcast - Tambah',
    ],
  ),
  const MenuItem(
    title: 'Pesan Warga',
    icon: Icons.people_alt_outlined,
    subItems: ['Informasi Aspirasi'],
  ),
  const MenuItem(
    title: 'Penerimaan Warga',
    icon: Icons.people_outline,
    subItems: ['Penerimaan Warga'],
  ),
  const MenuItem(
    title: 'Mutasi Keluarga',
    icon: Icons.group_add_outlined,
    subItems: ['Daftar', 'Tambah'],
  ),
  const MenuItem(
    title: 'Log Aktifitas',
    icon: Icons.watch_later_outlined,
    subItems: ['Semua Aktifitas'],
  ),
  const MenuItem(
    title: 'Manajemen Pengguna',
    icon: Icons.manage_accounts_outlined,
    subItems: ['Daftar Pengguna', 'Tambah Pengguna'],
  ),
  const MenuItem(
    title: 'Channel Transfer',
    icon: Icons.compare_arrows_outlined,
    subItems: ['Daftar Channel', 'Tambah Channel'],
  ),
];
