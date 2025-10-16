import 'package:flutter/material.dart';

class RumahTambahScreen extends StatelessWidget {
  const RumahTambahScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Rumah - Tambah',
        style: Theme.of(context).textTheme.headlineMedium,
      ),
    );
  }
}
