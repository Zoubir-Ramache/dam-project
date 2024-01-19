import 'package:dam_project/Screens/dashboard.dart';
import 'package:dam_project/utils/filterPosts.dart';
import 'package:flutter/material.dart';
import '../utils/getUserData.dart';
import '/Widget/post.dart';
import './search.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import '../utils/getAllPosts.dart';
import '../utils/getAllCategories.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String role = "normal user";
  late SharedPreferences pref;
  String? id;

  Future<void> initData() async {
    Map<String, dynamic> userData = await getUserData(id!);
    setState(() {
      role = userData["role"];
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
  void initState() {
    super.initState();
    initPref();
    handleSearchData(null, null, null);
  }

  Future<void> handleSearchData(
      String? name, String? category, String? place) async {
    final data = await filterPosts(name, category, place);
    setState(() {
      postsData = data;
    });
    // print(data);
    // print(name);
  }

  List postsData = [];
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, //todo later remove this line
      home: Scaffold(
          appBar: AppBar(
            title: IconButton(
                onPressed: () async {
                  await showModalBottomSheet(
                      context: context,
                      builder: (_) => Search(handleSearchData));
                },
                icon: const Icon(
                  Icons.search,
                  size: 30,
                )),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: IconButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed('/profile');
                    },
                    icon: const Icon(
                      Icons.person,
                      size: 35,
                    )),
              ),
              if (role == "admin")
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: IconButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => const DashBoard()));
                      },
                      icon: const Icon(Icons.settings)),
                )
            ],
          ),
          body: Column(
            children: [
              Categories(handleSearchData),
              Posts(postsData, role, id ?? '')
            ],
          )),
    );
  }
}

class Categories extends StatefulWidget {
  const Categories(this.handleData, {super.key});
  final Function(String? name, String? category, String? place) handleData;

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  List data = [];
  void initData() async {
    final newData = await getAllCategories();
    setState(() {
      data = newData;
    });
  }

  @override
  void initState() {
    super.initState();
    initData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      height: 60,
      color: const Color.fromARGB(73, 139, 235, 250),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: data.length,
        itemBuilder: (context, index) =>
            CategoryButton('${data[index]["category"]}', widget.handleData),
      ),
    );
  }
}

class CategoryButton extends StatelessWidget {
  const CategoryButton(this.name, this.handleData, {super.key});
  final Function(String? name, String? category, String? place) handleData;

  final String name;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        handleData(null, name, null);
      },
      child: Container(
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            color: Color.fromARGB(255, 7, 77, 255)),
        margin: const EdgeInsets.only(right: 10),
        padding: const EdgeInsets.all(5),
        child: Center(
            child: Text(
          name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        )),
      ),
    );
  }
}

class Posts extends StatefulWidget {
  const Posts(this.data, this.role, this.userId, {super.key});
  final String role;
  final String userId;
  final List data;
  @override
  State<Posts> createState() => _PostsState();
}

class _PostsState extends State<Posts> {
  // List data = [];
  // void initData() async {
  // final newData = await filterPosts(null, null, null);
  //   setState(() {
  //     data = widget.data;
  //   });
  // }

  @override
  void initState() {
    super.initState();
    // initData();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          itemCount: widget.data.isEmpty ? 1 : widget.data.length,
          itemBuilder: (context, index) {
            if (widget.data.isEmpty) {
              return const Center(
                  child: Text(
                "there is no posts !! ",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold ),
              ));
            }
            return Post(widget.data[index], widget.role, widget.userId);
          }),
    );
  }
}
