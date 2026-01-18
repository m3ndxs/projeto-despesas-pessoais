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
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TransactionList(transactions: _transactions),
        TransactionForm(),
      ],
    );
  }
}