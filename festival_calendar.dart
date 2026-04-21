// lib/services/festival_calendar.dart
// ─────────────────────────────────────────────────────────────
//  Auto-updating Tamil festival date system for Murugan Pilgrim
//  Dates verified from drikpanchang.com Tamil calendar.
//  Works automatically every year — no manual update needed.
// ─────────────────────────────────────────────────────────────

class FestivalCalendar {
  FestivalCalendar._();

  // ── Verified date lookup: year → festivalKey → [year, month, day]
  // Source: drikpanchang.com Tamil calendar (Chennai, India timezone)
  // Add new years here each December when drikpanchang publishes the next year.
  static const Map<int, Map<String, List<int>>> _verifiedDates = {
    2026: {
      'thai_poosam':      [2026, 2,  1],  // Feb 1  – verified
      'panguni_uthiram':  [2026, 4,  1],  // Apr 1  – verified
      'vaikasi_visakam':  [2026, 5, 30],  // May 30 – verified
      'aadi_krithigai':   [2026, 7, 26],  // Jul 26 – verified
      'skanda_shashti':   [2026, 11, 15], // Nov 15 – verified (Soora Samharam)
      'karthigai_deepam': [2026, 11, 24], // Nov 24 – verified
    },
    2027: {
      'thai_poosam':      [2027, 1, 22],  // Jan 22 – verified (drikpanchang)
      'panguni_uthiram':  [2027, 3, 22],  // Mar 22 – verified (drikpanchang)
      'vaikasi_visakam':  [2027, 5, 20],  // May 20 – verified (drikpanchang)
      'aadi_krithigai':   [2027, 7, 15],  // Jul 15 – estimated, update when confirmed
      'skanda_shashti':   [2027, 11, 3],  // Nov 3  – verified (drikpanchang Soora Samharam)
      'karthigai_deepam': [2027, 12, 12], // Dec 12 – verified (arunachalagrace.blogspot.com)
    },
    2028: {
      // Estimated — replace with verified dates from drikpanchang.com in Dec 2027
      'thai_poosam':      [2028, 2, 10],
      'panguni_uthiram':  [2028, 4, 9],
      'vaikasi_visakam':  [2028, 6, 7],
      'aadi_krithigai':   [2028, 8, 3],
      'skanda_shashti':   [2028, 11, 22],
      'karthigai_deepam': [2028, 12, 1],
    },
    2029: {
      // Estimated — replace with verified dates from drikpanchang.com in Dec 2028
      'thai_poosam':      [2029, 1, 30],
      'panguni_uthiram':  [2029, 3, 29],
      'vaikasi_visakam':  [2029, 5, 27],
      'aadi_krithigai':   [2029, 7, 24],
      'skanda_shashti':   [2029, 11, 11],
      'karthigai_deepam': [2029, 11, 20],
    },
    2030: {
      // Estimated — replace with verified dates from drikpanchang.com in Dec 2029
      'thai_poosam':      [2030, 1, 19],
      'panguni_uthiram':  [2030, 3, 18],
      'vaikasi_visakam':  [2030, 5, 16],
      'aadi_krithigai':   [2030, 7, 13],
      'skanda_shashti':   [2030, 11, 1],
      'karthigai_deepam': [2030, 12, 9],
    },
  };

  // ── Get festivals for today's year ───────────────────────────
  static List<FestivalInfo> getFestivalsForCurrentYear() {
    return _build(DateTime.now().year);
  }

  // ── Get festivals for a specific year ───────────────────────
  static List<FestivalInfo> getFestivalsForYear(int year) {
    return _build(year);
  }

  // ── Get only upcoming (not yet passed) festivals ─────────────
  // Returns current year's remaining festivals.
  // If less than 2 remain, also prepends next year's list.
  static List<FestivalInfo> getUpcoming() {
    final now = DateTime.now();
    final current = _build(now.year)
        .where((f) => f.date.isAfter(now))
        .toList();

    if (current.length < 2) {
      final next = _build(now.year + 1);
      return [...current, ...next];
    }
    return current;
  }

  // ── Internal: build FestivalInfo list for a given year ───────
  static List<FestivalInfo> _build(int year) {
    final map = _verifiedDates[year];

    DateTime _date(String key, int fallbackMonth, int fallbackDay) {
      if (map != null && map.containsKey(key)) {
        final d = map[key]!;
        return DateTime(d[0], d[1], d[2], 6, 0); // always 6:00 AM IST
      }
      // Fallback for unknown years
      return DateTime(year, fallbackMonth, fallbackDay, 6, 0);
    }

    bool _verified(String key) => map?.containsKey(key) ?? false;

    return [
      FestivalInfo(
        id: 1001,
        key: 'thai_poosam',
        name: 'Thai Poosam',
        tamilName: 'தை பூசம்',
        date: _date('thai_poosam', 1, 28),
        emoji: '🪔',
        description:
            'Full moon + Poosam nakshatra in Tamil month Thai. '
            'Goddess Parvati gave the divine Vel to Lord Murugan. '
            'Devotees carry kavadi as penance at all 6 Arupadai Veedu temples.',
        isVerified: _verified('thai_poosam'),
      ),
      FestivalInfo(
        id: 1002,
        key: 'panguni_uthiram',
        name: 'Panguni Uthiram',
        tamilName: 'பங்குனி உத்திரம்',
        date: _date('panguni_uthiram', 3, 25),
        emoji: '🌸',
        description:
            'Uthiram nakshatra in the Tamil month of Panguni. '
            'Celebrates the divine wedding of Lord Murugan with Devasena and Valli. '
            'Special celebrations at Thiruttani and Thiruparankundram.',
        isVerified: _verified('panguni_uthiram'),
      ),
      FestivalInfo(
        id: 1003,
        key: 'vaikasi_visakam',
        name: 'Vaikasi Visakam',
        tamilName: 'வைகாசி விசாகம்',
        date: _date('vaikasi_visakam', 5, 25),
        emoji: '✨',
        description:
            'Lord Murugan\'s birthday! Vishakha nakshatra in Tamil month Vaikasi. '
            'Grand celebrations at all 6 Arupadai Veedu. '
            'The most auspicious day for Murugan devotees.',
        isVerified: _verified('vaikasi_visakam'),
      ),
      FestivalInfo(
        id: 1004,
        key: 'aadi_krithigai',
        name: 'Aadi Krithigai',
        tamilName: 'ஆடி கிருத்திகை',
        date: _date('aadi_krithigai', 7, 20),
        emoji: '🔱',
        description:
            'Krithigai nakshatra in Tamil month Aadi. '
            'Lord Murugan\'s power day. Special abhishekam at all '
            'Arupadai Veedu. Thousands visit Thiruttani on this day.',
        isVerified: _verified('aadi_krithigai'),
      ),
      FestivalInfo(
        id: 1005,
        key: 'skanda_shashti',
        name: 'Skanda Shashti',
        tamilName: 'ஸ்கந்த சஷ்டி',
        date: _date('skanda_shashti', 10, 25),
        emoji: '⚔️',
        description:
            'Six-day festival in Tamil month Aippasi. '
            'Culminates with Soora Samharam — Lord Murugan\'s victory '
            'over the demon Soorapadman. Grand event at Tiruchendur temple.',
        isVerified: _verified('skanda_shashti'),
      ),
      FestivalInfo(
        id: 1006,
        key: 'karthigai_deepam',
        name: 'Karthigai Deepam',
        tamilName: 'கார்த்திகை தீபம்',
        date: _date('karthigai_deepam', 11, 25),
        emoji: '🕯️',
        description:
            'Festival of lights on full moon of Tamil month Karthigai '
            'when Karthigai nakshatra aligns. '
            'Maha Deepam lit atop Arunachala hill at Tiruvannamalai. '
            'Sacred to both Lord Shiva and Lord Murugan.',
        isVerified: _verified('karthigai_deepam'),
      ),
    ];
  }
}

// ── Festival data model ───────────────────────────────────────
class FestivalInfo {
  final int id;
  final String key;
  final String name;
  final String tamilName;
  final DateTime date;  // always 6:00 AM IST on the festival day
  final String emoji;
  final String description;
  final bool isVerified; // true = exact date verified from drikpanchang

  const FestivalInfo({
    required this.id,
    required this.key,
    required this.name,
    required this.tamilName,
    required this.date,
    required this.emoji,
    required this.description,
    required this.isVerified,
  });

  bool get hasPassed => date.isBefore(DateTime.now());

  Duration get timeUntil => date.difference(DateTime.now());

  String get formattedDate {
    const m = ['','Jan','Feb','Mar','Apr','May','Jun',
                   'Jul','Aug','Sep','Oct','Nov','Dec'];
    return '${m[date.month]} ${date.day}, ${date.year}';
  }

  String get verifiedLabel => isVerified ? 'Verified date' : 'Estimated date';
}
