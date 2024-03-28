import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:notesapp/model/note_model.dart';

class HiveServices {
  static const boxName = 'my_notes_box';

  //get refernce box
  static Box<NoteModel> box = Hive.box<NoteModel>(boxName);

  //add notes
  Future<void> addNote(NoteModel noteModel) async {
    await box.add(noteModel);
  }

  //update note
  Future<void> updateNote(int index, NoteModel noteModel) async {
    await box.putAt(index, noteModel);
  }

  //delete note
  Future<void> deleteNote(int index) async {
    await box.deleteAt(index);
  }

  showMassage(BuildContext context, String massage, Color bgColor) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(massage),
      backgroundColor: bgColor,
    ));
  }
}
