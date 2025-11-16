import 'package:course_getx/app/model/notemodel.dart';
import 'package:course_getx/app/notes/edit.dart';
import 'package:course_getx/components/cardnote.dart';
import 'package:course_getx/components/crud.dart';
import 'package:course_getx/constant/linkapi.dart';
import 'package:course_getx/main.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _LoginState();
}

class _LoginState extends State<Home> {
  Crud crud = Crud();

  getNotes() async {
    var respones = await crud.postRequest(linkViewNotes, {
      "id": sharedPref.getString("id"),
    });
    return respones;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        actions: [
          IconButton(
            onPressed: () {
              sharedPref.clear();
              Navigator.of(
                context,
              ).pushNamedAndRemoveUntil("login", (route) => false);
            },
            icon: Icon(Icons.exit_to_app),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed("addNotes");
        },
        child: Icon(Icons.add),
      ),
      body: ListView(
        padding: const EdgeInsets.all(10),
        children: [
          FutureBuilder(
            future: getNotes(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data['status'] == 'fail') {
                  return Center(
                    child: Text(
                      "There are no notes",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                }
                return ListView.builder(
                  itemCount: snapshot.data['data'].length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, i) {
                    return CardNotes(
                      onDelete: () async {
                        var response = await crud.postRequest(linkDeleteNotes, {
                          "id": snapshot.data['data'][i]['notes_id'].toString(),
                          "imagename": snapshot.data['data'][i]['notes_image']
                              .toString(),
                        });
                        if (response['status'] == "success") {
                          // ignore: use_build_context_synchronously
                          Navigator.of(context).pushReplacementNamed("home");
                        }
                      },
                      ontap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) =>
                                EditNotes(notes: snapshot.data['data'][i]),
                          ),
                        );
                      },
                      notemodel: NoteMode.fromJson(snapshot.data['data'][i]),
                    );
                  },
                );
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: Text("Loading...."));
              }
              return Center(child: Text("Loading...."));
            },
          ),
        ],
      ),
    );
  }
}
