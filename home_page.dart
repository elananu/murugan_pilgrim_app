import 'package:flutter/material.dart';
import '../data/temple_data.dart';
import '../utils/app_strings.dart';
import '../utils/app_theme.dart';
import '../widgets/temple_card.dart';
import '../services/festival_calendar.dart';

class HomePage extends StatelessWidget {
  final AppStrings t;
  final String searchQuery;
  final ValueChanged<String> onSearchChanged;
  final ValueChanged<Temple> onTempleSelected;
  final VoidCallback onViewAll;
  final Map<String, Map<String, dynamic>> countdowns;

  const HomePage({
    super.key,
    required this.t,
    required this.searchQuery,
    required this.onSearchChanged,
    required this.onTempleSelected,
    required this.onViewAll,
    required this.countdowns,
  });

  @override
  Widget build(BuildContext context) {
    final filtered = temples.where((temple) {
      final q = searchQuery.toLowerCase();
      return temple.name.toLowerCase().contains(q) ||
          temple.location.toLowerCase().contains(q);
    }).toList();

    final displayList = searchQuery.isNotEmpty ? filtered : temples.take(3).toList();
    final upcomingFestivals = FestivalCalendar.getUpcoming().take(2).toList();

    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 80),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Hero header
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF1A0A2E), Color(0xFF3D0F5C), Color(0xFF5A1580)],
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(32),
                bottomRight: Radius.circular(32),
              ),
            ),
            padding: const EdgeInsets.fromLTRB(20, 30, 20, 40),
            child: Stack(
              children: [
                const Positioned(
                  top: -20,
                  right: -20,
                  child: Opacity(
                    opacity: 0.08,
                    child: Text('🔱', style: TextStyle(fontSize: 120)),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'OM MURUGA',
                      style: TextStyle(
                        color: AppColors.orange,
                        fontSize: 13,
                        letterSpacing: 3,
                        fontFamily: 'monospace',
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      t.welcomeTitle,
                      style: const TextStyle(
                        color: AppColors.gold,
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      t.welcomeSub,
                      style: const TextStyle(
                        color: AppColors.white70,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: AppColors.gold.withOpacity(0.2)),
                      ),
                      child: Row(
                        children: [
                          const Text('🔍', style: TextStyle(fontSize: 16)),
                          const SizedBox(width: 10),
                          Expanded(
                            child: TextField(
                              onChanged: onSearchChanged,
                              style: const TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                hintText: t.searchPlaceholder,
                                hintStyle: const TextStyle(color: Colors.white54),
                                border: InputBorder.none,
                                isDense: true,
                                contentPadding: EdgeInsets.zero,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  t.featuredTemples,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1A0A2E),
                  ),
                ),
                TextButton(
                  onPressed: onViewAll,
                  child: Text(
                    t.seeAll,
                    style: TextStyle(color: Colors.purple[700], fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: displayList.map((temple) => TempleCard(
                temple: temple,
                onTap: () => onTempleSelected(temple),
                t: t,
              )).toList(),
            ),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
            child: Text(
              t.nextFestival,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1A0A2E),
              ),
            ),
          ),
          const SizedBox(height: 14),

          if (upcomingFestivals.isEmpty)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 10),
              child: Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  t.noUpcoming,
                  style: const TextStyle(color: Colors.grey),
                ),
              ),
            )
          else
            ...upcomingFestivals.map((f) {
              final diff = f.timeUntil;
              final days = diff.isNegative ? 0 : diff.inDays;
              final passed = f.hasPassed;

              return Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 10),
                child: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFFFF9F0), Color(0xFFFFF3E0)],
                    ),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.orange.withOpacity(0.3)),
                  ),
                  child: Row(
                    children: [
                      Text(f.emoji, style: const TextStyle(fontSize: 32)),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              f.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1A0A2E),
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              f.tamilName,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Color(0xFF9C27B0),
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              f.formattedDate,
                              style: const TextStyle(fontSize: 12, color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                      if (!passed)
                        Column(
                          children: [
                            Text(
                              '${days}d',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFE91E63),
                              ),
                            ),
                            Text(
                              t.days,
                              style: const TextStyle(fontSize: 11, color: Colors.grey),
                            ),
                          ],
                        )
                      else
                        const Icon(Icons.check_circle, color: Colors.grey, size: 22),
                    ],
                  ),
                ),
              );
            }),
        ],
      ),
    );
  }
}
