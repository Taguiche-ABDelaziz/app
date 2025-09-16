import 'package:flutter/material.dart';

class CardNotes extends StatelessWidget {
  final void Function() ontap;
  final String title;
  final String content;
  const CardNotes({
    super.key,
    required this.ontap,
    required this.title,
    required this.content,
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
                child: Image.asset(
                  "images/logo.jpg",
                  width: 100,
                  height: 100,
                  fit: BoxFit.fill,
                ),
              ),
              Expanded(
                flex: 2,
                child: ListTile(
                  // ignore: unnecessary_string_interpolations
                  title: Text("$title"),
                  // ignore: unnecessary_string_interpolations
                  subtitle: Text("$content"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
