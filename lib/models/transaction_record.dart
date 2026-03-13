enum TransactionType { subscription, cancellation }

enum NotificationMethod { email, sms }

class TransactionRecord {
  final int fundId;
  final String fundName;
  final int amount;
  final DateTime timestamp;
  final TransactionType type;
  final NotificationMethod? notificationMethod;
  final String? destination;

  const TransactionRecord({
    required this.fundId,
    required this.fundName,
    required this.amount,
    required this.timestamp,
    required this.type,
    this.notificationMethod,
    this.destination,
  });
}
