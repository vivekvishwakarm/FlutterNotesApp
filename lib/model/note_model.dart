import 'package:hive_flutter/adapters.dart';
part 'note_model.g.dart';

@HiveType(typeId: 0)
class NoteModel extends HiveObject {
  @HiveField(0)
  String title;
  @HiveField(1)
  String description;

  NoteModel({required this.title, required this.description});
}
