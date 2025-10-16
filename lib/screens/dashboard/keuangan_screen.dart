import 'package:flutter/material.dart';

class KeuanganScreen extends StatelessWidget {
  const KeuanganScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Keuangan',
        style: Theme.of(context).textTheme.headlineMedium,
      ),
    );
  }
}
