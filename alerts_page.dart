import 'dart:async';
import 'package:flutter/material.dart';
import '../utils/app_strings.dart';
import '../services/notification_service.dart';
import '../services/festival_calendar.dart';

class AlertsPage extends StatefulWidget {
  final AppStrings t;
  final bool notifEnabled;
  final ValueChanged<bool> onNotifToggle;

  const AlertsPage({
    super.key,
    required this.t,
    required this.notifEnabled,
    required this.onNotifToggle,
  });

  @override
  State<AlertsPage> createState() => _AlertsPageState();
}

class _AlertsPageState extends State<AlertsPage> {
  late Timer _timer;
  Map<String, Duration> _countdowns = {};
  bool _togglingNotif = false;
  int _pendingCount = 0;
  List<FestivalInfo> _festivals = [];

  @override
  void initState() {
    super.initState();
    _festivals = FestivalCalendar.getFestivalsForCurrentYear();
    _tick();
    _loadPendingCount();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) => _tick());
  }

  void _tick() {
    final now = DateTime.now();
    final updated = <String, Duration>{};
    for (final f in _festivals) {
      updated[f.key] = f.date.difference(now);
    }
    if (mounted) setState(() => _countdowns = updated);
  }

  Future<void> _loadPendingCount() async {
    final pending = await NotificationService().getPendingNotifications();
    if (mounted) setState(() => _pendingCount = pending.length);
  }

  Future<void> _handleToggle(bool value) async {
    setState(() => _togglingNotif = true);
    try {
      if (value) {
        await NotificationService().requestPermission();
        await NotificationService().setEnabled(true);
        await NotificationService().sendTestNotification();
      } else {
        await NotificationService().setEnabled(false);
      }
      widget.onNotifToggle(value);
      await _loadPendingCount();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(value
              ? '🔔 ${widget.t.alarmSet}! ${widget.t.alarmsScheduled}.'
              : '🔕 ${widget.t.notifications} disabled.'),
          backgroundColor: value ? Colors.green[700] : Colors.grey[700],
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ));
      }
    } finally {
      if (mounted) setState(() => _togglingNotif = false);
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String _pad(int n) => n.toString().padLeft(2, '0');

  @override
  Widget build(BuildContext context) {
    final t = widget.t;
    final sorted = [..._festivals]
      ..sort((a, b) {
        if (a.hasPassed && !b.hasPassed) return 1;
        if (!a.hasPassed && b.hasPassed) return -1;
        return a.date.compareTo(b.date);
      });

    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 80),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [Color(0xFF1A0A2E), Color(0xFF7B1FA2)]),
            ),
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '🔔 ${t.alerts}',
                          style: const TextStyle(color: Color(0xFFFFD700), fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${t.autoUpdating} • ${DateTime.now().year}',
                          style: const TextStyle(color: Colors.white60, fontSize: 12),
                        ),
                      ],
                    ),
                    _togglingNotif
                        ? const SizedBox(width: 36, height: 36, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                        : Row(children: [
                            const Icon(Icons.notifications_rounded, color: Colors.white70, size: 20),
                            const SizedBox(width: 6),
                            Switch(
                              value: widget.notifEnabled,
                              onChanged: _handleToggle,
                              activeColor: const Color(0xFFFFD700),
                            ),
                          ]),
                  ],
                ),
                if (widget.notifEnabled && _pendingCount > 0)
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.white.withOpacity(0.3)),
                      ),
                      child: Text(
                        '✅ $_pendingCount ${t.alarmsScheduled}',
                        style: const TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
                  Text(t.festivalCountdown, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF1A0A2E))),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: const Color(0xFF9C27B0).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text('${DateTime.now().year}', style: const TextStyle(color: Color(0xFF9C27B0), fontSize: 12, fontWeight: FontWeight.bold)),
                  ),
                ]),
                const SizedBox(height: 4),
                Text(t.alarmRings, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                const SizedBox(height: 16),

                ...sorted.map((f) {
                  final diff = _countdowns[f.key] ?? Duration.zero;
                  final passed = diff.isNegative || f.hasPassed;

                  return Container(
                    margin: const EdgeInsets.only(bottom: 14),
                    decoration: BoxDecoration(
                      color: passed ? Colors.grey.withOpacity(0.05) : Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: passed ? Colors.grey.withOpacity(0.2) : const Color(0xFF9C27B0).withOpacity(0.15)),
                      boxShadow: passed ? [] : [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8, offset: const Offset(0, 2))],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(children: [
                            Text(f.emoji, style: TextStyle(fontSize: 24, color: passed ? Colors.grey : null)),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(f.name, style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: passed ? Colors.grey : const Color(0xFF1A0A2E))),
                                  Text(f.tamilName, style: TextStyle(fontSize: 12, color: passed ? Colors.grey : const Color(0xFF9C27B0))),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: f.isVerified ? Colors.green.withOpacity(0.1) : Colors.orange.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                f.isVerified ? '✓ Verified' : '~ Estimated',
                                style: TextStyle(fontSize: 10, color: f.isVerified ? Colors.green[700] : Colors.orange[700], fontWeight: FontWeight.bold),
                              ),
                            ),
                          ]),
                          const SizedBox(height: 12),
                          if (passed)
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(color: Colors.grey.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
                              child: Text('${f.formattedDate} — ${t.completedThisYear}', style: const TextStyle(color: Colors.grey, fontSize: 12)),
                            )
                          else ...[
                            Text(f.formattedDate, style: const TextStyle(color: Color(0xFF9C27B0), fontSize: 13, fontWeight: FontWeight.w600)),
                            const SizedBox(height: 8),
                            Row(children: [
                              _countBox(diff.inDays.abs().toString(), t.days),
                              const SizedBox(width: 6),
                              _countBox(_pad((diff.inHours % 24).abs()), t.hours),
                              const SizedBox(width: 6),
                              _countBox(_pad((diff.inMinutes % 60).abs()), t.mins),
                              const SizedBox(width: 6),
                              _countBox(_pad((diff.inSeconds % 60).abs()), 'Secs'),
                              const Spacer(),
                              if (widget.notifEnabled)
                                Row(children: [
                                  const Icon(Icons.alarm_on_rounded, color: Color(0xFF9C27B0), size: 16),
                                  const SizedBox(width: 4),
                                  Text(t.alarmSet, style: const TextStyle(color: Color(0xFF9C27B0), fontSize: 11, fontWeight: FontWeight.bold)),
                                ]),
                            ]),
                          ],
                        ],
                      ),
                    ),
                  );
                }),

                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.blue.withOpacity(0.15)),
                  ),
                  child: Row(children: [
                    const Icon(Icons.info_outline_rounded, color: Colors.blue, size: 16),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        t.autoUpdating,
                        style: const TextStyle(color: Colors.blue, fontSize: 11),
                      ),
                    ),
                  ]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _countBox(String val, String label) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: const Color(0xFF9C27B0).withOpacity(0.08),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(val, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF9C27B0))),
            Text(label, style: const TextStyle(fontSize: 9, color: Colors.grey)),
          ],
        ),
      );
}
