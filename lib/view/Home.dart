
// import 'package:flutter/material.dart';
// import 'package:notifcation/widgets/chart.dart';
// import 'package:notifcation/widgets/new_transaction.dart';
// import 'package:notifcation/widgets/transaction_list.dart';

// import '../models/transaction.dart';
// class MyHomePage extends StatefulWidget {
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   final List<Transaction> _userTransactions = [];
//   List<Transaction> get _recentransctions {
//     return _userTransactions.where((element) {
//       return element.date.isAfter(
//         DateTime.now().subtract(
//           Duration(days: 7),
//         ),
//       );
//     }).toList();
//   }

//   void _addNewTransaction(
//       String txTitle, double txAmount, DateTime choosendate) {
//     final newTx = Transaction(
//       title: txTitle,
//       amount: txAmount,
//       date: choosendate,
//       id: DateTime.now().toString(),
//     );

//     setState(() {
//       _userTransactions.add(newTx);
//     });
//   }

//   void _startAddNewTransaction(BuildContext ctx) {
//     showModalBottomSheet(
//       context: ctx,
//       builder: (_) {
//         return GestureDetector(
//           onTap: () {},
//           child: NewTransaction(_addNewTransaction),
//           behavior: HitTestBehavior.opaque,
//         );
//       },
//     );
//   }

//   void _deleteTransaction(String id) {
//     setState(() {
//       _userTransactions.removeWhere((tx) => tx.id == id);
//     });
//   }

//   bool _Showcart = false;
//   @override
//   Widget build(BuildContext context) {
//     final mediaQuery = MediaQuery.of(context);

//     final islandscape = mediaQuery.orientation == Orientation.landscape;

//     final appBar = AppBar(
//       elevation: 10,
//       title: Text(
//         'Personal Expenses',
//         style: TextStyle(fontFamily: 'Quicksand'),
//       ),
//     );
//     final txListWidget = Container(
//       height: (mediaQuery.size.height -
//               appBar.preferredSize.height -
//               mediaQuery.padding.top) *
//           0.7,
//       child: TransactionList(_userTransactions, _deleteTransaction),
//     );

//     return Scaffold(
//       appBar: appBar,
//       body: SingleChildScrollView(
//         child: Column(
//           children: <Widget>[
//             if (islandscape)
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   Text("Show Cart!!"),
//                   Switch(
//                       value: _Showcart,
//                       onChanged: (val) {
//                         setState(() {
//                           _Showcart = val;
//                         });
//                       })
//                 ],
//               ),
//             if (islandscape)
//               _Showcart
//                   ? Container(
//                       height: (mediaQuery.size.height -
//                               appBar.preferredSize.height -
//                               mediaQuery.padding.top) *
//                           0.7,
//                       child: Chart(_recentransctions),
//                     )
//                   : txListWidget,
//             if (!islandscape)
//               Container(
//                 height: (mediaQuery.size.height -
//                         appBar.preferredSize.height -
//                         mediaQuery.padding.top) *
//                     0.3,
//                 child: Chart(_recentransctions),
//               ),
//             if (!islandscape) txListWidget,
//           ],
//         ),
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
//       floatingActionButton: FloatingActionButton(
//         child: Icon(Icons.add),
//         onPressed: () => _startAddNewTransaction(context),
//       ),
//     );
//   }
// }
