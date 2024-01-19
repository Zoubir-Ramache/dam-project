import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../utils/getUserData.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _ProfileState();
}

class _ProfileState extends State<EditProfile> {
  final firstNameCont = TextEditingController();
  final lastNameCont = TextEditingController();
  final ageCont = TextEditingController();
  String role = "normal user";
  String gendre = 'male';
  String? id;
  late SharedPreferences pref;

  @override
  void initState() {
    super.initState();
    initPref();
  }

  Future<void> initData() async {
    Map<String, dynamic> userData = await getUserData(id!);
    setState(() {
      firstNameCont.text = userData['name'];
      lastNameCont.text = userData['lastname'];
      role = userData["role"];
      gendre = userData["gendre"];
      ageCont.text = userData["age"];
    });
  }

  Future<void> initPref() async {
    pref = await SharedPreferences.getInstance();
    setState(() {
      id = pref.getString("id");
    });
    initData();
  }

  void handleData(String id, String name, String lastName, String age,
      String gendre) async {
    int? newAge = int.tryParse(age);
    if (newAge == null) {
      showDialog(
          context: context,
          builder: (_) => const AlertDialog(
                title: Text('please enter a valid age '),
              ));
      return;
    } else if (name.trim().isEmpty) {
      showDialog(
          context: context,
          builder: (_) => const AlertDialog(
                title: Text('please enter a valid name'),
              ));
      return;
    } else if (lastName.trim().isEmpty) {
      showDialog(
          context: context,
          builder: (_) => const AlertDialog(
                title: Text('please enter a valid last name'),
              ));
      return;
    }

    await http.post(
        Uri.http(
          "localhost",
          "/dam_project_backend/users.php",
        ),
        body: {"id": id, "lastname": lastName, "name": name , "age":age , "gendre":gendre});
     await http.post(
        Uri.http(
          "localhost",
          "/dam_project_backend/users.php",
        ),
        body: {"id": id, "lastname": lastName, "name": name , "age":age , "gendre":gendre ,"status":"update"});
        
  
      
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          padding: const EdgeInsets.all(1),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (id != null)
                    BackButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ElevatedButton(
                      onPressed: () {
                        handleData(id!, firstNameCont.text, lastNameCont.text,
                            ageCont.text, gendre);
                        Navigator.of(context).popAndPushNamed('/profile');

                      },
                      child: const Text("save"))
                ],
              ),
              // Center(child: Image.asset("")),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        maxLength: 30,
                        decoration: const InputDecoration(
                          label: Text('first name'),
                        ),
                        controller: firstNameCont,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        maxLength: 30,
                        decoration: const InputDecoration(
                          label: Text('last name'),
                        ),
                        controller: lastNameCont,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  keyboardType: TextInputType.number,
                  maxLength: 3,
                  decoration: const InputDecoration(
                    label: Text('age'),
                  ),
                  controller: ageCont,
                ),
              ),
              const SizedBox(
                width: double.infinity,
                child: Text(
                  "gendre :",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  SizedBox(
                    width: 200,
                    child: RadioListTile(
                        value: 'Male',
                        title: const Text('Male'),
                        groupValue: gendre,
                        onChanged: (value) {
                          setState(() {
                            gendre = value.toString();
                          });
                        }),
                  ),
                  SizedBox(
                    width: 200,
                    child: RadioListTile(
                        value: 'Female',
                        title: const Text('Female'),
                        groupValue: gendre,
                        onChanged: (value) {
                          setState(() {
                            gendre = value.toString();
                          });
                        }),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
