import 'dart:collection';

import 'package:btg_bank/models/fund.dart';
import 'package:btg_bank/models/transaction_record.dart';
import 'package:btg_bank/services/mock_fund_api_service.dart';
import 'package:btg_bank/services/persistence_service.dart';
import 'package:flutter/material.dart';

class FundProvider extends ChangeNotifier {
  FundProvider({
    MockFundApiService? fundApiService,
    PersistenceService? persistenceService,
  }) : _fundApiService = fundApiService ?? MockFundApiService(),
       _persistenceService = persistenceService ?? PersistenceService();

  static const int initialBalance = 500000;

  final MockFundApiService _fundApiService;
  final PersistenceService _persistenceService;

  int _balance = initialBalance;
  bool _isLoading = false;
  String? _error;

  final List<Fund> _funds = <Fund>[];
  final Set<int> _subscribedFundIds = <int>{};
  final List<TransactionRecord> _transactions = <TransactionRecord>[];

  // Search and Filter
  String _searchQuery = '';
  String _selectedCategory = 'Todos';

  int get balance => _balance;
  bool get isLoading => _isLoading;
  String? get error => _error;
  UnmodifiableListView<Fund> get funds => UnmodifiableListView(_funds);
  UnmodifiableListView<TransactionRecord> get transactions =>
      UnmodifiableListView(_transactions);

  String get searchQuery => _searchQuery;
  String get selectedCategory => _selectedCategory;

  List<String> get categories {
    final cats = _funds.map((f) => f.category).toSet().toList();
    cats.sort();
    return ['Todos', ...cats];
  }

  List<Fund> get filteredFunds {
    return _funds.where((fund) {
      final matchesSearch = fund.name.toLowerCase().contains(_searchQuery.toLowerCase());
      final matchesCategory = _selectedCategory == 'Todos' || fund.category == _selectedCategory;
      return matchesSearch && matchesCategory;
    }).toList();
  }

  bool isSubscribed(int fundId) => _subscribedFundIds.contains(fundId);

  void updateSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void updateSelectedCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
  }

  Future<void> initialize() async {
    final savedBalance = await _persistenceService.getBalance();
    _balance = savedBalance ?? initialBalance;

    _subscribedFundIds.clear();
    _subscribedFundIds.addAll(await _persistenceService.getSubscribedFundIds());

    _transactions.clear();
    _transactions.addAll(await _persistenceService.getTransactions());

    notifyListeners();
  }

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

  Future<String?> subscribeToFund({
    required Fund fund,
    required NotificationMethod notificationMethod,
    required String destination,
  }) async {
    if (_subscribedFundIds.contains(fund.id)) {
      return 'Ya te encuentras suscrito a este fondo.';
    }

    if (_balance < fund.minimumAmount) {
      return 'No tienes saldo disponible para vincularte al fondo ${fund.name}.';
    }

    _balance -= fund.minimumAmount;
    _subscribedFundIds.add(fund.id);

    final transaction = TransactionRecord(
      fundId: fund.id,
      fundName: fund.name,
      amount: fund.minimumAmount,
      timestamp: DateTime.now(),
      type: TransactionType.subscription,
      notificationMethod: notificationMethod,
      destination: destination,
    );

    _transactions.insert(0, transaction);

    await _persistenceService.saveBalance(_balance);
    await _persistenceService.saveSubscribedFundIds(_subscribedFundIds);
    await _persistenceService.saveTransactions(_transactions);

    notifyListeners();
    return null;
  }

  Future<String?> cancelFund(Fund fund) async {
    if (!_subscribedFundIds.contains(fund.id)) {
      return 'No tienes una suscripcion activa para este fondo.';
    }

    _subscribedFundIds.remove(fund.id);
    _balance += fund.minimumAmount;

    final transaction = TransactionRecord(
      fundId: fund.id,
      fundName: fund.name,
      amount: fund.minimumAmount,
      timestamp: DateTime.now(),
      type: TransactionType.cancellation,
    );

    _transactions.insert(0, transaction);

    await _persistenceService.saveBalance(_balance);
    await _persistenceService.saveSubscribedFundIds(_subscribedFundIds);
    await _persistenceService.saveTransactions(_transactions);

    notifyListeners();
    return null;
  }
}
