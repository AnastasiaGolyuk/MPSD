class Record {
  final int? id;
  final String name;
  final String date;
  final int satiety;

  Record(
      {this.id, required this.name, required this.date, required this.satiety});

  factory Record.fromMap(Map<String, dynamic> json) => Record(
      id: json['id'],
      name: json['name'],
      date: json['date'],
      satiety: json['satiety']);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'date': date,
      'satiety': satiety,
    };
  }
}
