import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../data/temple_data.dart';
import '../utils/app_strings.dart';

class MapPage extends StatelessWidget {
  final AppStrings t;
  final Temple? selectedTemple;

  const MapPage({super.key, required this.t, this.selectedTemple});

  Future<void> _openMaps(Temple temple) async {
    final uri = Uri.parse('https://www.google.com/maps?q=${temple.lat},${temple.lng}');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final temple = selectedTemple ?? temples[0];

    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 80),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF1A0A2E), Color(0xFF2D6A4F)],
              ),
            ),
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '🗺️ ${t.map}',
                  style: const TextStyle(
                    color: Color(0xFFFFD700),
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  t.navigationAndNearby,
                  style: const TextStyle(color: Colors.white60, fontSize: 13),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (selectedTemple == null)
                  Container(
                    padding: const EdgeInsets.all(14),
                    margin: const EdgeInsets.only(bottom: 14),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF3E0),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Text(
                      t.selectTemple,
                      style: const TextStyle(color: Color(0xFFE65100), fontSize: 13),
                    ),
                  ),
                Container(
                  width: double.infinity,
                  height: 200,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFE8F5E9), Color(0xFFF3E5F5)],
                    ),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.green.withOpacity(0.3), width: 2),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('📍', style: TextStyle(fontSize: 40)),
                      const SizedBox(height: 6),
                      Text(
                        temple.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1A0A2E),
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        temple.location,
                        style: const TextStyle(color: Colors.grey, fontSize: 13),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () => _openMaps(temple),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF4CAF50),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        ),
                        child: Text(t.openGoogleMaps),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                _infoCard(icon: '🚌', title: t.nearbyBus, value: temple.nearbyBus, color: const Color(0xFF1565C0)),
                const SizedBox(height: 10),
                _infoCard(icon: '🚂', title: t.nearbyRail, value: temple.nearbyRailway, color: const Color(0xFF6A1B9A)),
                const SizedBox(height: 16),
                _hotelsSection(icon: '🏨', title: t.nearbyHotels, hotels: temple.hotels),
                const SizedBox(height: 14),
                _listSection(icon: '🍽️', title: t.nearbyFood, items: temple.restaurants),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoCard({required String icon, required String title, required String value, required Color color}) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
      ),
      child: Row(
        children: [
          Text(icon, style: const TextStyle(fontSize: 24)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 12)),
                const SizedBox(height: 2),
                Text(value, style: const TextStyle(color: Color(0xFF333333), fontSize: 14)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _hotelsSection({required String icon, required String title, required List<Map<String, String>> hotels}) {
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
          Text('$icon $title', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF1A0A2E))),
          const SizedBox(height: 10),
          ...hotels.map((hotel) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.hotel, size: 16, color: Color(0xFF9C27B0)),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(hotel['name'] ?? '', style: const TextStyle(color: Color(0xFF222222), fontSize: 14, fontWeight: FontWeight.w600)),
                          Text('${hotel['location'] ?? ''} • ${hotel['distance'] ?? ''}', style: const TextStyle(color: Colors.grey, fontSize: 12)),
                        ],
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  Widget _listSection({required String icon, required String title, required List<String> items}) {
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
          Text('$icon $title', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF1A0A2E))),
          const SizedBox(height: 10),
          ...items.map((item) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  children: [
                    const Icon(Icons.restaurant, size: 16, color: Colors.grey),
                    const SizedBox(width: 6),
                    Text(item, style: const TextStyle(color: Color(0xFF444444), fontSize: 14)),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
