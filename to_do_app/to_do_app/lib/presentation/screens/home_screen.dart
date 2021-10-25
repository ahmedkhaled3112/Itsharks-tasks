import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:to_do_app/data/models/task.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Task> tasks = [
    Task(taskName: "eat breakfast"),
    Task(taskName: "drink cofee"),
    Task(taskName: "morining training"),
    Task(taskName: "Go to Work"),
    Task(taskName: "eat breakfast"),
    Task(taskName: "eat breakfast"),
    Task(taskName: "drink cofee"),
    Task(taskName: "morining training"),
    Task(taskName: "Go to Work"),
    Task(taskName: "eat breakfast"),
    Task(taskName: "eat breakfast"),
    Task(taskName: "drink cofee"),
    Task(taskName: "morining training"),
    Task(taskName: "Go to Work"),
    Task(taskName: "eat breakfast"),
  ];
  String formattedDate = DateFormat('EEE, M-d-y  kk:mm').format(DateTime.now());
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("To Do App"),
          bottom: const TabBar(
            tabs: [
              Text("Tasks"),
              Text("Waiting"),
              Text("Finished"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ListView.builder(
              itemBuilder: (context, index) {
                return tasks[index].isDone
                    ? const SizedBox(
                        height: 0,
                        width: 0,
                      )
                    : ListTile(
                        leading: const Icon(FontAwesomeIcons.clipboardList),
                        title: Text(
                          tasks[index].taskName,
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    decoration: tasks[index].isDone
                                        ? TextDecoration.lineThrough
                                        : null,
                                  ),
                        ),
                        subtitle: Text(formattedDate),
                        trailing: Checkbox(
                          value: tasks[index].isDone,
                          onChanged: (val) {
                            setState(() {
                              tasks[index].isDone = val!;
                            });
                          },
                        ),
                      );
              },
              itemCount: tasks.length,
            ),
            ListView.builder(
              itemBuilder: (context, index) {
                return tasks[index].isDone
                    ? const SizedBox(
                        height: 0,
                        width: 0,
                      )
                    : ListTile(
                        leading: const Icon(FontAwesomeIcons.clipboardList),
                        title: Text(
                          tasks[index].taskName,
                        ),
                        subtitle: Text(formattedDate),
                        trailing: const Icon(FontAwesomeIcons.clock),
                      );
              },
              itemCount: tasks.length,
            ),
            ListView.builder(
              itemBuilder: (context, index) {
                return tasks[index].isDone
                    ? ListTile(
                        leading: const Icon(FontAwesomeIcons.clipboardList),
                        title: Text(
                          tasks[index].taskName,
                        ),
                        subtitle: Text(formattedDate),
                        trailing: const Icon(FontAwesomeIcons.check),
                      )
                    : const SizedBox(
                        height: 0,
                        width: 0,
                      );
              },
              itemCount: tasks.length,
            ),
          ],
        ),
      ),
    );
  }
}
