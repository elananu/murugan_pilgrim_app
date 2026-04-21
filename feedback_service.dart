import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class FeedbackService {
  static final FeedbackService _instance = FeedbackService._internal();
  factory FeedbackService() => _instance;
  FeedbackService._internal();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // ── Submit feedback to Firestore ─────────────────────────────
  // Collection: "feedback"
  // Document fields:
  //   type      : String  (General / Bug / Feature / Temple Info)
  //   message   : String
  //   timestamp : Timestamp
  //   appVersion: String
  //   platform  : String  (android / ios)
  Future<FeedbackResult> submitFeedback({
    required String type,
    required String message,
  }) async {
    if (message.trim().isEmpty) {
      return FeedbackResult.error('Message cannot be empty');
    }

    try {
      await _db.collection('feedback').add({
        'type': type,
        'message': message.trim(),
        'timestamp': FieldValue.serverTimestamp(),
        'appVersion': '1.0.0',
        'platform': defaultTargetPlatform == TargetPlatform.android
            ? 'android'
            : 'ios',
      });
      debugPrint('✅ Feedback submitted to Firestore');
      return FeedbackResult.success();
    } on FirebaseException catch (e) {
      debugPrint('❌ Firestore error: ${e.message}');
      return FeedbackResult.error(
          'Could not submit feedback. Please check your internet connection.');
    } catch (e) {
      debugPrint('❌ Unknown error: $e');
      return FeedbackResult.error('Something went wrong. Please try again.');
    }
  }
}

class FeedbackResult {
  final bool success;
  final String? errorMessage;

  const FeedbackResult._({required this.success, this.errorMessage});

  factory FeedbackResult.success() =>
      const FeedbackResult._(success: true);

  factory FeedbackResult.error(String message) =>
      FeedbackResult._(success: false, errorMessage: message);
}
