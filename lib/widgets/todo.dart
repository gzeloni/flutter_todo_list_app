class Todo {
  Todo({
    this.id,
    required this.title,
    required this.content,
    required this.date,
    this.isComplete,
  });
  //--------------------------------
  String? id;
  String title;
  String content;
  DateTime date;
  bool? isComplete;
  //--------------------------------
  Todo.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        date = DateTime.parse(json['date']),
        content = json['content'],
        isComplete = json['isComplete'];

  //--------------------------------
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'date': date.toIso8601String(),
      'isComplete': isComplete,
    };
  }
}
