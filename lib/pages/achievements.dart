import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:my_app/db/achievement.dart';
import 'package:my_app/db/db_helper.dart';

class Achievements extends StatefulWidget {
  const Achievements({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _AchievementsState createState() => _AchievementsState();
}

class _AchievementsState extends State<Achievements> {
  final textController = TextEditingController();

  Future<DataTable> _createDatatable() async {
    return DataTable(
        columns: _createColumns(),
        rows: await _createRows(),
        columnSpacing: 20);
  }

  List<DataColumn> _createColumns() {
    return [
      const DataColumn(
          label:
              Text('Icon', style: TextStyle(fontSize: 15, color: Colors.pink))),
      const DataColumn(
          label:
              Text('Name', style: TextStyle(fontSize: 15, color: Colors.pink))),
      const DataColumn(
          label: Text('Title',
              style: TextStyle(fontSize: 15, color: Colors.pink))),
      const DataColumn(
          label: Text('Subtitle',
              style: TextStyle(fontSize: 15, color: Colors.pink))),
    ];
  }

  Future<List<DataRow>> _createRows() async {
    List<Achievement> results = await DatabaseHelper.instance.getAchievements();
    return results
        .map((achievement) => DataRow(cells: [
              const DataCell(
                  Icon(CupertinoIcons.suit_heart_fill, color: Colors.pink)),
              DataCell(Text(achievement.name.toString(),
                  style: const TextStyle(fontSize: 15, color: Colors.pink))),
              DataCell(SizedBox(
                  width: 80,
                  child: Text(achievement.title.toString(),
                      style:
                          const TextStyle(fontSize: 15, color: Colors.pink)))),
              DataCell(SizedBox(
                  width: 120,
                  child: Text(achievement.subTitle.toString(),
                      style:
                          const TextStyle(fontSize: 15, color: Colors.pink))))
            ]))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        centerTitle: true,
        title: const Text('Achievements'),
      ),
      body: Center(
        child: FutureBuilder<DataTable>(
            future: _createDatatable(),
            builder: (BuildContext context, AsyncSnapshot<DataTable> snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                    child: Text('Loading...',
                        style: TextStyle(fontSize: 20, color: Colors.pink)));
              }
              return snapshot.data!.rows.isEmpty
                  ? const Center(
                      child: Text('No Achievements in List',
                          style: TextStyle(fontSize: 20, color: Colors.pink)))
                  : ListView(
                      children: [snapshot.requireData],
                    );
            }),
      ),
    );
  }
}
