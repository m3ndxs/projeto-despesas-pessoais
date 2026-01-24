import 'dart:math';

import 'package:flutter/material.dart';
import './transaction_form.dart';
import './transaction_list.dart';
import '../models/transaction.dart';

class TransactionUser extends StatefulWidget {
  const TransactionUser({super.key});

  @override
  State<TransactionUser> createState() => _TransactionUserState();
}

class _TransactionUserState extends State<TransactionUser> {
  final _transactions = [
    Transaction(
      id: 't1',
      title: 'Spider Man 2',
      value: 200.00,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      title: 'Compras Supermercado',
      value: 341.20,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't45',
      title: 'Compras #03',
      value: 341.20,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't3',
      title: 'Compras #04',
      value: 341.20,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't4',
      title: 'Compras #05',
      value: 341.20,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't5',
      title: 'Compras #06',
      value: 341.20,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't6',
      title: 'Compras #07',
      value: 341.20,
      date: DateTime.now(),
    ),
  ];

  dynamic _addTransaction(String title, double value){
    final newTransaction = Transaction(
      id: Random().nextDouble().toString(),
      title: title,
      value: value,
      date: DateTime.now()
    );

    setState(() {
      _transactions.add(newTransaction);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TransactionForm(onSubmit: _addTransaction),
        TransactionList(transactions: _transactions), 
      ],
    );
  }
}