import 'package:flutter/material.dart';

class WargaTambahScreen extends StatelessWidget {
  const WargaTambahScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Warga - Tambah',
        style: Theme.of(context).textTheme.headlineMedium,
      ),
    );
  }
}
