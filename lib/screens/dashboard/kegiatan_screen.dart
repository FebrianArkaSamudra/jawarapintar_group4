import 'package:flutter/material.dart';

class KegiatanScreen extends StatelessWidget {
  const KegiatanScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Kegiatan',
        style: Theme.of(context).textTheme.headlineMedium,
      ),
    );
  }
}
