import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:notesapp/notes_bottom_sheet.dart';
import 'package:notesapp/hive_services.dart';
import 'package:notesapp/model/note_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 240, 133, 217),
        title: const Text('Notes App'),
      ),
      body: ValueListenableBuilder(
          valueListenable: HiveServices.box.listenable(),
          builder: (BuildContext context, Box<NoteModel> box, Widget? child) {
            return box.isEmpty
                ? const Center(
                    child: Text(
                      "Empty!",
                      style: TextStyle(fontSize: 50),
                    ),
                  )
                : ListView.builder(
                    itemCount: box.length,
                    itemBuilder: (context, index) {
                      NoteModel? noteModel = box.getAt(index);

                      return ListTile(
                        leading:
                            CircleAvatar(child: Text((index + 1).toString())),
                        title: Text(noteModel!.title.toString()),
                        subtitle: Text(noteModel.description.toString()),
                        trailing: PopupMenuButton(
                          itemBuilder: (context) => [
                            PopupMenuItem(
                                child: ListTile(
                              onTap: () {
                                Navigator.pop(context);
                                notesBottomSheet(context,
                                    index: index,
                                    title: noteModel.title.toString(),
                                    description:
                                        noteModel.description.toString());
                              },
                              title: const Text('Update',
                                  style: TextStyle(fontSize: 14)),
                              trailing: const Icon(Icons.edit),
                            )),
                            PopupMenuItem(
                                child: ListTile(
                              onTap: () {
                                HiveServices().deleteNote(index);
                                Navigator.pop(context);
                                HiveServices().showMassage(context,
                                    'Delete Successfully', Colors.redAccent);
                              },
                              title: const Text(
                                'Delete',
                                style: TextStyle(fontSize: 15),
                              ),
                              trailing: const Icon(Icons.delete),
                            ))
                          ],
                        ),
                      );
                    });
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          notesBottomSheet(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
