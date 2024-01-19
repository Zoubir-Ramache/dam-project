import 'package:flutter/material.dart';
import '../Widget/form.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: FormWidget(
            handleData: handleData,
            buttonName: 'signUp',
            cont: context,
          ),
        ),
      ),
    );
  }
}

void handleData(email, password, context) async {
  if (email.trim().isEmpty || password.trim().isEmpty) {
    showDialog(
        context: context,
        builder: (_) => const AlertDialog(
              title: Text(" please verify your input"),
            ));
    return;
  }

  final request = await http.post(
      Uri.http(
        "localhost",
        "/dam_project_backend/signup.php",
      ),
      body: {"email": email, "password": password});

  if (request.statusCode == 409) {
    showDialog(
        context: context,
        builder: (_) => const AlertDialog(
              title: Text('user already exist '),
            ));
  } else {
    SharedPreferences pref = await SharedPreferences.getInstance();
    Map<String, dynamic> requestBody = jsonDecode(request.body);
    await pref.setString("id", requestBody["id"]);
    Navigator.of(context).pushNamed("editProfile");
  }
}
