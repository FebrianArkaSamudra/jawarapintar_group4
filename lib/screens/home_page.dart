import 'package:flutter/material.dart';
import '../widgets/sidebar.dart';
import '../models/menu_item.dart';
import '../models/pengguna_repo.dart';
import 'dashboard/keuangan_screen.dart';
import 'dashboard/kegiatan_screen.dart';
import 'dashboard/kependudukan_screen.dart';
import 'datawarga_rumah/warga_daftar_screen.dart';
import 'datawarga_rumah/warga_tambah_screen.dart';
import 'datawarga_rumah/keluarga_screen.dart';
import 'datawarga_rumah/rumah_daftar_screen.dart';
import 'datawarga_rumah/rumah_tambah_screen.dart';
import '../widgets/main_content.dart';
import 'pemasukan/pemasukan_screen.dart';
import 'pengeluaran/daftar.dart';
import 'pengeluaran/tambah.dart';
import 'laporan_keuangan/laporan_keuangan_screen.dart';
import 'kegiatan_broadcast/kegiatan_broadcast_screen.dart';
import 'pesan_warga/pesan_warga_screen.dart';
import 'penerimaan_warga/penerimaan_warga_screen.dart';
import 'mutasi_keluarga/mutasi_keluarga_daftar.dart';
import 'mutasi_keluarga/mutasi_keluarga_tambah.dart';
import 'log_aktifitas/log_aktifitas_screen.dart';
import 'Manajemen_Pengguna/daftar_pengguna.dart';
import 'Manajemen_Pengguna/edit_pengguna_screen.dart';
import 'Manajemen_Pengguna/tambah_pengguna_screen.dart';
import '../models/pengguna.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _isSidebarMinimized = false;
  String _selectedPrimaryItem = primaryMenuItems.first.title;
  String? _selectedSubItem = primaryMenuItems.first.subItems?.first;

  @override
  void initState() {
    super.initState();
    // initialize repository (loads persisted users if any)
    PenggunaRepo.init().then((_) => setState(() {}));
  }

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

          Expanded(
            child: Builder(
              builder: (context) {
                // Dashboard screens
                if (_selectedPrimaryItem == 'Dashboard') {
                  if (_selectedSubItem == 'Keuangan')
                    return const KeuanganScreen();
                  if (_selectedSubItem == 'Kegiatan')
                    return const KegiatanScreen();
                  if (_selectedSubItem == 'Kependudukan')
                    return const KependudukanScreen();
                }

                // Data Warga & Rumah screens
                if (_selectedPrimaryItem == 'Data Warga & Rumah') {
                  if (_selectedSubItem == 'Warga - Daftar')
                    return const WargaDaftarScreen();
                  if (_selectedSubItem == 'Warga - Tambah')
                    return const WargaTambahScreen();
                  if (_selectedSubItem == 'Keluarga')
                    return const KeluargaScreen();
                  if (_selectedSubItem == 'Rumah - Daftar')
                    return const RumahDaftarScreen();
                  if (_selectedSubItem == 'Rumah - Tambah')
                    return const RumahTambahScreen();
                }

                // Pemasukan / Pengeluaran / Laporan etc.
                if (_selectedPrimaryItem == 'Pemasukan')
                  return const PemasukanScreen();
                if (_selectedPrimaryItem == 'Pengeluaran') {
                  if (_selectedSubItem == 'Daftar') return const Daftar();
                  if (_selectedSubItem == 'Tambah') return const Tambah();
                }
                if (_selectedPrimaryItem == 'Laporan Keuangan')
                  return const LaporanKeuanganScreen();
                if (_selectedPrimaryItem == 'Kegiatan & Broadcast')
                  return const KegiatanBroadcastScreen();
                if (_selectedPrimaryItem == 'Pesan Warga')
                  return const PesanWargaScreen();
                if (_selectedPrimaryItem == 'Penerimaan Warga')
                  return const PenerimaanWargaScreen();
                if (_selectedPrimaryItem == 'Mutasi Keluarga') {
                  if (_selectedSubItem == 'Daftar') {
                    return const MutasiKeluargaDaftar();
                  }
                  if (_selectedSubItem == 'Tambah') {
                    return const MutasiKeluargaTambah();
                  }
                }
                if (_selectedPrimaryItem == 'Log Aktifitas')
                  return const LogAktifitasScreen();

                // Manajemen Pengguna: subpages rendered in main area
                if (_selectedPrimaryItem == 'Manajemen Pengguna') {
                  if (_selectedSubItem == 'Daftar Pengguna') {
                    return const RegistrasiPage();
                  }
                  if (_selectedSubItem == 'Tambah Pengguna') {
                    return TambahPenggunaScreen(
                      onUserAdded: (newUser) async {
                        await PenggunaRepo.add(newUser);
                        setState(() {
                          _selectedSubItem = 'Daftar Pengguna';
                        });
                      },
                    );
                  }
                  if (_selectedSubItem == 'Edit Pengguna') {
                    // RegistrasiPage handles navigation to Edit with data via popup/route.
                    return const RegistrasiPage();
                  }
                }

                // Default content
                // Pemasukan screens
                if (_selectedPrimaryItem == 'Pemasukan') {
                  return const PemasukanScreen();
                }
                // Pengeluaran screens
                if (_selectedPrimaryItem == 'Pengeluaran') {
                  if (_selectedSubItem == 'Daftar') {
                    return const Daftar();
                  }
                  if (_selectedSubItem == 'Tambah') {
                    return const Tambah();
                  }
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
                  if (_selectedSubItem == 'Daftar') {
                    return const MutasiKeluargaDaftar();
                  }
                  if (_selectedSubItem == 'Tambah') {
                    return const MutasiKeluargaTambah();
                  }
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
