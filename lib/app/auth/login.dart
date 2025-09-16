import 'package:course_getx/components/crud.dart';
import 'package:course_getx/components/customtextform.dart';
import 'package:course_getx/components/valid.dart';
import 'package:course_getx/constant/linkapi.dart';
import 'package:course_getx/main.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  GlobalKey<FormState> formstate = GlobalKey();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  Crud crud = Crud();
  login() async {
    if (formstate.currentState!.validate()) {
      try {
        var response = await crud.postRequest(linkLogin, {
          "email": email.text,
          "password": password.text,
        });

        // ignore: avoid_print
        print("Login response: $response"); // للتصحيح

        if (response != null && response is Map) {
          if (response['status'] == "success") {
            sharedPref.setString("id", response['data']['id'].toString());
            sharedPref.setString("usersname", response['data']['usersname']);
            sharedPref.setString("email", response['data']['email']);

            // ignore: use_build_context_synchronously
            Navigator.of(
              // ignore: use_build_context_synchronously
              context,
            ).pushNamedAndRemoveUntil("home", (route) => false);
          } else {
            // ignore: use_build_context_synchronously
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(response['message'] ?? "Login failed")),
            );
          }
        } else {
          // ignore: use_build_context_synchronously
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Unexpected response from server")),
          );
        }
      } catch (e) {
        // ignore: avoid_print
        print("Login error: $e");
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Something went wrong, please try again.")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(5),
        child: ListView(
          children: [
            Form(
              key: formstate,
              child: Column(
                children: [
                  Image.asset("images/logo.jpg"),
                  CustTextformSign(
                    valid: (val) {
                      return validInput(val!, 3, 25);
                    },
                    hint: "email",
                    mycontroller: email,
                  ),
                  CustTextformSign(
                    valid: (val) {
                      return validInput(val!, 3, 25);
                    },
                    hint: "password",
                    mycontroller: password,
                  ),
                  MaterialButton(
                    color: Colors.blue,
                    textColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                    onPressed: () async {
                      await login();
                    },
                    child: Text("Login"),
                  ),
                  Container(height: 10),
                  InkWell(
                    child: Text("Sign Up"),
                    onTap: () {
                      Navigator.of(context).pushReplacementNamed("signup");
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
