import 'dart:collection';

import 'package:btg_bank/models/fund.dart';
import 'package:btg_bank/models/transaction_record.dart';
import 'package:btg_bank/services/mock_fund_api_service.dart';
import 'package:flutter/material.dart';

class FundProvider extends ChangeNotifier {
  FundProvider({MockFundApiService? fundApiService})
    : _fundApiService = fundApiService ?? MockFundApiService();

  static const int initialBalance = 500000;

  final MockFundApiService _fundApiService;

  int _balance = initialBalance;
  bool _isLoading = false;
  String? _error;

  final List<Fund> _funds = <Fund>[];
  final Set<int> _subscribedFundIds = <int>{};
  final List<TransactionRecord> _transactions = <TransactionRecord>[];

  int get balance => _balance;
  bool get isLoading => _isLoading;
  String? get error => _error;
  UnmodifiableListView<Fund> get funds => UnmodifiableListView(_funds);
  UnmodifiableListView<TransactionRecord> get transactions =>
      UnmodifiableListView(_transactions);

  bool isSubscribed(int fundId) => _subscribedFundIds.contains(fundId);

  Future<void> loadFunds() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final List<Fund> result = await _fundApiService.fetchAvailableFunds();
      _funds
        ..clear()
        ..addAll(result);
    } catch (_) {
      _error = 'No fue posible cargar los fondos. Intenta nuevamente.';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  String? subscribeToFund({
    required Fund fund,
    required NotificationMethod notificationMethod,
    required String destination,
  }) {
    if (_subscribedFundIds.contains(fund.id)) {
      return 'Ya te encuentras suscrito a este fondo.';
    }

    if (_balance < fund.minimumAmount) {
      return 'No tienes saldo disponible para vincularte al fondo ${fund.name}.';
    }

    _balance -= fund.minimumAmount;
    _subscribedFundIds.add(fund.id);
    _transactions.insert(
      0,
      TransactionRecord(
        fundId: fund.id,
        fundName: fund.name,
        amount: fund.minimumAmount,
        timestamp: DateTime.now(),
        type: TransactionType.subscription,
        notificationMethod: notificationMethod,
        destination: destination,
      ),
    );

    notifyListeners();
    return null;
  }

  String? cancelFund(Fund fund) {
    if (!_subscribedFundIds.contains(fund.id)) {
      return 'No tienes una suscripcion activa para este fondo.';
    }

    _subscribedFundIds.remove(fund.id);
    _balance += fund.minimumAmount;
    _transactions.insert(
      0,
      TransactionRecord(
        fundId: fund.id,
        fundName: fund.name,
        amount: fund.minimumAmount,
        timestamp: DateTime.now(),
        type: TransactionType.cancellation,
      ),
    );

    notifyListeners();
    return null;
  }
}
