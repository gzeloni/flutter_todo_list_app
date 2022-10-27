class Todo {
  Todo({required this.title, required this.subtitle, required this.date});
  //--------------------------------
  Todo.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        date = DateTime.parse(json['date']),
        subtitle = json['subtitle'];
  //--------------------------------
  String title;
  String subtitle;
  DateTime date;
  //--------------------------------
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'subtitle': subtitle,
      'date': date.toIso8601String(),
    };
  }
}
