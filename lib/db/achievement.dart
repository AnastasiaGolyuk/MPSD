class Achievement {
  final int? id;
  final String name;
  final String title;
  final String subTitle;

  Achievement(
      {this.id,
      required this.name,
      required this.title,
      required this.subTitle});

  factory Achievement.fromMap(Map<String, dynamic> json) => Achievement(
      id: json['id'],
      name: json['name'],
      title: json['title'],
      subTitle: json['subTitle']);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'title': title,
      'subTitle': subTitle,
    };
  }
}
