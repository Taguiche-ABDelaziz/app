import 'dart:io';

import 'package:course_getx/components/crud.dart';
import 'package:course_getx/components/customtextform.dart';
import 'package:course_getx/components/valid.dart';
import 'package:course_getx/constant/linkapi.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditNotes extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final notes;
  const EditNotes({super.key, this.notes});

  @override
  State<EditNotes> createState() => _EditNotesState();
}

class _EditNotesState extends State<EditNotes> {
  Crud crud = Crud();
  File? myflie;
  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  TextEditingController title = TextEditingController();
  TextEditingController content = TextEditingController();

  editNotes() async {
    if (formstate.currentState!.validate()) {
      // ignore: prefer_typing_uninitialized_variables
      var response;
      if (myflie == null) {
        response = await crud.postRequest(linkEditNotes, {
          "title": title.text,
          "content": content.text,
          "id": widget.notes['notes_id'].toString(),
          "imagename": widget.notes['notes_image'].toString(),
        });
      } else {
        response = await crud.postRequestWithFile(linkEditNotes, {
          "title": title.text,
          "content": content.text,
          "imagename": widget.notes['notes_image'].toString(),
          "id": widget.notes['notes_id'].toString(),
        }, myflie!);
      }
      if (response['status'] == "success") {
        // ignore: use_build_context_synchronously
        Navigator.of(context).pushReplacementNamed("home");
      } else {
        //
      }
    }
  }

  @override
  void initState() {
    title.text = widget.notes['notes_title'];
    content.text = widget.notes['notes_content'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Edit Notes")),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Form(
          key: formstate,
          child: ListView(
            children: [
              CustTextformSign(
                hint: "title",
                mycontroller: title,
                valid: (val) {
                  return validInput(val!, 2, 25);
                },
              ),
              CustTextformSign(
                hint: "content",
                mycontroller: content,
                valid: (val) {
                  return validInput(val!, 5, 255);
                },
              ),
              Container(height: 20),
              MaterialButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    // ignore: sized_box_for_whitespace
                    builder: (context) => Container(
                      height: 140,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Pleasse chosse Image",
                            style: TextStyle(fontSize: 22),
                          ),
                          InkWell(
                            onTap: () async {
                              XFile? xFile = await ImagePicker().pickImage(
                                source: ImageSource.camera,
                              );
                              myflie = File(xFile!.path);
                              // ignore: use_build_context_synchronously
                              Navigator.of(context).pop();
                              setState(() {});
                            },
                            child: Container(
                              alignment: Alignment.center,
                              width: double.infinity,
                              padding: EdgeInsets.all(10),
                              child: Text(
                                "From Camera",
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () async {
                              XFile? xFile = await ImagePicker().pickImage(
                                source: ImageSource.gallery,
                              );
                              myflie = File(xFile!.path);
                              // ignore: use_build_context_synchronously
                              Navigator.of(context).pop();
                              setState(() {});
                            },
                            child: Container(
                              alignment: Alignment.center,
                              width: double.infinity,
                              padding: EdgeInsets.all(10),
                              child: Text(
                                "From Gallery",
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                textColor: Colors.white,
                color: myflie == null ? Colors.blue : Colors.green,
                child: Text("Add Image"),
              ),
              MaterialButton(
                onPressed: () async {
                  await editNotes();
                },
                textColor: Colors.white,
                color: Colors.blue,
                child: Text("Edite"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
