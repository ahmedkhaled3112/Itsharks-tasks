import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:to_do_app/data/models/task.dart';

// ignore: must_be_immutable
class ToDoScreen extends StatefulWidget {
  ToDoScreen({Key? key, required this.tasks}) : super(key: key);
  List<Task> tasks;

  @override
  State<ToDoScreen> createState() => _ToDoScreenState();
}

class _ToDoScreenState extends State<ToDoScreen> {
  String formattedDate = DateFormat('EEE, M-d-y  kk:mm').format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    widget.tasks =
        widget.tasks.where((element) => element.isDone == false).toList();
    return ListView.builder(
      itemBuilder: (context, index) {
        return ListTile(
          leading: const Icon(FontAwesomeIcons.clipboardList),
          title: Text(
            widget.tasks[index].taskName,
          ),
          subtitle: Text(formattedDate),
          trailing: const Icon(FontAwesomeIcons.clock),
        );
      },
      itemCount: widget.tasks.length,
    );
  }
}
