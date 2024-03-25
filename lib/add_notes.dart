import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:notesapp/hive_services.dart';
import 'package:notesapp/model/note_model.dart';

addNotes(BuildContext context) {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(20),
                topLeft: Radius.circular(20),
              )),
          height: 300,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          margin:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Column(
            children: [
              const Text(
                'Notes App',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 5,
              ),
              TextField(
                controller: titleController,
                //autofocus: true,
                decoration: const InputDecoration(
                    hintText: "Title", border: InputBorder.none),
              ),
              TextField(
                controller: descriptionController,
                maxLines: 4,
                decoration: const InputDecoration(
                    hintText: "Description", border: InputBorder.none),
              ),
              SizedBox(
                  height: 45,
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () {
                        if (titleController.text.isEmpty) {
                          HiveServices().showMassage(
                              context, 'Please Enter Title', Colors.redAccent);
                        } else if (descriptionController.text.isEmpty) {
                          HiveServices().showMassage(context,
                              'Please Enter Description', Colors.redAccent);
                        } else {
                          NoteModel noteModel = NoteModel(
                              title: titleController.text.toString(),
                              description:
                                  descriptionController.text.toString());

                          HiveServices().addNote(noteModel);
                        }
                      },
                      child: const Text("Submit")))
            ],
          ),
        );
      });
}
