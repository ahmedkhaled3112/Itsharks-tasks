import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:to_do_app/data/models/task.dart';

// ignore: must_be_immutable
class AllTasksScreen extends StatefulWidget {
  AllTasksScreen({Key? key, required this.tasks}) : super(key: key);
  List<Task> tasks;

  @override
  State<AllTasksScreen> createState() => _AllTasksScreenState();
}

class _AllTasksScreenState extends State<AllTasksScreen> {
  String formattedDate = DateFormat('EEE, M-d-y  kk:mm').format(DateTime.now());
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return ListTile(
          leading: const Icon(FontAwesomeIcons.clipboardList),
          title: Text(
            widget.tasks[index].taskName,
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  decoration: widget.tasks[index].isDone
                      ? TextDecoration.lineThrough
                      : null,
                ),
          ),
          subtitle: Text(formattedDate),
          trailing: Checkbox(
            value: widget.tasks[index].isDone,
            onChanged: (val) {
              setState(() {
                widget.tasks[index].isDone = val!;
                if (widget.tasks[index].isDone) {
                  widget.tasks[index].doneTime = DateTime.now();
                }
              });
            },
          ),
        );
      },
      itemCount: widget.tasks.length,
    );
  }
}
