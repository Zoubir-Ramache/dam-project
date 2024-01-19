import 'package:dam_project/Widget/dashboard/add_new_post.dart';
import 'package:dam_project/Widget/dashboard/display_users.dart';
import 'package:flutter/material.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BackButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                const Text("Dashboard"),
                const SizedBox()
              ],
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(spacing: 30, children: [
                  ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => const AddNewPost()));
                      },
                      child: const Text('add new post')),
                  ElevatedButton(
                      onPressed: () {}, child: const Text('show reports')),
                ]),
                const Text(
                  "users : ",
                  style: TextStyle(color: Colors.blue, fontSize: 30),
                ),
                const DisplayUsers(),
              ],
            ),
          )),
    );
  }
}
