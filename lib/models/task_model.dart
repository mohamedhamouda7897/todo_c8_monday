class TaskModel {
  String id;
  String title;
  String description;
  bool status;
  int date;
  int time;
  String userId;

  TaskModel(
      {this.id = "",
      required this.title,
      required this.description,
      required this.status,
      required this.time,
      required this.userId,
      required this.date});

  // TaskModel fromJson(Map<String, dynamic> json) {
  //   TaskModel model = TaskModel(
  //       id: json['id'],
  //       title: json['title'],
  //       description: json['description'],
  //       status: json['status'],
  //       date: json['date']);
  //   return model;
  // }

  TaskModel.fromJson(Map<String, dynamic> json)
      : this(
          id: json['id'],
          title: json['title'],
          description: json['description'],
          date: json['date'],
          time: json['time'],
          userId: json['userId'],
          status: json['status'],
        );

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "description": description,
      "status": status,
      "date": date,
      "time": time,
      "userId": userId,
      "title": title,
    };
  }
}
