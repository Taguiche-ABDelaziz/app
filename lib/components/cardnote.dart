import 'package:course_getx/app/model/notemodel.dart';
import 'package:course_getx/constant/linkapi.dart';
import 'package:flutter/material.dart';

class CardNotes extends StatelessWidget {
  final void Function() ontap;
  final NoteMode notemodel;
  final Function()? onDelete;
  const CardNotes({
    super.key,
    required this.ontap,
    required this.notemodel,

    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: ontap,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Image.network(
                  "$linkImageRoot/${notemodel.notesImage}",
                  width: 100,
                  height: 100,
                  fit: BoxFit.fill,
                ),
              ),
              Expanded(
                flex: 2,
                child: ListTile(
                  // ignore: unnecessary_string_interpolations
                  title: Text("${notemodel.notesTitle}"),
                  // ignore: unnecessary_string_interpolations
                  subtitle: Text("${notemodel.notesTitle}"),
                  trailing: IconButton(
                    onPressed: onDelete,
                    icon: Icon(Icons.delete),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
