import 'package:course_getx/components/crud.dart';
import 'package:course_getx/components/customtextform.dart';
import 'package:course_getx/components/valid.dart';
import 'package:course_getx/constant/linkapi.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  GlobalKey<FormState> formstate = GlobalKey();

  // ignore: prefer_final_fields
  Crud _crud = Crud();

  TextEditingController usersname = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  signUp() async {
    if (formstate.currentState!.validate()) {
      try {
        var response = await _crud.postRequest(linkSignUp, {
          "usersname": usersname.text,
          "email": email.text,
          "password": password.text,
        });

        if (response['status'] == "success") {
          // ignore: use_build_context_synchronously
          Navigator.of(
            // ignore: use_build_context_synchronously
            context,
          ).pushNamedAndRemoveUntil("success", (route) => false);
        } else {
          // ignore: avoid_print
          print("Signup Fail: ${response['message'] ?? 'Unknown error'}");
        }
      } catch (e) {
        // التعامل مع أي خطأ يحصل (انقطاع الإنترنت، خطأ في السيرفر، إلخ)
        // ignore: avoid_print
        print("Error during signup: $e");

        // ممكن تستخدم Snackbar أو Dialog بدال print
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
                      return validInput(val!, 3, 10);
                    },
                    hint: "username",
                    mycontroller: usersname,
                  ),
                  CustTextformSign(
                    valid: (val) {
                      return validInput(val!, 4, 25);
                    },
                    hint: "email",
                    mycontroller: email,
                  ),
                  CustTextformSign(
                    valid: (val) {
                      return validInput(val!, 4, 25);
                    },
                    hint: "password",
                    mycontroller: password,
                  ),

                  MaterialButton(
                    color: Colors.blue,
                    textColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                    onPressed: () async {
                      await signUp();
                    },
                    child: Text("SignUp"),
                  ),
                  Container(height: 10),
                  InkWell(
                    child: Text("Sign Up"),
                    onTap: () {
                      Navigator.of(context).pushNamed("login");
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
