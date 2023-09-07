import 'package:flutter/material.dart';
import 'package:notifcation/models/notification_servcies.dart';
import 'package:notifcation/widgets/new_transaction.dart';

import '../models/transaction.dart';
import '../widgets/chart.dart';
import '../widgets/transaction_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  NotificationServices notificationServices = NotificationServices();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    notificationServices.requestnoficationpermission();
    notificationServices.firebaseInit(context);
    // notificationServices.isTokenrefresh();

    notificationServices.getdevicetoken().then((value) {
      print('Device Token');
      print(value);
    });
  }

  final List<Transaction> _userTransactions = [];
  List<Transaction> get _recentransctions {
    return _userTransactions.where((element) {
      return element.date.isAfter(
        DateTime.now().subtract(
          const Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addNewTransaction(
      String txTitle, double txAmount, DateTime choosendate) {
    final newTx = Transaction(
      title: txTitle,
      amount: txAmount,
      date: choosendate,
      id: DateTime.now().toString(),
    );

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          behavior: HitTestBehavior.opaque,
          child: NewTransaction(_addNewTransaction),
        );
      },
    );
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((tx) => tx.id == id);
    });
  }

  bool _Showcart = false;
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    final islandscape = mediaQuery.orientation == Orientation.landscape;

    final appBar = AppBar(
      elevation: 10,
      title: const Text(
        'Personal Expenses',
        style: TextStyle(fontFamily: 'Quicksand'),
      ),
    );
    final txListWidget = SizedBox(
      height: (mediaQuery.size.height -
              appBar.preferredSize.height -
              mediaQuery.padding.top) *
          0.7,
      child: TransactionList(_userTransactions, _deleteTransaction),
    );

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            if (islandscape)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text("Show Cart!!"),
                  Switch(
                      value: _Showcart,
                      onChanged: (val) {
                        setState(() {
                          _Showcart = val;
                        });
                      })
                ],
              ),
            if (islandscape)
              _Showcart
                  ? SizedBox(
                      height: (mediaQuery.size.height -
                              appBar.preferredSize.height -
                              mediaQuery.padding.top) *
                          0.7,
                      child: Chart(_recentransctions),
                    )
                  : txListWidget,
            if (!islandscape)
              SizedBox(
                height: (mediaQuery.size.height -
                        appBar.preferredSize.height -
                        mediaQuery.padding.top) *
                    0.3,
                child: Chart(_recentransctions),
              ),
            if (!islandscape) txListWidget,
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context),
      ),
    );
  }
}
