import 'package:flutter/material.dart';
import '../data/temple_data.dart';
import '../utils/app_strings.dart';
import '../utils/app_theme.dart';
import '../widgets/temple_card.dart';

class TemplesPage extends StatelessWidget {
  final AppStrings t;
  final String searchQuery;
  final ValueChanged<String> onSearchChanged;
  final ValueChanged<Temple> onTempleSelected;

  const TemplesPage({
    super.key,
    required this.t,
    required this.searchQuery,
    required this.onSearchChanged,
    required this.onTempleSelected,
  });

  @override
  Widget build(BuildContext context) {
    final filtered = temples.where((temple) {
      final q = searchQuery.toLowerCase();
      return temple.name.toLowerCase().contains(q) ||
          temple.location.toLowerCase().contains(q);
    }).toList();

    return Column(
      children: [
        Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF1A0A2E), Color(0xFF4A1060)],
            ),
          ),
          padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '🛕 ${t.temples}',
                style: const TextStyle(
                  color: AppColors.gold,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                t.subtitle,
                style: const TextStyle(color: Colors.white60, fontSize: 13),
              ),
              const SizedBox(height: 16),
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
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 80),
            itemCount: filtered.length,
            itemBuilder: (context, i) => TempleCard(
              temple: filtered[i],
              onTap: () => onTempleSelected(filtered[i]),
              t: t,
            ),
          ),
        ),
      ],
    );
  }
}
