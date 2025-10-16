import 'package:flutter/material.dart';

class RumahDaftarScreen extends StatelessWidget {
  const RumahDaftarScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Rumah - Daftar',
        style: Theme.of(context).textTheme.headlineMedium,
      ),
    );
  }
}
