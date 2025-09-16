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
                      ontap: () {},
                      title: "${snapshot.data['data'][i]['notes_title']}",
                      content: "${snapshot.data['data'][i]['notes_content']}",
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
