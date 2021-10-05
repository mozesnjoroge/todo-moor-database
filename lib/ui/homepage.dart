import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_moor/data/moor_database.dart';
import 'package:todo_list_moor/widgets/newTaskInput.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      // ignore: prefer_const_constructors
      body: Column(
        children: [
          Expanded(child:_buildTaskList(context)),
          NewTaskInput()//TODO: create this widget
        ],
      ),
    );
  }
  StreamBuilder<List<Task>> _buildTaskList(BuildContext context){
    final database =  Provider.of<AppDatabase>(context);
    return StreamBuilder(
      stream: database.watchAllTasks,

      builder: (context, AsyncSnapshot<List<Task>> snapshot){
        final tasks =snapshot.data ?? [];
        return ListView.builder(
          itemCount: tasks.length,
          itemBuilder: (context, index){
            final itemTask = tasks[index];
            return _buildListItem(itemTask, database);
          },
        );
      });
  }
  Widget _buildListItem(Task itemTask, AppDatabase database){
    return Slidable(
    // ignore: prefer_const_constructors
    actionPane: SlidableDrawerActionPane(),
    secondaryActions: [
      IconSlideAction(
        caption: 'Delete',
        icon: Icons.delete,
        onTap: ()=> database.deleteTasks(itemTask),
        ),
    ],
    child: CheckboxListTile(
      title: Text(itemTask.name),
      subtitle: Text(itemTask.dueDate.toString()),
      value:itemTask.completed,
      onChanged: (newValue){
      database.updateTasks(itemTask.copyWith(completed: newValue));
      },
    ),
    );
  }
}
