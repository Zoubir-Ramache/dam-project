import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class EditPost extends StatefulWidget {
  const EditPost(this.postInfo, {super.key});
  final Map<String, dynamic> postInfo;

  @override
  State<EditPost> createState() => _EditPostState();
}

class _EditPostState extends State<EditPost> {
  TextEditingController nameCont = TextEditingController();
  TextEditingController placeCont = TextEditingController();
  TextEditingController descriptionCont = TextEditingController();
  TextEditingController categoryCont = TextEditingController();
  Future<void> validateInput() async {
    if (nameCont.text.trim().isEmpty ||
        placeCont.text.trim().isEmpty ||
        categoryCont.text.trim().isEmpty) {
      await showDialog(
          context: context,
          builder: (_) => const AlertDialog(
                title: Text("please check your input "),
              ));
      return;
    } else {
      //todo check the image
    }
   await  updatePost();
  }

 Future<void> updatePost() async {
    final request = await http
        .post(Uri.http("localhost", "/dam_project_backend/post.php"), body: {
      "name": nameCont.text,
      "place": placeCont.text,
      "category": categoryCont.text,
      "description": descriptionCont.text,
      "id":widget.postInfo["id"],
      "status": "update",
    });
    if (request.statusCode == 201) {
      print('ok');
    }
  }

  @override
  void initState() {
    super.initState();
    nameCont.text = widget.postInfo["name"];
    placeCont.text = widget.postInfo["place"];
    categoryCont.text = widget.postInfo["category"];
    descriptionCont.text = widget.postInfo["description"];
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: BackButton(
          onPressed: () {
            Navigator.pop(context);
          },
        )),
        body: Container(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              TextField(
                controller: nameCont,
                decoration: const InputDecoration(label: Text("name")),
              ),
              TextField(
                controller: placeCont,
                decoration: const InputDecoration(label: Text("place")),
              ),
              TextField(
                controller: descriptionCont,
                decoration: const InputDecoration(label: Text("description")),
              ),
              TextField(
                controller: categoryCont,
                decoration: const InputDecoration(label: Text("category")),
              ),
            ],
          ),
        ),
        floatingActionButton: ElevatedButton(
            onPressed: ()async  {
              await validateInput();
              Navigator.pop(context);
            },
            child: const Text('save')),
      ),
    );
  }
}
