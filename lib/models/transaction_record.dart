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

  factory TransactionRecord.fromJson(Map<String, dynamic> json) {
    return TransactionRecord(
      fundId: json['fundId'] as int,
      fundName: json['fundName'] as String,
      amount: json['amount'] as int,
      timestamp: DateTime.parse(json['timestamp'] as String),
      type: TransactionType.values.firstWhere(
        (e) => e.name == json['type'],
        orElse: () => TransactionType.subscription,
      ),
      notificationMethod: json['notificationMethod'] != null
          ? NotificationMethod.values.firstWhere(
              (e) => e.name == json['notificationMethod'],
              orElse: () => NotificationMethod.email,
            )
          : null,
      destination: json['destination'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fundId': fundId,
      'fundName': fundName,
      'amount': amount,
      'timestamp': timestamp.toIso8601String(),
      'type': type.name,
      'notificationMethod': notificationMethod?.name,
      'destination': destination,
    };
  }
}
