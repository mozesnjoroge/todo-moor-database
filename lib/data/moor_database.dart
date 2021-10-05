import 'package:moor/moor.dart';
import 'package:moor_flutter/moor_flutter.dart';

part 'moor_database.g.dart';

//Default data class name is task
class Tasks extends Table{
//defines the database schema
IntColumn get id => integer().autoIncrement()();
TextColumn get name => text().withLength(min: 2, max: 50)();
DateTimeColumn get dueDate => dateTime().nullable()();
BoolColumn get completed => boolean().withDefault(const Constant(false))();

//create the database

}
@UseMoor(tables:[Tasks])
class AppDatabase extends _$AppDatabase{
//specify db location through constructor
AppDatabase():super((FlutterQueryExecutor.inDatabaseFolder(path: 'db.sqlite', logStatements: true)),);

@override
int get schemaVersion => 1; 

//Queries return a future
//Be careful dealing wih generated data class names and table names
//Read
Future<List<Task>> get allTasks=> select(tasks).get();
Stream<List<Task>> get watchAllTasks => select(tasks).watch();
Future insertTasks(Task task)=>into(tasks).insert(task);
//update : returns an int due to the autoincrement
Future updateTasks(Task task) => update(tasks).replace(task);
//delete
Future deleteTasks(Task task) => delete(tasks).delete(task);
}
