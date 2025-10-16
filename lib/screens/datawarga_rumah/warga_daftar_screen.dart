import 'package:flutter/material.dart';

class WargaDaftarScreen extends StatelessWidget {
  const WargaDaftarScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Warga - Daftar',
        style: Theme.of(context).textTheme.headlineMedium,
      ),
    );
  }
}
