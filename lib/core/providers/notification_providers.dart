import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../services/notification_service.dart';
import 'repository_providers.dart';

/// App-wide notification service (daily reminder + milestone alerts).
final notificationServiceProvider = Provider<NotificationService>((ref) {
  return NotificationService(
    logRepo: ref.watch(notificationRepositoryProvider),
  );
});
