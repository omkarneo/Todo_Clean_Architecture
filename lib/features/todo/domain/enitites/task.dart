class Task {
  final int? id;
  final String task;
  final String time;
  final String location;

  Task(
      {this.id,
      required this.task,
      required this.time,
      required this.location});

  static Task fromJson(json) {
    return Task(
        id: json['id'],
        task: json['task'],
        time: json['time'],
        location: json['location']);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'task': task, 'time': time, 'location': location};
  }
}
