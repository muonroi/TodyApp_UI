import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tudy/features/home/presentation/pages/upcommong_page.dart';
import 'package:tudy/features/home/presentation/widgets/quick_add_bar.dart';
import 'package:tudy/features/home/today_screen.dart';
import 'package:tudy/l10n/app_localizations.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    const TodayScreen(),
    const UpcomingScreen(),
  ];

  List<String> _getAppBarTitles(AppLocalizations l10n) {
    return [
      l10n.today,
      l10n.upcoming,
      l10n.searchTitle,
      l10n.browse,
    ];
  }

  void _onItemTapped(int index) {
    if (_selectedIndex == index && index == 2) return;

    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _buildNavIcon(
      IconData iconData, String? text, bool isSelected, ThemeData theme) {
    final color = isSelected
        ? Colors.blue.shade800
        : theme.colorScheme.onSurface.withValues(alpha: 0.6);
    if (text != null) {
      return Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          Icon(iconData, color: color),
          Positioned(
              top: 4,
              child: Text(text,
                  style: TextStyle(
                      fontSize: 9, fontWeight: FontWeight.bold, color: color))),
        ],
      );
    } else {
      return Icon(iconData, color: color);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final appBarTitles = _getAppBarTitles(l10n);

    return Scaffold(
      appBar: AppBar(
          title: Text(
            _selectedIndex < appBarTitles.length
                ? appBarTitles[_selectedIndex]
                : '',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onSurface),
          ),
          backgroundColor: theme.scaffoldBackgroundColor,
          elevation: 0,
          scrolledUnderElevation: 1),
      body: Column(
        children: [
          Expanded(
            child: IndexedStack(
              index: _selectedIndex,
              children: _widgetOptions,
            ),
          ),
          const QuickAddBar()
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: _buildNavIcon(Icons.calendar_today_outlined, '15',
                  0 == _selectedIndex, theme),
              label: l10n.today),
          BottomNavigationBarItem(
              icon: _buildNavIcon(
                  Icons.apps_outage_outlined, null, 1 == _selectedIndex, theme),
              label: l10n.upcoming),
          BottomNavigationBarItem(
              icon:
                  _buildNavIcon(Icons.search, null, 2 == _selectedIndex, theme),
              label: l10n.searchTitle),
          BottomNavigationBarItem(
              icon: _buildNavIcon(Icons.menu, null, 3 == _selectedIndex, theme),
              label: l10n.browse),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue.shade800,
        unselectedItemColor: colorScheme.onSurface.withValues(alpha: 0.6),
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: true,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 1,
      ),
    );
  }
}
