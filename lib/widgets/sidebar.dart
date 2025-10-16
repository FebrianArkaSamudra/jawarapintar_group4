import 'package:flutter/material.dart';
import '../models/menu_item.dart';

// --- WIDGET SUBMENU ---
class SubSidebarItem extends StatelessWidget {
  final String title;
  final bool isSelected;
  final bool isMinimized;
  final VoidCallback onTap;

  const SubSidebarItem({
    super.key,
    required this.title,
    required this.onTap,
    this.isSelected = false,
    this.isMinimized = false,
  });

  @override
  Widget build(BuildContext context) {
    if (isMinimized) {
      return const SizedBox.shrink(); // Sembunyikan saat minimize
    }

    final mainColor = Theme.of(context).colorScheme.primary;
    final selectedBarColor = mainColor;
    final selectedTextColor =
        mainColor; // show primary color for selected subitem
    final unselectedColor = const Color(0xFF5C7E9D);

    return Padding(
      padding: const EdgeInsets.only(left: 8.0, bottom: 4.0),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Garis vertikal tipis seperti di desain
            Container(
              width: 2,
              height: 36,
              margin: const EdgeInsets.only(right: 12, left: 8),
              decoration: BoxDecoration(
                color: isSelected ? selectedBarColor : const Color(0xFFDCE7EE),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  title,
                  style: TextStyle(
                    color: isSelected ? selectedTextColor : unselectedColor,
                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// --- WIDGET ITEM MENU UTAMA ---
class SidebarItem extends StatelessWidget {
  final MenuItem item;
  final bool isSelected;
  final bool isMinimized;
  final VoidCallback onTap;

  const SidebarItem({
    super.key,
    required this.item,
    required this.onTap,
    this.isSelected = false,
    this.isMinimized = false,
  });

  @override
  Widget build(BuildContext context) {
    final selectedColor = Theme.of(context).colorScheme.primary;
    final unselectedColor = const Color(0xFF5C7E9D);
    final iconColor = isSelected ? selectedColor : unselectedColor;

    // Tampilan hanya ikon saat minimize
    if (isMinimized) {
      return InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
          child: Icon(item.icon, color: iconColor, size: 24),
        ),
      );
    }

    // Tampilan menu diperluas (tidak ada ExpansionTile di sini)
    return ListTile(
      contentPadding: const EdgeInsets.fromLTRB(16.0, 5.0, 16.0, 5.0),
      tileColor: isSelected
          ? const Color(0xFFE5F1FF)
          : null, // Warna latar belakang saat aktif
      hoverColor: isSelected
          ? const Color(0xFFE5F1FF)
          : Colors.blueGrey.withAlpha((0.05 * 255).round()),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      leading: isSelected
          ? Container(
              // Garis Biru Vertikal di kiri
              width: 4,
              height: 40,
              decoration: BoxDecoration(
                color: selectedColor,
                borderRadius: BorderRadius.circular(2),
              ),
            )
          : const SizedBox(width: 4), // Placeholder agar ikon sejajar
      title: Row(
        children: [
          Icon(item.icon, color: iconColor, size: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              item.title,
              style: TextStyle(
                color: iconColor,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                fontSize: 14,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
      onTap: onTap,
    );
  }
}

// --- WIDGET SIDEBAR UTAMA ---
class CustomSidebar extends StatefulWidget {
  final VoidCallback onToggleMinimize;
  final bool isMinimized;
  final String selectedPrimaryItem;
  final String selectedSubItem;
  final Function(String, String?) onSelect;

  const CustomSidebar({
    super.key,
    required this.onToggleMinimize,
    required this.isMinimized,
    required this.selectedPrimaryItem,
    required this.selectedSubItem,
    required this.onSelect,
  });

  @override
  State<CustomSidebar> createState() => _CustomSidebarState();
}

class _CustomSidebarState extends State<CustomSidebar> {
  static const double maxSidebarWidth = 280; // Diperluas sedikit
  static const double minSidebarWidth = 72;

  double get currentWidth =>
      widget.isMinimized ? minSidebarWidth : maxSidebarWidth;

  @override
  Widget build(BuildContext context) {
    const Color sidebarBgColor = Colors.white;
    final mainColor = Theme.of(context).colorScheme.primary;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: currentWidth,
      color: sidebarBgColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Header: Judul Aplikasi dan Ikon Toggle
          Padding(
            padding: EdgeInsets.fromLTRB(
              16,
              24,
              widget.isMinimized ? 16 : 8,
              24,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (!widget.isMinimized)
                  Row(
                    children: [
                      Icon(Icons.menu_book, color: mainColor, size: 28),
                      const SizedBox(width: 8),
                      Text(
                        'Jawara Pintar',
                        style: TextStyle(
                          color: mainColor,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  )
                else
                  Icon(Icons.menu_book, color: mainColor, size: 28),

                // Ikon Toggle
                InkWell(
                  onTap: widget.onToggleMinimize,
                  borderRadius: BorderRadius.circular(50),
                  child: Padding(
                    padding: widget.isMinimized
                        ? EdgeInsets.zero
                        : const EdgeInsets.all(4.0),
                    child: Icon(
                      widget.isMinimized
                          ? Icons.arrow_forward_ios_rounded
                          : Icons.arrow_back_ios_rounded,
                      color: mainColor,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const Divider(color: Color(0xFFF0F0F0), thickness: 2, height: 1),

          // Label Menu seperti pada desain
          if (!widget.isMinimized)
            const Padding(
              padding: EdgeInsets.fromLTRB(20, 18, 16, 8),
              child: Text(
                'Menu',
                style: TextStyle(color: Color(0xFF8A9BAE), fontSize: 14),
              ),
            ),

          // Daftar Menu
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              children: primaryMenuItems.map((item) {
                final isSelected = item.title == widget.selectedPrimaryItem;

                // Jika menu memiliki sub-item, gunakan ExpansionTile
                if (item.subItems != null) {
                  return Theme(
                    data: Theme.of(
                      context,
                    ).copyWith(dividerColor: Colors.transparent),
                    child: ExpansionTile(
                      key: PageStorageKey(
                        item.title,
                      ), // Penting untuk mempertahankan status buka/tutup
                      initiallyExpanded: isSelected,
                      tilePadding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 5.0,
                      ),

                      // Title item menu utama (tanpa teks saat minimize)
                      title: isSelected && !widget.isMinimized
                          ?
                            // Item Aktif (dibuat mirip SidebarItem yang aktif)
                            Row(
                              children: [
                                Container(
                                  width: 4,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: mainColor,
                                    borderRadius: BorderRadius.circular(2),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Icon(item.icon, color: mainColor, size: 24),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    item.title,
                                    style: TextStyle(
                                      color: mainColor,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : isSelected && widget.isMinimized
                          ? Icon(item.icon, color: mainColor, size: 24)
                          : widget.isMinimized
                          ? Icon(
                              item.icon,
                              color: const Color(0xFF5C7E9D),
                              size: 24,
                            )
                          : Row(
                              // Item Non-aktif
                              children: [
                                const SizedBox(width: 4),
                                const SizedBox(width: 12),
                                Icon(
                                  item.icon,
                                  color: const Color(0xFF5C7E9D),
                                  size: 24,
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    item.title,
                                    style: const TextStyle(
                                      color: Color(0xFF5C7E9D),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ],
                            ),

                      trailing: widget.isMinimized
                          ? null
                          : Icon(
                              Icons.keyboard_arrow_down,
                              color: isSelected
                                  ? mainColor
                                  : const Color(0xFF5C7E9D),
                            ),

                      // Children / Submenu
                      children: [
                        // Sembunyikan sub-items saat sidebar diminimalkan
                        if (!widget.isMinimized)
                          Padding(
                            padding: const EdgeInsets.only(left: 12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: item.subItems!.map((subTitle) {
                                return SubSidebarItem(
                                  title: subTitle,
                                  isSelected:
                                      subTitle == widget.selectedSubItem,
                                  isMinimized: widget.isMinimized,
                                  onTap: () =>
                                      widget.onSelect(item.title, subTitle),
                                );
                              }).toList(),
                            ),
                          ),
                      ],
                    ),
                  );
                }

                // Item menu tunggal (non-dropdown)
                return SidebarItem(
                  item: item,
                  isSelected: isSelected,
                  isMinimized: widget.isMinimized,
                  onTap: () => widget.onSelect(item.title, null),
                );
              }).toList(),
            ),
          ),

          // Area Profil Pengguna
          const Divider(color: Color(0xFFF0F0F0), thickness: 2, height: 1),
          Padding(
            padding: EdgeInsets.all(widget.isMinimized ? 12.0 : 16.0),
            child: Row(
              mainAxisAlignment: widget.isMinimized
                  ? MainAxisAlignment.center
                  : MainAxisAlignment.start,
              children: <Widget>[
                const CircleAvatar(
                  backgroundColor: Color(0xFFD3E0EA),
                  radius: 18,
                  child: Icon(Icons.person, color: Color(0xFF3F6FAA), size: 20),
                ),
                if (!widget.isMinimized) const SizedBox(width: 8),
                if (!widget.isMinimized)
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Yuma Akhunza K.P',
                        style: TextStyle(
                          color: Color(0xFF333333),
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        'yuma.akhunza@gmail.com',
                        style: TextStyle(
                          color: Color(0xFF999999),
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
