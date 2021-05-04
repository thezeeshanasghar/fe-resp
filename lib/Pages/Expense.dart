import 'package:flutter/material.dart';

class ExpensesList extends StatefulWidget {
  @override
  _ExpensesListState createState() => _ExpensesListState();
}

class _ExpensesListState extends State<ExpensesList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text("Expenses List"),
        centerTitle: false,
        backgroundColor: Colors.grey,
        elevation: 0.0,
      ),
      body: ExpenseList(),
    );
  }
}

class ExpenseList extends StatefulWidget {
  @override
  _ExpenseListState createState() => _ExpenseListState();
}

class _ExpenseListState extends State<ExpenseList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            DataTable(
              columns: [
                DataColumn(
                    label: Expanded(
                      child: Text('Number',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                    )),
                DataColumn(
                    label: Expanded(
                      child: Text('Date',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                    )),
                DataColumn(
                    label: Expanded(
                      child: Text('Employee',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                    )),
                DataColumn(
                    label: Expanded(
                      child: Text('Vendor',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                    )),
                DataColumn(
                    label: Expanded(
                      child: Text('Balance Received',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                    )),
                DataColumn(
                    label: Expanded(
                      child: Text('Advance Issued',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                    )),
                DataColumn(
                    label: Expanded(
                      child: Text('Final Bill',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                    )),
                DataColumn(
                    label: Expanded(
                      child: Text('Adjust Advance',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                    )),
              ],
              rows: [
                DataRow(cells: [
                  DataCell(Text('200')),
                  DataCell(Text('Feb 23, 2021')),
                  DataCell(Text('Irfan')),
                  DataCell(Text('')),
                  DataCell(Text('')),
                  DataCell(Text('')),
                  DataCell(Text('1500')),
                  DataCell(ElevatedButton(
                    onPressed: () {},
                    child: Text("Adjust"),
                  ))
                ]),
                DataRow(cells: [
                  DataCell(Text('200')),
                  DataCell(Text('Feb 23, 2021')),
                  DataCell(Text('Irfan')),
                  DataCell(Text('')),
                  DataCell(Text('')),
                  DataCell(Text('')),
                  DataCell(Text('1500')),
                  DataCell(ElevatedButton(
                    onPressed: () {},
                    child: Text("Adjust"),
                  ))
                ]),
                DataRow(cells: [
                  DataCell(Text('200')),
                  DataCell(Text('Feb 23, 2021')),
                  DataCell(Text('Irfan')),
                  DataCell(Text('')),
                  DataCell(Text('')),
                  DataCell(Text('')),
                  DataCell(Text('1500')),
                  DataCell(ElevatedButton(
                    onPressed: () {},
                    child: Text("Adjust"),
                  ))
                ]),
                DataRow(cells: [
                  DataCell(Text('200')),
                  DataCell(Text('Feb 23, 2021')),
                  DataCell(Text('Irfan')),
                  DataCell(Text('')),
                  DataCell(Text('')),
                  DataCell(Text('')),
                  DataCell(Text('1500')),
                  DataCell(ElevatedButton(
                    onPressed: () {},
                    child: Text("Adjust"),
                  ))
                ]),
                DataRow(cells: [
                  DataCell(Text('200')),
                  DataCell(Text('Feb 23, 2021')),
                  DataCell(Text('Irfan')),
                  DataCell(Text('')),
                  DataCell(Text('')),
                  DataCell(Text('')),
                  DataCell(Text('1500')),
                  DataCell(ElevatedButton(
                    onPressed: () {},
                    child: Text("Adjust"),
                  ))
                ]),
                DataRow(cells: [
                  DataCell(Text('200')),
                  DataCell(Text('Feb 23, 2021')),
                  DataCell(Text('Irfan')),
                  DataCell(Text('')),
                  DataCell(Text('')),
                  DataCell(Text('')),
                  DataCell(Text('1500')),
                  DataCell(ElevatedButton(
                    onPressed: () {},
                    child: Text("Adjust"),
                  ))
                ]),
                DataRow(cells: [
                  DataCell(Text('200')),
                  DataCell(Text('Feb 23, 2021')),
                  DataCell(Text('Irfan')),
                  DataCell(Text('')),
                  DataCell(Text('')),
                  DataCell(Text('')),
                  DataCell(Text('1500')),
                  DataCell(ElevatedButton(
                    onPressed: () {},
                    child: Text("Adjust"),
                  ))
                ]),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
