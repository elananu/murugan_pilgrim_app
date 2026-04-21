import 'package:flutter/material.dart';
import '../utils/app_strings.dart';
import '../services/feedback_service.dart';

class SettingsPage extends StatefulWidget {
  final AppStrings t;
  final String currentLang;
  final bool notifEnabled;
  final ValueChanged<String> onLangChanged;
  final ValueChanged<bool> onNotifToggle;

  const SettingsPage({
    super.key,
    required this.t,
    required this.currentLang,
    required this.notifEnabled,
    required this.onLangChanged,
    required this.onNotifToggle,
  });

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final _feedbackController = TextEditingController();
  String _feedbackType = 'General';
  bool _submitting = false;
  bool _submitted = false;
  String? _errorMessage;

  final List<Map<String, String>> _languages = [
    {'code': 'en', 'name': 'English', 'native': 'English'},
    {'code': 'ta', 'name': 'Tamil', 'native': 'தமிழ்'},
    {'code': 'hi', 'name': 'Hindi', 'native': 'हिन्दी'},
  ];

  @override
  void dispose() {
    _feedbackController.dispose();
    super.dispose();
  }

  Future<void> _submitFeedback() async {
    final message = _feedbackController.text.trim();
    if (message.isEmpty) {
      setState(() => _errorMessage = widget.t.shareThoughts);
      return;
    }
    setState(() { _submitting = true; _errorMessage = null; });
    final result = await FeedbackService().submitFeedback(type: _feedbackType, message: message);
    if (!mounted) return;
    if (result.success) {
      setState(() { _submitting = false; _submitted = true; });
    } else {
      setState(() { _submitting = false; _errorMessage = result.errorMessage; });
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = widget.t;

    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 80),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [Color(0xFF1A0A2E), Color(0xFF37474F)]),
            ),
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('⚙️ ${t.settings}', style: const TextStyle(color: Color(0xFFFFD700), fontSize: 22, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(t.preferencesInfo, style: const TextStyle(color: Colors.white60, fontSize: 13)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _sectionTitle(t.langSelect),
                const SizedBox(height: 10),
                ..._languages.map((lang) {
                  final isSelected = widget.currentLang == lang['code'];
                  return GestureDetector(
                    onTap: () => widget.onLangChanged(lang['code']!),
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                      decoration: BoxDecoration(
                        color: isSelected ? const Color(0xFF9C27B0).withOpacity(0.08) : Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: isSelected ? const Color(0xFF9C27B0) : Colors.grey[200]!, width: isSelected ? 2 : 1),
                        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8)],
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(lang['native']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                                Text(lang['name']!, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                              ],
                            ),
                          ),
                          if (isSelected) const Icon(Icons.check_circle, color: Color(0xFF9C27B0)),
                        ],
                      ),
                    ),
                  );
                }),

                const SizedBox(height: 20),
                _sectionTitle(t.notifications),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8)],
                  ),
                  child: Row(
                    children: [
                      const Text('🔔', style: TextStyle(fontSize: 24)),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(t.notifOn, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
                            Text(t.alarmRings, style: const TextStyle(color: Colors.grey, fontSize: 11)),
                          ],
                        ),
                      ),
                      Switch(value: widget.notifEnabled, onChanged: widget.onNotifToggle, activeColor: const Color(0xFF9C27B0)),
                    ],
                  ),
                ),

                const SizedBox(height: 20),
                _sectionTitle(t.feedback),
                const SizedBox(height: 6),
                Text(t.savedToFirebase, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                const SizedBox(height: 10),

                if (!_submitted) ...[
                  Wrap(
                    spacing: 8,
                    runSpacing: 6,
                    children: ['General', 'Bug', 'Feature', 'Temple Info'].map((type) {
                      final isSelected = _feedbackType == type;
                      return GestureDetector(
                        onTap: () => setState(() => _feedbackType = type),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                          decoration: BoxDecoration(
                            color: isSelected ? const Color(0xFF9C27B0) : Colors.grey[100],
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: isSelected ? const Color(0xFF9C27B0) : Colors.grey[300]!),
                          ),
                          child: Text(type, style: TextStyle(color: isSelected ? Colors.white : Colors.black87, fontSize: 13, fontWeight: isSelected ? FontWeight.bold : FontWeight.normal)),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _feedbackController,
                    maxLines: 4,
                    maxLength: 500,
                    decoration: InputDecoration(
                      hintText: t.shareThoughts,
                      errorText: _errorMessage,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
                      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: Color(0xFF9C27B0))),
                    ),
                    onChanged: (_) { if (_errorMessage != null) setState(() => _errorMessage = null); },
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _submitting ? null : _submitFeedback,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF9C27B0),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                      ),
                      child: _submitting
                          ? Row(mainAxisAlignment: MainAxisAlignment.center, children: [const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)), const SizedBox(width: 10), Text(t.submitFeedback)])
                          : Text(t.submitFeedback),
                    ),
                  ),
                ] else ...[
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE8F5E9),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: Colors.green.withOpacity(0.3)),
                    ),
                    child: Row(
                      children: [
                        const Text('🙏', style: TextStyle(fontSize: 28)),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(t.thankYou, style: const TextStyle(color: Colors.green, fontWeight: FontWeight.w600, fontSize: 15)),
                              const SizedBox(height: 4),
                              Text(t.savedToFirebase, style: const TextStyle(color: Colors.green, fontSize: 12)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextButton(
                    onPressed: () => setState(() { _submitted = false; _feedbackController.clear(); }),
                    child: Text(t.submitAnother),
                  ),
                ],

                const SizedBox(height: 20),
                _sectionTitle(t.appInfo),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8)],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Text('🪷', style: TextStyle(fontSize: 28)),
                          const SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(t.appName, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                              Text(t.version, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      const Divider(),
                      const SizedBox(height: 8),
                      Text(t.purpose, style: const TextStyle(color: Colors.black54, fontSize: 13, height: 1.5)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF1A0A2E)));
  }
}
