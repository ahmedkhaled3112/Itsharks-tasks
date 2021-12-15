import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:to_do_app/data/models/task.dart';

// ignore: must_be_immutable
class DoneScreen extends StatefulWidget {
  DoneScreen({Key? key, required this.tasks}) : super(key: key);
  List<Task> tasks;

  @override
  State<DoneScreen> createState() => _DoneScreenState();
}

class _DoneScreenState extends State<DoneScreen> {
  @override
  Widget build(BuildContext context) {
    widget.tasks = widget.tasks.where((element) => element.isDone == true).toList();
    return ListView.builder(
      itemBuilder: (context, index) {
        return ListTile(
          leading: const Icon(FontAwesomeIcons.clipboardList),
          title: Text(
            widget.tasks[index].taskName,
          ),
          subtitle: Text(DateFormat('EEE, M-d-y  kk:mm').format(widget.tasks[index].doneTime!)),
          trailing: const Icon(FontAwesomeIcons.check),
        );
      },
      itemCount: widget.tasks.length,
    );
  }
}
