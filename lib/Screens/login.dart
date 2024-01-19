import 'package:flutter/material.dart';
import '../Widget/form.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: FormWidget(
            handleData: handleData,
            buttonName: 'login',
            cont: context,
          ),
        ),
      ),
    );
  }
}

void handleData(String email, String password, context) async {
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
        "/dam_project_backend/login.php",
      ),
      body: {"email": email, "password": password});
  if (request.statusCode == 404) {
    showDialog(
        context: context,
        builder: (_) => const AlertDialog(
              title: Text('incorect password'),
            ));
  } else {
    SharedPreferences pref = await SharedPreferences.getInstance();
    Map<String, dynamic> requestBody = jsonDecode(request.body);
    await pref.setString("id", requestBody["id"]);
    Navigator.of(context).pushNamed('/home');
  }
}
