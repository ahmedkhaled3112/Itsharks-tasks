import 'package:flutter/material.dart';
import 'package:to_do_app/data/models/task.dart';

import 'add_task_screen.dart';
import 'all_tasks_screen.dart';
import 'done_screen.dart';
import 'to_do_screen.dart';

class TabBarScreen extends StatefulWidget {
  const TabBarScreen({Key? key}) : super(key: key);
  static const String routeName = "/tabBar";
  @override
  State<TabBarScreen> createState() => _TabBarScreenState();
}

class _TabBarScreenState extends State<TabBarScreen> {
  List<Task> tasks = [
    Task(taskName: "eat breakfast"),
    Task(taskName: "drink cofee"),
    Task(taskName: "morining training"),
    Task(taskName: "Go to Work"),
    Task(taskName: "eat breakfast"),
    Task(taskName: "eat breakfast"),
  ];
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Organize your tasks"),
          bottom: TabBar(
            padding: const EdgeInsets.symmetric(
              horizontal: 5,
              vertical: 10,
            ),
            indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Colors.indigo,
            ),
            labelColor: Colors.white,
            unselectedLabelColor: Colors.black,
            tabs: const [
              Text("All Tasks"),
              Text("To Do"),
              Text("Done"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            AllTasksScreen(tasks: tasks),
            ToDoScreen(tasks: tasks),
            DoneScreen(tasks: tasks),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () async {
            var text = await Navigator.of(context)
                .pushNamed(AddTaskScreen.routeName) as String;
            setState(() {
              tasks.add(Task(taskName: text));
            });
          },
        ),
      ),
    );
  }
}
