import 'package:flutter/material.dart';
import 'package:vsfirst/components/task.dart';

class TaskInherited extends InheritedWidget {
  TaskInherited({super.key, required this.child}) : super(child: child);

  @override
  // ignore: overridden_fields
  final Widget child;

  final List<Task> taskList = [
    Task('My first task', 'assets/images/default.jpg', 1),
    Task('My Sec task', 'assets/images/default.jpg', 2),
  ];

  void newTask(String name, String photo, int difficulty) {
    taskList.add(Task(name, photo, difficulty));
  }

  static TaskInherited? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<TaskInherited>();
  }

  @override
  bool updateShouldNotify(TaskInherited oldWidget) {
    return oldWidget.taskList.length != taskList.length;
  }
}
