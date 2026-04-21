import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../data/temple_data.dart';
import '../utils/app_strings.dart';

class TempleDetailPage extends StatefulWidget {
  final Temple temple;
  final AppStrings t;
  final VoidCallback onBack;
  final VoidCallback onNavigate;
  final VoidCallback onBook;

  const TempleDetailPage({
    super.key,
    required this.temple,
    required this.t,
    required this.onBack,
    required this.onNavigate,
    required this.onBook,
  });

  @override
  State<TempleDetailPage> createState() => _TempleDetailPageState();
}

class _TempleDetailPageState extends State<TempleDetailPage> {
  String _activeTab = 'history';

  List<Map<String, String>> get _tabs => [
    {'id': 'history', 'label': widget.t.history, 'icon': '📖'},
    {'id': 'darshan', 'label': widget.t.darshan, 'icon': '🕐'},
    {'id': 'pooja', 'label': widget.t.pooja, 'icon': '🪔'},
    {'id': 'facilities', 'label': widget.t.facilities, 'icon': '🏪'},
    {'id': 'festivals', 'label': widget.t.festivals, 'icon': '🎉'},
  ];

  final List<String> _facilityIcons = ['🅿️', '🚻', '🧳', '🚰', '🏥', '🚡', '🛒', '🎫'];

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final temple = widget.temple;
    final t = widget.t;

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 80),
        child: Column(
          children: [
            SizedBox(
              height: 280,
              width: double.infinity,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    temple.imagePath,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: temple.gradient),
                        ),
                        child: Stack(
                          children: [
                            Positioned(
                              right: -30,
                              top: -30,
                              child: Opacity(opacity: 0.08, child: Text('🔱', style: TextStyle(fontSize: 180, color: Colors.white.withOpacity(0.5)))),
                            ),
                            Center(child: Text(temple.emoji, style: const TextStyle(fontSize: 80))),
                          ],
                        ),
                      );
                    },
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.black.withOpacity(0.3), Colors.black.withOpacity(0.75)],
                        stops: const [0.3, 1.0],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 48,
                    left: 16,
                    child: GestureDetector(
                      onTap: widget.onBack,
                      child: Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(color: Colors.black.withOpacity(0.35), borderRadius: BorderRadius.circular(10)),
                        child: const Icon(Icons.arrow_back, color: Colors.white, size: 18),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 52,
                    right: 16,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.white.withOpacity(0.3)),
                      ),
                      child: Text(temple.type, style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w600)),
                    ),
                  ),
                  Positioned(
                    bottom: 16,
                    left: 16,
                    right: 16,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(temple.name, style: const TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold, shadows: [Shadow(blurRadius: 6, color: Colors.black54)])),
                        Text(temple.tamil, style: const TextStyle(color: Colors.white70, fontSize: 16)),
                        const SizedBox(height: 4),
                        Text('📍 ${temple.location}', style: const TextStyle(color: Colors.white60, fontSize: 13)),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            _chip(temple.type),
                            const SizedBox(width: 8),
                            _chip(temple.deity),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(16, 14, 16, 0),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: widget.onNavigate,
                      icon: const Text('🗺️'),
                      label: Text(t.navigate),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: temple.color,
                        side: BorderSide(color: temple.color.withOpacity(0.5)),
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: widget.onBook,
                      icon: const Text('📋'),
                      label: Text(t.book),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: temple.color,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        elevation: 0,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(
              height: 48,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.fromLTRB(12, 14, 12, 0),
                children: _tabs.map((tab) {
                  final isActive = _activeTab == tab['id'];
                  return GestureDetector(
                    onTap: () => setState(() => _activeTab = tab['id']!),
                    child: Container(
                      margin: const EdgeInsets.only(right: 8),
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                      decoration: BoxDecoration(
                        color: isActive ? temple.color : const Color(0xFFF5F5F5),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        '${tab['icon']} ${tab['label']}',
                        style: TextStyle(color: isActive ? Colors.white : Colors.black54, fontSize: 12, fontWeight: FontWeight.w600),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16),
              child: _buildTabContent(temple, t),
            ),
          ],
        ),
      ),
    );
  }

  Widget _chip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
      decoration: BoxDecoration(color: Colors.white.withOpacity(0.25), borderRadius: BorderRadius.circular(20)),
      child: Text(label, style: const TextStyle(color: Colors.white, fontSize: 12)),
    );
  }

  Widget _buildTabContent(Temple temple, AppStrings t) {
    switch (_activeTab) {
      case 'history':
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 12)],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('📖 ${t.history}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF1A0A2E))),
              const SizedBox(height: 10),
              Text(temple.history, style: const TextStyle(color: Color(0xFF444444), height: 1.7, fontSize: 14)),
              const SizedBox(height: 14),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: temple.color.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(12),
                  border: Border(left: BorderSide(color: temple.color, width: 4)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(t.presidingDeity, style: TextStyle(color: temple.color, fontWeight: FontWeight.bold, fontSize: 13)),
                    const SizedBox(height: 4),
                    Text(temple.deity, style: const TextStyle(color: Color(0xFF333333), fontSize: 14)),
                  ],
                ),
              ),
            ],
          ),
        );

      case 'darshan':
        return Column(
          children: temple.darshanTimings.asMap().entries.map((entry) {
            final i = entry.key;
            final d = entry.value;
            return Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 12)],
              ),
              child: Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(color: temple.color.withOpacity(0.12), borderRadius: BorderRadius.circular(12)),
                    child: Center(child: Text(i == 0 ? '🌅' : '🌆', style: const TextStyle(fontSize: 22))),
                  ),
                  const SizedBox(width: 14),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        i == 0 ? t.morningSession : t.eveningSession,
                        style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1A0A2E)),
                      ),
                      const SizedBox(height: 2),
                      Text(d['time'] ?? '', style: TextStyle(color: temple.color, fontSize: 15, fontWeight: FontWeight.w700)),
                    ],
                  ),
                ],
              ),
            );
          }).toList(),
        );

      case 'pooja':
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 12)],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('🪔 ${t.pooja}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF1A0A2E))),
              const SizedBox(height: 12),
              ...temple.poojaTimings.asMap().entries.map((entry) {
                final i = entry.key;
                final p = entry.value;
                return Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: i < temple.poojaTimings.length - 1 ? Colors.grey[100]! : Colors.transparent)),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 28,
                        height: 28,
                        decoration: BoxDecoration(color: temple.color.withOpacity(0.15), shape: BoxShape.circle),
                        child: Center(child: Text('${i + 1}', style: TextStyle(color: temple.color, fontSize: 12, fontWeight: FontWeight.bold))),
                      ),
                      const SizedBox(width: 12),
                      Text(p, style: const TextStyle(color: Color(0xFF333333), fontSize: 14)),
                    ],
                  ),
                );
              }),
            ],
          ),
        );

      case 'facilities':
        return Wrap(
          spacing: 10,
          runSpacing: 10,
          children: temple.facilities.asMap().entries.map((entry) {
            final i = entry.key;
            final f = entry.value;
            return Container(
              width: (MediaQuery.of(context).size.width - 52) / 2,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 10)],
              ),
              child: Row(
                children: [
                  Text(_facilityIcons[i % _facilityIcons.length], style: const TextStyle(fontSize: 20)),
                  const SizedBox(width: 8),
                  Expanded(child: Text(f, style: const TextStyle(fontSize: 12, color: Color(0xFF333333), fontWeight: FontWeight.w500))),
                ],
              ),
            );
          }).toList(),
        );

      case 'festivals':
        return Column(
          children: temple.festivals.map((f) {
            return Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 12)],
              ),
              child: Row(
                children: [
                  Container(
                    width: 46,
                    height: 46,
                    decoration: BoxDecoration(color: temple.color.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
                    child: const Center(child: Text('🎉', style: TextStyle(fontSize: 22))),
                  ),
                  const SizedBox(width: 12),
                  Text(f, style: const TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF1A0A2E), fontSize: 15)),
                ],
              ),
            );
          }).toList(),
        );

      default:
        return const SizedBox.shrink();
    }
  }
}
