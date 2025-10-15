import 'package:flutter/material.dart';
import 'widgets/sidebar.dart'; // Import CustomSidebar
import 'models/menu_item.dart'; // Import Model Menu

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Status minimize/maximize dikelola di sini
  bool _isSidebarMinimized = false;

  // Status Menu yang sedang dipilih
  String _selectedPrimaryItem = primaryMenuItems.first.title;
  String? _selectedSubItem = primaryMenuItems.first.subItems?.first;

  void _toggleSidebar() {
    setState(() {
      _isSidebarMinimized = !_isSidebarMinimized;
    });
  }

  void _selectMenuItem(String primaryTitle, String? subTitle) {
    setState(() {
      _selectedPrimaryItem = primaryTitle;
      _selectedSubItem = subTitle;
    });
    // Logika Navigasi di sini (misalnya: Navigator.push atau mengganti konten utama)
    print('Menu Dipilih: $primaryTitle' + (subTitle != null ? ' > $subTitle' : ''));
  }

  @override
  Widget build(BuildContext context) {
    const Color appBgColor = Color(0xFFF7F7F7); 
    
    return Scaffold(
      backgroundColor: appBgColor,
      body: Row(
        children: <Widget>[
          // Widget Sidebar
          CustomSidebar(
            onToggleMinimize: _toggleSidebar,
            isMinimized: _isSidebarMinimized,
            selectedPrimaryItem: _selectedPrimaryItem,
            selectedSubItem: _selectedSubItem ?? '',
            onSelect: _selectMenuItem,
          ),
          
          const VerticalDivider(width: 1, thickness: 1, color: Color(0xFFCCCCCC)), 

          // Area Konten Utama
          Expanded(
            child: Container(
              color: appBgColor,
              padding: const EdgeInsets.all(32.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Konten untuk Halaman:',
                      style: TextStyle(fontSize: 18, color: Colors.grey.shade600),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _selectedSubItem != null 
                          ? '$_selectedPrimaryItem > $_selectedSubItem'
                          : _selectedPrimaryItem,
                      style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Color(0xFF3F6FAA)),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}