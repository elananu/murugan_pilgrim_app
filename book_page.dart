import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../data/temple_data.dart';
import '../utils/app_strings.dart';

class BookPage extends StatelessWidget {
  final AppStrings t;
  final Temple? selectedTemple;

  const BookPage({super.key, required this.t, this.selectedTemple});

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
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
                colors: [Color(0xFF1A0A2E), Color(0xFF4A0080)],
              ),
            ),
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '📋 ${t.book}',
                  style: const TextStyle(
                    color: Color(0xFFFFD700),
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  t.onlineBookings,
                  style: const TextStyle(color: Colors.white60, fontSize: 13),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                if (selectedTemple == null)
                  Container(
                    padding: const EdgeInsets.all(14),
                    margin: const EdgeInsets.only(bottom: 14),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF3E5F5),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Text(
                      t.showingDefault,
                      style: const TextStyle(color: Color(0xFF6A1B9A), fontSize: 13),
                    ),
                  ),
                _BookingCard(
                  icon: '🛕',
                  title: t.bookDarshan,
                  subtitle: t.onlineBookings,
                  color: const Color(0xFF9C27B0),
                  onTap: () => _launchUrl(temple.bookingUrl),
                ),
                const SizedBox(height: 12),
                _BookingCard(
                  icon: '🚌',
                  title: t.bookBus,
                  subtitle: t.busTravel,
                  color: const Color(0xFF1976D2),
                  onTap: () => _launchUrl('https://www.tnstc.in/'),
                ),
                const SizedBox(height: 12),
                _BookingCard(
                  icon: '🚂',
                  title: t.bookTrain,
                  subtitle: t.trainTravel,
                  color: const Color(0xFF388E3C),
                  onTap: () => _launchUrl('https://www.irctc.co.in/'),
                ),
                const SizedBox(height: 24),
                Text(
                  t.quickLinks,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Color(0xFF1A0A2E),
                  ),
                ),
                const SizedBox(height: 12),
                ...temples.map((t2) => GestureDetector(
                  onTap: () => _launchUrl(t2.bookingUrl),
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: t2.color.withOpacity(0.12),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(child: Text(t2.emoji)),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(t2.name, style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1A0A2E))),
                              Text(t2.location, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                            ],
                          ),
                        ),
                        Icon(Icons.open_in_new, size: 16, color: t2.color),
                      ],
                    ),
                  ),
                )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _BookingCard extends StatelessWidget {
  final String icon;
  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;

  const _BookingCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
              decoration: BoxDecoration(
                color: color.withOpacity(0.12),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Center(child: Text(icon, style: const TextStyle(fontSize: 24))),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: TextStyle(fontWeight: FontWeight.bold, color: color, fontSize: 15)),
                  const SizedBox(height: 2),
                  Text(subtitle, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios, size: 14, color: color),
          ],
        ),
      ),
    );
  }
}
