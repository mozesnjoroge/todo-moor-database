// ignore: file_names
import 'package:flutter/material.dart';
import 'package:moor_flutter/moor_flutter.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_moor/data/moor_database.dart';

class NewTaskInput extends StatefulWidget {
  const NewTaskInput({ Key? key }) : super(key: key);

  @override
  _NewTaskInputState createState() => _NewTaskInputState();
}

class _NewTaskInputState extends State<NewTaskInput> {
  DateTime? newTaskDate;
  TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child:Row(
        children: [
      _buildTextField(context),
      _buildDateButton(context),]
      ),
    );
      
  }
  Expanded _buildTextField(BuildContext context){
    return Expanded(
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Type new task',
        ),
        controller: controller,
        onSubmitted: (taskName){
          final database = Provider.of<AppDatabase>(context);
          final task = Task(
            //TODO: solve this issue
            //TODO: hardcoded 'id' and 'completed' values
            id:int.parse(database.allTasks.toString())+1,
            name: taskName,
            dueDate: newTaskDate,
            completed:false,
            );
            database.insertTasks(task);
            resetValuesAfterSubmit();
        },
    ));
  }
  IconButton _buildDateButton(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.calendar_today),
      onPressed: () async {
        newTaskDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2010),
          lastDate: DateTime(2050),
        );
      },
    );
  }
  void resetValuesAfterSubmit() {
    setState(() {
      newTaskDate = null;
      controller!.clear();
    });
  }

}