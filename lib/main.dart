import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'dart:math';

import '/components/chart.dart';
import '/components/transaction_form.dart';
import 'components/transaction_list.dart';
import 'models/transaction.dart';

void main() => runApp(ExpensesApp());

class ExpensesApp extends StatelessWidget {
  ExpensesApp({super.key});

  final ThemeData tema = ThemeData();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: const Locale('pt', 'BR'),
      supportedLocales: const [Locale('pt', 'BR'), Locale('en', 'US')],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
      theme: ThemeData(
        useMaterial3: false,
        appBarTheme: AppBarTheme(
          titleTextStyle: TextStyle(fontFamily: 'OpenSans', fontSize: 20),
          backgroundColor: Color(0xFF121212),
          foregroundColor: Colors.white70,
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color(0xFF1E2A38),
          primary: Color(0xFF1E2A38),
          secondary: Color(0xFFFFB703),
          brightness: Brightness.dark,
        ),
        fontFamily: 'QuickSand',
        textTheme: ThemeData.dark().textTheme.copyWith(
          titleLarge: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          labelStyle: TextStyle(color: Colors.white70),
          floatingLabelStyle: TextStyle(color: Colors.white70),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade600),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white70, width: 2),
          ),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transactions = [
    Transaction(
      id: 't1',
      title: 'Supermercado',
      value: 180.50,
      date: DateTime.now().subtract(const Duration(days: 1)),
      category: 'Alimentação',
    ),
    Transaction(
      id: 't2',
      title: 'Uber',
      value: 32.90,
      date: DateTime.now().subtract(const Duration(days: 2)),
      category: 'Transporte',
    ),
    Transaction(
      id: 't3',
      title: 'Cinema',
      value: 45.00,
      date: DateTime.now().subtract(const Duration(days: 3)),
      category: 'Lazer',
    ),
    Transaction(
      id: 't4',
      title: 'Roupas',
      value: 250.00,
      date: DateTime.now().subtract(const Duration(days: 4)),
      category: 'Compras',
    ),
    Transaction(
      id: 't5',
      title: 'Restaurante',
      value: 89.90,
      date: DateTime.now().subtract(const Duration(days: 5)),
      category: 'Alimentação',
    ),
    Transaction(
      id: 't6',
      title: 'Gasolina',
      value: 120.00,
      date: DateTime.now().subtract(const Duration(days: 6)),
      category: 'Transporte',
    ),
    Transaction(
      id: 't7',
      title: 'Streaming',
      value: 39.90,
      date: DateTime.now().subtract(const Duration(days: 8)),
      category: 'Lazer',
    ),
    Transaction(
      id: 't8',
      title: 'Farmácia',
      value: 67.30,
      date: DateTime.now().subtract(const Duration(days: 10)),
      category: 'Outros',
    ),
    Transaction(
      id: 't9',
      title: 'Lanche',
      value: 24.50,
      date: DateTime.now().subtract(const Duration(days: 0)),
      category: 'Alimentação',
    ),
    Transaction(
      id: 't10',
      title: 'Assinatura Cloud',
      value: 59.99,
      date: DateTime.now().subtract(const Duration(days: 12)),
      category: 'Outros',
    ),
  ];

  List<Transaction> get _recentTransactions {
    return _transactions.where((transaction) {
      return transaction.date.isAfter(
        DateTime.now().subtract(Duration(days: 7)),
      );
    }).toList();
  }

  dynamic _addTransaction(
    String title,
    double value,
    DateTime date,
    String category,
  ) {
    final newTransaction = Transaction(
      id: Random().nextDouble().toString(),
      title: title,
      value: value,
      date: date,
      category: category,
    );

    setState(() {
      _transactions.add(newTransaction);
    });

    Navigator.of(context).pop();
  }

  dynamic _removeTransaction(String id) {
    setState(() {
      _transactions.removeWhere((transaction) => transaction.id == id);
    });
  }

  dynamic _openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return TransactionForm(onSubmit: _addTransaction);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Despesas Pessoais', style: TextStyle(fontSize: 22)),
        actions: <Widget>[
          IconButton(
            onPressed: () => _openTransactionFormModal(context),
            icon: Icon(Icons.add),
            color: Colors.white,
            iconSize: 30,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Chart(recentTransaction: _recentTransactions),
            TransactionList(
              transactions: _transactions,
              onRemove: _removeTransaction,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.primary,
        onPressed: () => _openTransactionFormModal(context),
        child: Icon(Icons.add, color: Colors.white, size: 30),
      ),
    );
  }
}
