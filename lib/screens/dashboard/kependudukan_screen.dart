import 'package:flutter/material.dart';

class KependudukanScreen extends StatelessWidget {
  const KependudukanScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Kependudukan',
        style: Theme.of(context).textTheme.headlineMedium,
      ),
    );
  }
}
