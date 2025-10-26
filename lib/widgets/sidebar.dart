import 'package:flutter/material.dart';
import '../models/menu_item.dart';

class CustomSidebar extends StatefulWidget {
  final String title;
  final Widget child;
  final List<Widget>? actions;
  final String selectedPrimaryItem;
  final String? selectedSubItem;
  final Function(String, String?) onMenuSelect;

  const CustomSidebar({
    super.key,
    required this.title,
    required this.child,
    required this.selectedPrimaryItem,
    required this.onMenuSelect,
    this.selectedSubItem,
    this.actions,
  });

  @override
  State<CustomSidebar> createState() => _CustomSidebarState();
}

class _CustomSidebarState extends State<CustomSidebar> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isSidebarMinimized = false;
  final Map<String, bool> _expandedItems = {};
  bool _isProfileExpanded = false;

  @override
  void initState() {
    super.initState();
    _initializeExpandedStates();
  }

  void _initializeExpandedStates() {
    for (var item in primaryMenuItems) {
      if (item.subItems != null) {
        _expandedItems[item.title] = item.title == widget.selectedPrimaryItem;
      }
    }
  }

  @override
  void didUpdateWidget(CustomSidebar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedPrimaryItem != widget.selectedPrimaryItem) {
      _expandedItems.updateAll(
        (key, value) => key == widget.selectedPrimaryItem,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isMobile = MediaQuery.of(context).size.width < 768;

    if (isMobile) {
      return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => _scaffoldKey.currentState?.openDrawer(),
            color: Theme.of(context).colorScheme.primary,
          ),
          title: Text(
            widget.title,
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: widget.actions,
        ),
        drawer: _buildSidebar(isMobile: true),
        body: widget.child,
      );
    }

    return Scaffold(
      body: Row(
        children: [
          _buildSidebar(isMobile: false),
          Expanded(
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                elevation: 0,
                leading: IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () {
                    setState(() => _isSidebarMinimized = !_isSidebarMinimized);
                  },
                  color: Theme.of(context).colorScheme.primary,
                ),
                title: Text(
                  widget.title,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                actions: widget.actions,
              ),
              body: widget.child,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSidebar({required bool isMobile}) {
    const Color sidebarBgColor = Colors.white;
    final mainColor = Theme.of(context).colorScheme.primary;
    final screenWidth = MediaQuery.of(context).size.width;
    final bool isVeryNarrowScreen = screenWidth < 360;
    const double maxSidebarWidth = 280;
    const double minSidebarWidth = 72;

    Widget sidebar = Container(
      width: isMobile
          ? (isVeryNarrowScreen ? screenWidth : maxSidebarWidth)
          : (_isSidebarMinimized ? minSidebarWidth : maxSidebarWidth),
      color: sidebarBgColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(mainColor, isMobile),
          const Divider(color: Color(0xFFF0F0F0), thickness: 2, height: 1),
          Expanded(child: _buildMenuList(mainColor, isMobile)),
          const Divider(color: Color(0xFFF0F0F0), thickness: 2, height: 1),
          _buildUserProfile(isMobile),
        ],
      ),
    );

    if (isMobile) {
      return Drawer(child: sidebar);
    }

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      child: sidebar,
    );
  }

  Widget _buildHeader(Color mainColor, bool isMobile) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16, 24, isMobile ? 8 : 16, 24),
      child: Row(
        children: [
          if (isMobile)
            IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => _scaffoldKey.currentState?.closeDrawer(),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              iconSize: 24,
              color: mainColor,
            ),
          if (isMobile) const SizedBox(width: 8),
          Icon(Icons.menu_book, color: mainColor, size: 28),
          if (!_isSidebarMinimized || isMobile) ...[
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                'Jawara Pintar',
                style: TextStyle(
                  color: mainColor,
                  fontSize: isMobile ? 20 : 22,
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
          if (!isMobile && !_isSidebarMinimized)
            IconButton(
              icon: const Icon(Icons.arrow_back_ios_rounded),
              onPressed: () => setState(() => _isSidebarMinimized = true),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              iconSize: 20,
              color: mainColor,
            ),
        ],
      ),
    );
  }

  Widget _buildMenuList(Color mainColor, bool isMobile) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      itemCount: primaryMenuItems.length,
      itemBuilder: (context, index) {
        final item = primaryMenuItems[index];
        final isSelected = item.title == widget.selectedPrimaryItem;
        final isExpanded = _expandedItems[item.title] ?? false;

        if (_isSidebarMinimized && !isMobile) {
          return _buildMinimizedMenuItem(item, isSelected, mainColor);
        }

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
          child: Container(
            decoration: BoxDecoration(
              color: isSelected ? const Color(0xFFE5F1FF) : Colors.transparent,
              borderRadius: BorderRadius.circular(8),
            ),
            child: item.subItems != null
                ? Theme(
                    data: Theme.of(
                      context,
                    ).copyWith(dividerColor: Colors.transparent),
                    child: ExpansionTile(
                      key: ValueKey('${item.title}_$isExpanded'),
                      initiallyExpanded: isExpanded,
                      maintainState: true,
                      backgroundColor: Colors.transparent,
                      collapsedBackgroundColor: Colors.transparent,
                      shape: const RoundedRectangleBorder(
                        side: BorderSide.none,
                      ),
                      collapsedShape: const RoundedRectangleBorder(
                        side: BorderSide.none,
                      ),
                      tilePadding: const EdgeInsets.symmetric(horizontal: 16.0),
                      title: _buildMenuItemTitle(item, isSelected, mainColor),
                      trailing: Icon(
                        isExpanded
                            ? Icons.keyboard_arrow_up
                            : Icons.keyboard_arrow_down,
                        color: isSelected ? mainColor : const Color(0xFF5C7E9D),
                        size: 24,
                      ),
                      onExpansionChanged: (expanded) {
                        setState(() {
                          _expandedItems[item.title] = expanded;
                          if (expanded) {
                            widget.onMenuSelect(
                              item.title,
                              item.subItems!.first,
                            );
                          }
                        });
                      },
                      children: item.subItems!.map((subItem) {
                        final isSubSelected =
                            subItem == widget.selectedSubItem && isSelected;
                        return ListTile(
                          dense: true,
                          contentPadding: const EdgeInsets.only(left: 56.0),
                          selected: isSubSelected,
                          title: Text(
                            subItem,
                            style: TextStyle(
                              color: isSubSelected
                                  ? mainColor
                                  : const Color(0xFF5C7E9D),
                              fontWeight: isSubSelected
                                  ? FontWeight.w600
                                  : FontWeight.w500,
                              fontSize: 14,
                            ),
                          ),
                          onTap: () {
                            widget.onMenuSelect(item.title, subItem);
                            if (isMobile) {
                              _scaffoldKey.currentState?.closeDrawer();
                            }
                          },
                        );
                      }).toList(),
                    ),
                  )
                : ListTile(
                    dense: true,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                    ),
                    title: _buildMenuItemTitle(item, isSelected, mainColor),
                    onTap: () {
                      widget.onMenuSelect(item.title, null);
                      if (isMobile) {
                        _scaffoldKey.currentState?.closeDrawer();
                      }
                    },
                  ),
          ),
        );
      },
    );
  }

  Widget _buildMenuItemTitle(MenuItem item, bool isSelected, Color mainColor) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 40,
          decoration: BoxDecoration(
            color: isSelected ? mainColor : Colors.transparent,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 12),
        Icon(
          item.icon,
          color: isSelected ? mainColor : const Color(0xFF5C7E9D),
          size: 24,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            item.title,
            style: TextStyle(
              color: isSelected ? mainColor : const Color(0xFF5C7E9D),
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMinimizedMenuItem(
    MenuItem item,
    bool isSelected,
    Color mainColor,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
      child: Tooltip(
        message: item.title,
        child: InkWell(
          onTap: () {
            if (item.subItems != null) {
              widget.onMenuSelect(item.title, item.subItems!.first);
            } else {
              widget.onMenuSelect(item.title, null);
            }
          },
          borderRadius: BorderRadius.circular(8),
          child: Container(
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: isSelected ? const Color(0xFFE5F1FF) : null,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              item.icon,
              color: isSelected ? mainColor : const Color(0xFF5C7E9D),
              size: 24,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildUserProfile(bool isMobile) {
    if (_isSidebarMinimized && !isMobile) {
      // Minimized view - just show avatar
      return Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(
              backgroundColor: Color(0xFFD3E0EA),
              radius: 18,
              child: Icon(Icons.person, color: Color(0xFF3F6FAA), size: 20),
            ),
          ],
        ),
      );
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: () {
            setState(() {
              _isProfileExpanded = !_isProfileExpanded;
            });
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                const CircleAvatar(
                  backgroundColor: Color(0xFFD3E0EA),
                  radius: 18,
                  child: Icon(Icons.person, color: Color(0xFF3F6FAA), size: 20),
                ),
                const SizedBox(width: 8),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Admin Testing',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        'admin@jawara.test',
                        style: TextStyle(
                          color: Color(0xFF999999),
                          fontSize: 11,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                Icon(
                  _isProfileExpanded
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                  color: const Color(0xFF5C7E9D),
                  size: 20,
                ),
              ],
            ),
          ),
        ),
        if (_isProfileExpanded) _buildLogoutOption(isMobile),
      ],
    );
  }

  Widget _buildLogoutOption(bool isMobile) {
    return InkWell(
      onTap: () => _showLogoutDialog(isMobile),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: Row(
          children: [
            const SizedBox(width: 42), // Align with text above
            const Icon(Icons.logout, color: Color(0xFF5C7E9D), size: 20),
            const SizedBox(width: 12),
            Text(
              'Logout',
              style: TextStyle(
                color: const Color(0xFF5C7E9D),
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showLogoutDialog(bool isMobile) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Logout'),
          content: const Text('Are you sure you want to logout?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
                if (isMobile) {
                  _scaffoldKey.currentState?.closeDrawer();
                }
                // Navigate to login page
                Navigator.of(
                  context,
                ).pushNamedAndRemoveUntil('/login', (route) => false);
              },
              child: const Text('Logout', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }
}
