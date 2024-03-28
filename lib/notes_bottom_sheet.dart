import 'package:flutter/material.dart';
import 'package:notesapp/hive_services.dart';
import 'package:notesapp/model/note_model.dart';

notesBottomSheet(BuildContext context,
    {int? index, String? title, String? description}) {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  if (index == null) {
    titleController.clear();
    descriptionController.clear();
  } else {
    titleController.text = title.toString();
    descriptionController.text = description.toString();
  }

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
              Text(
                index == null ? 'Add Notes App' : 'Update Notes',
                style:
                    const TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
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

                          if (index == null) {
                            HiveServices().addNote(noteModel);
                            HiveServices().showMassage(
                                context, 'Added successfully', Colors.green);
                          } else {
                            HiveServices().updateNote(index, noteModel);
                            HiveServices().showMassage(
                                context, 'Updated successfully', Colors.green);
                          }

                          Navigator.pop(context);
                        }
                      },
                      child: const Text("Submit")))
            ],
          ),
        );
      });
}
