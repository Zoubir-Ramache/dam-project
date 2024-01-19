import 'package:flutter/material.dart';
import '../utils/getUserData.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/getLikedPosts.dart';
import '../Widget/post.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late SharedPreferences pref;
  late String firstName = "";
  late String lastName = "";
  late String role = "";
  late String gendre = "";
  late String age = "";
  late String? id;
  List likedPosts = [];

  @override
  void initState() {
    super.initState();
    initPref();
  }

  Future<void> initData() async {
    Map<String, dynamic> userData = await getUserData(id!);
    setState(() {
      firstName = userData['name'];
      lastName = userData['lastname'];
      role = userData["role"];
      gendre = userData["gendre"];
      age = userData["age"];
    });
    List newLikedPosts = await getLikedPosts(id!);
    setState(() {
      likedPosts = newLikedPosts;
    });
  }

  Future<void> initPref() async {
    pref = await SharedPreferences.getInstance();
    setState(() {
      id = pref.getString("id");
    });
    initData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        floatingActionButton: ElevatedButton.icon(
            onPressed: () {
              Navigator.popAndPushNamed(context, "editProfile");
            },
            icon: const Icon(Icons.edit),
            label: const Text("edit")),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BackButton(
              onPressed: () {
                Navigator.of(context).popAndPushNamed("/home");
              },
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Icon(
                  Icons.person,
                  size: 100,
                ),
              ],
            ),
            Center(
                child: Text(
              "$firstName , $lastName",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            )),
            Text(
              "gendre  : $gendre ",
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              "age : $age",
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              "role :$role",
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const Text(
              "liked places :",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: likedPosts.isEmpty ? 1 : likedPosts.length,
                  itemBuilder: (context, index) {
                    if (likedPosts.isEmpty) {
                      return const Center(child: Text("you didnt like any posts yet" , style: TextStyle(fontSize: 30 , fontWeight: FontWeight.bold),));
                    }
                    return Post(likedPosts[index], role, '');
                  }),
            )
          ],
        ),
      ),
    );
  }
}
