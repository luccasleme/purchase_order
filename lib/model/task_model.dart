class TaskModel {
  final String name;
  final String html;
  final String id;

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      name: json['listProcessVariableDTO'][0]['value'],
      html: json['filterTaskDetail'],
      id:  json['taskId']
    );
  }

  TaskModel({required this.name, required this.html, required this.id});
}
