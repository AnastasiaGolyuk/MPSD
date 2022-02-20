import 'package:flutter/material.dart';

import 'package:my_app/db/db_helper.dart';
import 'package:my_app/db/record.dart';

class Results extends StatefulWidget {
  const Results({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _ResultsState createState() => _ResultsState();
}

class _ResultsState extends State<Results> {
  final textController = TextEditingController();

  Future<DataTable> _createDatatable() async {
    return DataTable(
        columns: _createColumns(),
        rows: await _createRows(),
        columnSpacing: 30);
  }

  List<DataColumn> _createColumns() {
    return [
      const DataColumn(
          label:
              Text('ID', style: TextStyle(fontSize: 15, color: Colors.pink))),
      const DataColumn(
          label:
              Text('Name', style: TextStyle(fontSize: 15, color: Colors.pink))),
      const DataColumn(
          label:
              Text('Date', style: TextStyle(fontSize: 15, color: Colors.pink))),
      const DataColumn(
          label: Text('Satiety',
              style: TextStyle(fontSize: 15, color: Colors.pink))),
    ];
  }

  Future<List<DataRow>> _createRows() async {
    List<Record> results = await DatabaseHelper.instance.getRecordsSorted();
    return results
        .map((record) => DataRow(cells: [
              DataCell(Text('#' + record.id.toString(),
                  style: const TextStyle(fontSize: 15, color: Colors.pink))),
              DataCell(Text(record.name.toString(),
                  style: const TextStyle(fontSize: 15, color: Colors.pink))),
              DataCell(Text(record.date.toString(),
                  style: const TextStyle(fontSize: 15, color: Colors.pink))),
              DataCell(Text(record.satiety.toString(),
                  style: const TextStyle(fontSize: 15, color: Colors.pink)))
            ]))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        centerTitle: true,
        title: const Text('Results'),
      ),
      body: Center(
        child: FutureBuilder<DataTable>(
            future: _createDatatable(),
            builder: (BuildContext context, AsyncSnapshot<DataTable> snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                    child: Text("Loading...",
                        style: TextStyle(fontSize: 20, color: Colors.pink)));
              }
              return snapshot.data!.rows.isEmpty
                  ? const Center(
                      child: Text("No Records in List",
                          style: TextStyle(fontSize: 20, color: Colors.pink)))
                  : ListView(
                      children: [snapshot.requireData],
                    );
            }),
      ),
    );
  }
}
