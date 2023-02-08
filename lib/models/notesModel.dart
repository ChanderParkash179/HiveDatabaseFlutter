import 'package:hive/hive.dart';

part 'notesModel.g.dart';

@HiveType(typeId: 0)
class NotesModel {
  @HiveField(0)
  String title;

  @HiveField(1)
  String description;

  NotesModel({required this.title, required this.description});

  @override
  String toString() {
    return 'Title : $title, \n Description: $description \n';
  }
}
