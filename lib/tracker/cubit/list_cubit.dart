import 'package:bloc/bloc.dart';
import 'dart:math';

class TrackerCubit extends Cubit<List<Map<String, dynamic>>> {
  TrackerCubit() : super([]);

  void increment(int id, num? amount, String label, bool debit) {
    Map<String, dynamic> map = {
      'id': id,
      'amount': amount,
      'label': label,
      'bool': debit
    };

    List<Map<String, dynamic>> mapList = [map];
    List<Map<String, dynamic>> newState =
        map['label'] == '' || map['amount'] == null ? state : state + mapList;

    emit(newState);
  }

  void decrement(int id, num? amount, String label, bool debit) {
    Map<String, dynamic> map = {
      'id': id,
      'amount': amount,
      'label': label,
      'bool': debit
    };

    List<Map<String, dynamic>> mapList = [map];
    List<Map<String, dynamic>> newState =
        map['label'] == '' || map['amount'] == null ? state : state + mapList;

    emit(newState);
  }

  void remove(Map<String, dynamic> i) {
    List<Map<String, dynamic>> list = [i];
    var removedState = (state.toSet().difference(list.toSet())).toList();
    emit(removedState);
  }

  double balance = 0;

  double doubleBalance(List state) {
    for (Map<String, dynamic> entry in state) {
      if (entry['bool'] == true) {
        balance += entry['amount'];
      } else {
        balance -= entry['amount'];
      }
    }
    return balance;
  }

  String getBalance(List state) {
    for (Map<String, dynamic> entry in state) {
      if (entry['bool'] == true) {
        balance += entry['amount'];
      } else {
        balance -= entry['amount'];
      }
    }
    String stringBalance = '₱' + balance.toStringAsFixed(2);
    return stringBalance;
  }

  String totalDebit(List state) {
    for (Map<String, dynamic> entry in state) {
      if (entry['bool']) {
        balance += entry['amount'];
      }
    }
    String stringBalance =
        balance == 0 ? '-' : '₱' + balance.toStringAsFixed(2);
    return stringBalance;
  }

  String totalCredit(List state) {
    for (Map<String, dynamic> entry in state) {
      if (!entry['bool']) {
        balance += entry['amount'];
      }
    }
    String stringBalance =
        balance == 0 ? '-' : '₱' + balance.toStringAsFixed(2);

    return stringBalance;
  }
}
