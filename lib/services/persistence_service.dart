import 'dart:convert';
import 'package:btg_bank/models/transaction_record.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PersistenceService {
  static const String _keyBalance = 'user_balance';
  static const String _keySubscribedFunds = 'subscribed_fund_ids';
  static const String _keyTransactions = 'user_transactions';

  Future<void> saveBalance(int balance) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_keyBalance, balance);
  }

  Future<int?> getBalance() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_keyBalance);
  }

  Future<void> saveSubscribedFundIds(Set<int> ids) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(
      _keySubscribedFunds,
      ids.map((id) => id.toString()).toList(),
    );
  }

  Future<Set<int>> getSubscribedFundIds() async {
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList(_keySubscribedFunds);
    if (list == null) return {};
    return list.map((e) => int.parse(e)).toSet();
  }

  Future<void> saveTransactions(List<TransactionRecord> transactions) async {
    final prefs = await SharedPreferences.getInstance();
    final String encodedData = jsonEncode(
      transactions.map((t) => t.toJson()).toList(),
    );
    await prefs.setString(_keyTransactions, encodedData);
  }

  Future<List<TransactionRecord>> getTransactions() async {
    final prefs = await SharedPreferences.getInstance();
    final String? encodedData = prefs.getString(_keyTransactions);
    if (encodedData == null) return [];

    final List<dynamic> decodedData = jsonDecode(encodedData);
    return decodedData
        .map((item) => TransactionRecord.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
