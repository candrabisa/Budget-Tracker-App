import 'package:budget_tracker_app/models/transaction_item.dart';
import 'package:budget_tracker_app/services/local_storage_service.dart';
import 'package:flutter/material.dart';

class BudgetViewModel extends ChangeNotifier {
  double getBudget() => LocalStorageService().getBudget();
  double getBalace() => LocalStorageService().getBalance();
  List<TransactionItem> get items => LocalStorageService().getAllTransactions();

  set budget(double value) {
    LocalStorageService().saveBudget(value);
    notifyListeners();
  }

  void addItem(TransactionItem item) {
    LocalStorageService().saveTransactionItem(item);
    notifyListeners();
  }

  void deleteITem(TransactionItem item) {
    final localStorage = LocalStorageService();
    localStorage.deleteTransactionItem(item);
    notifyListeners();
  }
  // double _budget = 2000.0;

  // double get budget => _budget;

  // double balance = 0.0;

  // List<TransactionItem> _items = [];

  // List<TransactionItem> get items => _items;

  // set budget(double value) {
  //   _budget = value;
  //   notifyListeners();
  // }

  // void addItem(TransactionItem item) {
  //   _items.add(item);
  //   updateBalance(item);
  //   notifyListeners();
  // }

  // void updateBalance(TransactionItem item) {
  //   if (item.isExpense) {
  //     balance += item.amount;
  //   } else {
  //     balance -= item.amount;
  //   }
  // }
}
