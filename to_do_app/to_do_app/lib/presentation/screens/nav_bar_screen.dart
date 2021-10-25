import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:to_do_app/data/models/task.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NavBarScreen extends StatefulWidget {
  const NavBarScreen({Key? key}) : super(key: key);

  @override
  _NavBarScreenState createState() => _NavBarScreenState();
}

class _NavBarScreenState extends State<NavBarScreen> {
  int _selectedIndex = 0;
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

  static final List<Widget> _widgetOptions = [
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
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
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
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("To Do App"),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.clipboardList),
            label: 'tasks',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.clock),
            label: 'waiting',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.check),
            label: 'finished',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
