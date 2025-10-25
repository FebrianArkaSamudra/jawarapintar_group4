import 'package:flutter/material.dart';
import 'informasi_penerimaan_warga_screen.dart';

class PenerimaanWargaScreen extends StatelessWidget {
  const PenerimaanWargaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color(0xFFF5F6F9),
        child: const InformasiPenerimaanWargaScreen(),
      ),
    );
  }
}
