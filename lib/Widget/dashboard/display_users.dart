import 'package:dam_project/utils/deleteUser.dart';
import 'package:flutter/material.dart';
import '../../utils/getAllUsers.dart';
import '../../utils/changeRole.dart';

class DisplayUsers extends StatefulWidget {
  const DisplayUsers({super.key});

  @override
  State<DisplayUsers> createState() => _DisplayUsersState();
}

class _DisplayUsersState extends State<DisplayUsers> {
  List AllUsers = [];
  void initData() async {
    final data = await getAllUsers();
    setState(() {
      AllUsers = data;
    });
  }

  @override
  void initState() {
    super.initState();
    initData();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        child: ListView.builder(
            itemCount: AllUsers.length,
            itemBuilder: (context, index) {
              String role = AllUsers[index]["role"];
              
              return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: const Color.fromARGB(255, 8, 32, 248),
                  ),
                  padding: const EdgeInsets.all(4),
                  margin: const EdgeInsets.all(4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "id :${AllUsers[index]['id']}",
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "name :${AllUsers[index]['name']}",
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Last name :${AllUsers[index]['lastname']}",
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "role :${AllUsers[index]['role']}",
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "age :${AllUsers[index]['age']}",
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "gendre :${AllUsers[index]['gendre']}",
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                          DropdownButton(
                              value: role,
                              items: const [
                                DropdownMenuItem(
                                  value: "normalUser",
                                  child: Text("normal user"),
                                ),
                                DropdownMenuItem(
                                  value: "admin",
                                  child: Text("admin"),
                                )
                              ],
                              onChanged: (s) {
                                changeRole(AllUsers[index]['id'], s!);
                                setState(() {
                                  role = s;
                                });
                              }),
                          ElevatedButton(
                              onPressed: () {
                                deleteUser(AllUsers[index]['id']);
                              },
                              child: const Text('delete ')),
                        ],
                      )
                    ],
                  ));
            }),
      ),
    );
  }
}
