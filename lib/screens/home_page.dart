import 'package:flutter/material.dart';
import 'package:jawarapintar/screens/pemasukan/pemasukan_tambah_screen.dart';
import 'package:jawarapintar/screens/pemasukan/tagih_iuran_screen.dart';
import 'package:jawarapintar/screens/pemasukan/tagihan_screen.dart';
import '../widgets/sidebar.dart';
import '../models/menu_item.dart';
import 'dashboard/keuangan_screen.dart';
import 'dashboard/kegiatan_screen.dart';
import 'dashboard/kependudukan_screen.dart';
import 'datawarga_rumah/warga_daftar_screen.dart';
import 'datawarga_rumah/warga_tambah_screen.dart';
import 'datawarga_rumah/keluarga_screen.dart';
import 'datawarga_rumah/rumah_daftar_screen.dart';
import 'datawarga_rumah/rumah_tambah_screen.dart';
import '../widgets/main_content.dart';
import 'pemasukan/kategori_iuran_screen.dart';
import 'pengeluaran/pengeluaran_screen.dart';
import 'laporan_keuangan/laporan_keuangan_screen.dart';
import 'kegiatan_broadcast/kegiatan_broadcast_screen.dart';
import 'pesan_warga/pesan_warga_screen.dart';
import 'penerimaan_warga/penerimaan_warga_screen.dart';
import 'mutasi_keluarga/mutasi_keluarga_screen.dart';
import 'log_aktifitas/log_aktifitas_screen.dart';
import 'pemasukan/pemasukan_daftar_screen.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _isSidebarMinimized = false;
  String _selectedPrimaryItem = primaryMenuItems.first.title;
  String? _selectedSubItem = primaryMenuItems.first.subItems?.first;

  void _toggleSidebar() {
    setState(() {
      _isSidebarMinimized = !_isSidebarMinimized;
    });
  }

  void _selectMenuItem(String primaryTitle, String? subTitle) {
    setState(() {
      _selectedPrimaryItem = primaryTitle;
      _selectedSubItem = subTitle;
    });
    // Gunakan debugPrint untuk logging selama development
    debugPrint(
      'Menu Dipilih: $primaryTitle${subTitle != null ? ' > $subTitle' : ''}',
    );
  }

  @override
  Widget build(BuildContext context) {
    const Color appBgColor = Color(0xFFF7F7F7);

    return Scaffold(
      backgroundColor: appBgColor,
      body: Row(
        children: <Widget>[
          CustomSidebar(
            onToggleMinimize: _toggleSidebar,
            isMinimized: _isSidebarMinimized,
            selectedPrimaryItem: _selectedPrimaryItem,
            selectedSubItem: _selectedSubItem ?? '',
            onSelect: _selectMenuItem,
          ),

          const VerticalDivider(
            width: 1,
            thickness: 1,
            color: Color(0xFFCCCCCC),
          ),

          // Konten utama: pilih screen berdasarkan submenu yang dipilih
          Expanded(
            child: Builder(
              builder: (context) {
                // Dashboard screens
                if (_selectedPrimaryItem == 'Dashboard') {
                  if (_selectedSubItem == 'Keuangan') {
                    return const KeuanganScreen();
                  }
                  if (_selectedSubItem == 'Kegiatan') {
                    return const KegiatanScreen();
                  }
                  if (_selectedSubItem == 'Kependudukan') {
                    return const KependudukanScreen();
                  }
                }
                // Data Warga & Rumah screens
                if (_selectedPrimaryItem == 'Data Warga & Rumah') {
                  if (_selectedSubItem == 'Warga - Daftar') {
                    return const WargaDaftarScreen();
                  }
                  if (_selectedSubItem == 'Warga - Tambah') {
                    return const WargaTambahScreen();
                  }
                  if (_selectedSubItem == 'Keluarga') {
                    return const KeluargaScreen();
                  }
                  if (_selectedSubItem == 'Rumah - Daftar') {
                    return const RumahDaftarScreen();
                  }
                  if (_selectedSubItem == 'Rumah - Tambah') {
                    return const RumahTambahScreen();
                  }
                }
                // Pemasukan screens
                if (_selectedPrimaryItem == 'Pemasukan') {
                  if (_selectedSubItem == 'Kategori Iuran') {
                    return const KategoriIuranScreen();
                  }
                  if (_selectedSubItem == 'Tagih Iuran') {
                    return const TagihIuranScreen();
                  }
                  if (_selectedSubItem == 'Tagihan') {
                    return const TagihanScreen();
                  }
                  if (_selectedSubItem == 'Pemasukan Lain - Daftar') {
                    return const PemasukanDaftarScreen();
                  }
                  if (_selectedSubItem == 'Pemasukan Lain - Tambah') {
                    return const PemasukanTambahScreen();
                  }
                }
                // Pengeluaran screens
                if (_selectedPrimaryItem == 'Pengeluaran') {
                  return const PengeluaranScreen();
                }
                // Laporan Keuangan screens
                if (_selectedPrimaryItem == 'Laporan Keuangan') {
                  return const LaporanKeuanganScreen();
                }
                // Kegiatan & Broadcast screens
                if (_selectedPrimaryItem == 'Kegiatan & Broadcast') {
                  return const KegiatanBroadcastScreen();
                }
                // Pesan Warga screens
                if (_selectedPrimaryItem == 'Pesan Warga') {
                  return const PesanWargaScreen();
                }
                // Penerimaan Warga screens
                if (_selectedPrimaryItem == 'Penerimaan Warga') {
                  return const PenerimaanWargaScreen();
                }
                // Mutasi Keluarga screens
                if (_selectedPrimaryItem == 'Mutasi Keluarga') {
                  return const MutasiKeluargaScreen();
                }
                // Log Aktifitas screens
                if (_selectedPrimaryItem == 'Log Aktifitas') {
                  return const LogAktifitasScreen();
                }
                // Default fallback
                return MainContent(
                  selectedPrimaryItem: _selectedPrimaryItem,
                  selectedSubItem: _selectedSubItem,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
