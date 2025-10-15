import 'package:flutter/material.dart';
import 'home_page.dart'; // Import halaman utama

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Warna utama aplikasi (biru tua)
    const primaryBlue = Color(0xFF3F6FAA);

    return MaterialApp(
      title: 'Jawara Pintar',
      debugShowCheckedModeBanner: false, // Sembunyikan banner debug
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: primaryBlue,
          brightness: Brightness.light,
          primary: primaryBlue, // Terapkan warna utama
        ),
        useMaterial3: true,
        fontFamily: 'Poppins',
        // Tambahkan sentuhan visual untuk ListTile (mempengaruhi SubSidebarItem)
        listTileTheme: ListTileThemeData(
          iconColor: primaryBlue,
        ),
      ),
      home: const MyHomePage(),
    );
  }
}