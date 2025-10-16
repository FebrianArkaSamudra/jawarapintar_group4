import 'package:flutter/material.dart';

class KeluargaScreen extends StatelessWidget {
  const KeluargaScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Keluarga',
        style: Theme.of(context).textTheme.headlineMedium,
      ),
    );
  }
}
