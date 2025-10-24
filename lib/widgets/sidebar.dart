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
      return const SizedBox.shrink();
    }

    final selectedBgColor = Theme.of(context).colorScheme.primary;
    final selectedColor = Colors.white;
    final unselectedColor = const Color(0xFF5C7E9D);

    return Padding(
      padding: const EdgeInsets.only(left: 4.0),
      child: Container(
        margin: const EdgeInsets.only(right: 16, bottom: 2),
        decoration: BoxDecoration(
          color: isSelected ? selectedBgColor : Colors.transparent,
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(8),
            bottomRight: Radius.circular(8),
          ),
        ),
        child: ListTile(
          dense: true,
          contentPadding: const EdgeInsets.fromLTRB(60.0, 8, 16.0, 8),
          title: Text(
            title,
            style: TextStyle(
              color: isSelected ? selectedColor : unselectedColor,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              fontSize: 14,
            ),
            overflow: TextOverflow.ellipsis,
          ),
          onTap: onTap,
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

    if (isMinimized) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
        child: Tooltip(
          message: item.title,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(8),
            child: Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFFE5F1FF) : null,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(item.icon, color: iconColor, size: 24),
            ),
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFE5F1FF) : null,
          borderRadius: BorderRadius.circular(8),
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.fromLTRB(12.0, 8.0, 16.0, 8.0),
          leading: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 4,
                height: 40,
                decoration: BoxDecoration(
                  color: isSelected ? selectedColor : Colors.transparent,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 12),
              Icon(item.icon, color: iconColor, size: 24),
            ],
          ),
          title: Text(
            item.title,
            style: TextStyle(
              color: iconColor,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              fontSize: 14,
            ),
            overflow: TextOverflow.ellipsis,
          ),
          onTap: onTap,
        ),
      ),
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
  final bool isMobile;

  const CustomSidebar({
    super.key,
    required this.onToggleMinimize,
    required this.isMinimized,
    required this.selectedPrimaryItem,
    required this.selectedSubItem,
    required this.onSelect,
    this.isMobile = false,
  });

  @override
  State<CustomSidebar> createState() => _CustomSidebarState();
}

class _CustomSidebarState extends State<CustomSidebar> {
  static const double maxSidebarWidth = 280;
  static const double minSidebarWidth = 72;

  // Track expanded state for each menu item
  final Map<String, bool> _expandedStates = {};

  @override
  void initState() {
    super.initState();
    // Initialize expanded states
    for (var item in primaryMenuItems) {
      if (item.subItems != null) {
        _expandedStates[item.title] = item.title == widget.selectedPrimaryItem;
      }
    }
  }

  @override
  void didUpdateWidget(CustomSidebar oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Update expanded state when selection changes
    if (oldWidget.selectedPrimaryItem != widget.selectedPrimaryItem) {
      setState(() {
        for (var item in primaryMenuItems) {
          if (item.subItems != null) {
            _expandedStates[item.title] =
                item.title == widget.selectedPrimaryItem;
          }
        }
      });
    }
  }

  double get currentWidth =>
      widget.isMinimized ? minSidebarWidth : maxSidebarWidth;

  @override
  Widget build(BuildContext context) {
    const Color sidebarBgColor = Colors.white;
    final mainColor = Theme.of(context).colorScheme.primary;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: widget.isMobile ? maxSidebarWidth : currentWidth,
      color: sidebarBgColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Header
          Padding(
            padding: EdgeInsets.fromLTRB(
              16,
              24,
              widget.isMinimized && !widget.isMobile ? 16 : 8,
              24,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (!widget.isMinimized || widget.isMobile)
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

                // Only show toggle on desktop
                if (!widget.isMobile)
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

          // Menu List
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              children: primaryMenuItems.map((item) {
                final isSelected = item.title == widget.selectedPrimaryItem;

                // Menu with sub-items
                if (item.subItems != null) {
                  if (widget.isMinimized && !widget.isMobile) {
                    // Show only icon when minimized on desktop
                    return SidebarItem(
                      item: item,
                      isSelected: isSelected,
                      isMinimized: true,
                      onTap: () {
                        // When clicked in minimized mode, select first sub-item
                        widget.onSelect(item.title, item.subItems!.first);
                      },
                    );
                  }

                  return Theme(
                    data: Theme.of(
                      context,
                    ).copyWith(dividerColor: Colors.transparent),
                    child: ExpansionTile(
                      key: PageStorageKey(item.title),
                      initiallyExpanded: _expandedStates[item.title] ?? false,
                      onExpansionChanged: (expanded) {
                        setState(() {
                          _expandedStates[item.title] = expanded;
                        });
                      },
                      tilePadding: const EdgeInsets.symmetric(
                        horizontal: 8.0,
                        vertical: 2.0,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      collapsedShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      backgroundColor: isSelected
                          ? const Color(0xFFE5F1FF)
                          : null,
                      collapsedBackgroundColor: isSelected
                          ? const Color(0xFFE5F1FF)
                          : null,

                      title: Row(
                        children: [
                          Container(
                            width: 4,
                            height: 40,
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? mainColor
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Icon(
                            item.icon,
                            color: isSelected
                                ? mainColor
                                : const Color(0xFF5C7E9D),
                            size: 24,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              item.title,
                              style: TextStyle(
                                color: isSelected
                                    ? mainColor
                                    : const Color(0xFF5C7E9D),
                                fontWeight: isSelected
                                    ? FontWeight.w600
                                    : FontWeight.w500,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),

                      trailing: Icon(
                        _expandedStates[item.title] == true
                            ? Icons.keyboard_arrow_up
                            : Icons.keyboard_arrow_down,
                        color: isSelected ? mainColor : const Color(0xFF5C7E9D),
                      ),

                      children: item.subItems!.map((subTitle) {
                        return SubSidebarItem(
                          title: subTitle,
                          isSelected:
                              subTitle == widget.selectedSubItem && isSelected,
                          isMinimized: false,
                          onTap: () => widget.onSelect(item.title, subTitle),
                        );
                      }).toList(),
                    ),
                  );
                }

                // Single menu item (no sub-items)
                return SidebarItem(
                  item: item,
                  isSelected: isSelected,
                  isMinimized: widget.isMinimized && !widget.isMobile,
                  onTap: () => widget.onSelect(item.title, null),
                );
              }).toList(),
            ),
          ),

          // User Profile Area
          const Divider(color: Color(0xFFF0F0F0), thickness: 2, height: 1),
          Padding(
            padding: EdgeInsets.all(
              widget.isMinimized && !widget.isMobile ? 12.0 : 16.0,
            ),
            child: Row(
              mainAxisAlignment: widget.isMinimized && !widget.isMobile
                  ? MainAxisAlignment.center
                  : MainAxisAlignment.start,
              children: <Widget>[
                const CircleAvatar(
                  backgroundColor: Color(0xFFD3E0EA),
                  radius: 18,
                  child: Icon(Icons.person, color: Color(0xFF3F6FAA), size: 20),
                ),
                if (!widget.isMinimized || widget.isMobile)
                  const SizedBox(width: 8),
                if (!widget.isMinimized || widget.isMobile)
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Yuma Akhunza K.P',
                          style: TextStyle(
                            color: Color(0xFF333333),
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          'yuma.akhunza@gmail.com',
                          style: TextStyle(
                            color: Color(0xFF999999),
                            fontSize: 11,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
