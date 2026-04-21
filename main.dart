import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'data/temple_data.dart';
import 'utils/app_strings.dart';
import 'utils/app_theme.dart';
import 'services/notification_service.dart';
import 'screens/splash_screen.dart';
import 'screens/home_page.dart';
import 'screens/temples_page.dart';
import 'screens/temple_detail_page.dart';
import 'screens/map_page.dart';
import 'screens/book_page.dart';
import 'screens/alerts_page.dart';
import 'screens/settings_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Lock to portrait
  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp]);

  // ── Firebase ─────────────────────────────────────────────────
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyC9ddMm2ydw4RLE_HtMOD_QhokU--BRp0A',
      appId: '1:9335456148:android:ecca52a16f87ef16e44f81',
      messagingSenderId: '9335456148',
      projectId: 'murugan-app-9ac36',
      storageBucket: 'murugan-app-9ac36.firebasestorage.app',
    ),
  );

  // ── Local Notifications ──────────────────────────────────────
  await NotificationService().init();

  runApp(const MuruganApp());
}

class MuruganApp extends StatelessWidget {
  const MuruganApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Murugan Pilgrim',
      theme: AppTheme.theme,
      debugShowCheckedModeBanner: false,
      home: const AppRoot(),
    );
  }
}

class AppRoot extends StatefulWidget {
  const AppRoot({super.key});

  @override
  State<AppRoot> createState() => _AppRootState();
}

class _AppRootState extends State<AppRoot> {
  bool _showSplash = true;
  int _currentIndex = 0;
  Temple? _selectedTemple;
  bool _showDetail = false;
  String _searchQuery = '';
  String _currentLang = 'en';
  bool _notifEnabled = true;
  Map<String, Map<String, dynamic>> _countdowns = {};
  late Timer _countdownTimer;

  AppStrings get t => AppStrings.fromCode(_currentLang);

  @override
  void initState() {
    super.initState();
    _loadNotifPreference();
    _updateCountdowns();
    _countdownTimer = Timer.periodic(
      const Duration(seconds: 1),
      (_) => _updateCountdowns(),
    );
  }

  Future<void> _loadNotifPreference() async {
    final prefs = await SharedPreferences.getInstance();
    final enabled = prefs.getBool('notifications_enabled') ?? true;
    if (mounted) setState(() => _notifEnabled = enabled);
  }

  void _updateCountdowns() {
    final now = DateTime.now();
    final updated = <String, Map<String, dynamic>>{};
    for (final f in festivals) {
      final diff = f.date.difference(now);
      if (diff.isNegative) {
        updated[f.name] = {
          'days': 0,
          'hours': 0,
          'mins': 0,
          'secs': 0,
          'passed': true
        };
      } else {
        updated[f.name] = {
          'days': diff.inDays,
          'hours': diff.inHours % 24,
          'mins': diff.inMinutes % 60,
          'secs': diff.inSeconds % 60,
          'passed': false,
        };
      }
    }
    if (mounted) setState(() => _countdowns = updated);
  }

  @override
  void dispose() {
    _countdownTimer.cancel();
    super.dispose();
  }

  void _openTemple(Temple temple) {
    setState(() {
      _selectedTemple = temple;
      _showDetail = true;
    });
  }

  void _closeDetail() => setState(() => _showDetail = false);

  Future<void> _handleNotifToggle(bool value) async {
    setState(() => _notifEnabled = value);
    await NotificationService().setEnabled(value);
  }

  final List<Map<String, dynamic>> _navItems = [
    {'icon': Icons.home_rounded, 'page': 'home'},
    {'icon': Icons.temple_hindu_rounded, 'page': 'temples'},
    {'icon': Icons.map_rounded, 'page': 'map'},
    {'icon': Icons.book_online_rounded, 'page': 'book'},
    {'icon': Icons.notifications_rounded, 'page': 'alerts'},
    {'icon': Icons.settings_rounded, 'page': 'settings'},
  ];

  Widget _buildPage() {
    if (_showDetail && _selectedTemple != null) {
      return TempleDetailPage(
        temple: _selectedTemple!,
        t: t,
        onBack: _closeDetail,
        onNavigate: () => setState(() {
          _showDetail = false;
          _currentIndex = 2;
        }),
        onBook: () => setState(() {
          _showDetail = false;
          _currentIndex = 3;
        }),
      );
    }

    switch (_currentIndex) {
      case 0:
        return HomePage(
          t: t,
          searchQuery: _searchQuery,
          onSearchChanged: (q) => setState(() => _searchQuery = q),
          onTempleSelected: _openTemple,
          onViewAll: () => setState(() => _currentIndex = 1),
          countdowns: _countdowns,
        );
      case 1:
        return TemplesPage(
          t: t,
          searchQuery: _searchQuery,
          onSearchChanged: (q) => setState(() => _searchQuery = q),
          onTempleSelected: _openTemple,
        );
      case 2:
        return MapPage(t: t, selectedTemple: _selectedTemple);
      case 3:
        return BookPage(t: t, selectedTemple: _selectedTemple);
      case 4:
        return AlertsPage(
          t: t,
          notifEnabled: _notifEnabled,
          onNotifToggle: _handleNotifToggle,
        );
      case 5:
        return SettingsPage(
          t: t,
          currentLang: _currentLang,
          notifEnabled: _notifEnabled,
          onLangChanged: (lang) => setState(() => _currentLang = lang),
          onNotifToggle: _handleNotifToggle,
        );
      default:
        return const SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_showSplash) {
      return SplashScreen(
          onDone: () => setState(() => _showSplash = false));
    }

    final navLabels = [
      t.home,
      t.temples,
      t.map,
      t.book,
      t.alerts,
      t.settings,
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF8F4FF),
      body: SafeArea(child: _buildPage()),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: SafeArea(
          top: false,
          child: SizedBox(
            height: 64,
            child: Row(
              children: List.generate(_navItems.length, (i) {
                final isActive = !_showDetail && _currentIndex == i;
                return Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() {
                      _currentIndex = i;
                      _showDetail = false;
                    }),
                    child: Container(
                      color: Colors.transparent,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AnimatedContainer(
                            duration:
                                const Duration(milliseconds: 200),
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: isActive
                                  ? const Color(0xFF9C27B0)
                                      .withOpacity(0.12)
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Icon(
                              _navItems[i]['icon'] as IconData,
                              size: 22,
                              color: isActive
                                  ? const Color(0xFF9C27B0)
                                  : Colors.grey[400],
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            navLabels[i],
                            style: TextStyle(
                              fontSize: 9,
                              color: isActive
                                  ? const Color(0xFF9C27B0)
                                  : Colors.grey[400],
                              fontWeight: isActive
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
