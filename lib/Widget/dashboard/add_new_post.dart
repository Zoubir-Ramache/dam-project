import 'package:dam_project/Widget/dashboard/add_images.dart';
import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
// import 'dart:convert';
import 'dart:io';

class AddNewPost extends StatefulWidget {
  const AddNewPost({super.key});

  @override
  State<AddNewPost> createState() => _AddNewPostState();
}

class _AddNewPostState extends State<AddNewPost> {
  TextEditingController nameCont = TextEditingController();
  TextEditingController placeCont = TextEditingController();
  TextEditingController descriptionCont = TextEditingController();
  TextEditingController categoryCont = TextEditingController();
  List<File> selectedImages = [];

  void validateInput() async {
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
    final additionalData = {
      "name": nameCont.text,
      "place": placeCont.text,
      "category": categoryCont.text,
      "description": descriptionCont.text
    };
    addPost(selectedImages, additionalData);
  }

  void addPost(
      List<File> imageFiles, Map<String, String> additionalData) async {
    // var uri = Uri.http("localhost", "/dam_project_backend/post.php");
    // var request = http.MultipartRequest('POST', uri);

    // Add additional data as form fields
    // additionalData.forEach((key, value) {
    //   request.fields[key] = value;
    // });

    // for (int i = 0; i < imageFiles.length; i++) {
    //   var imageFile = imageFiles[i];
    //   var stream = http.ByteStream(imageFile.openRead());
    //   int length = await imageFile.length();
    //   request.files.add(http.MultipartFile('files', stream, length,
    //       filename: 'image_$i.jpg'));
    // }

    // var response = await request.send();

    await http.post(
        Uri.http("localhost", "/dam_project_backend/post.php"),
        body: {...additionalData, "status": "insert"});

    // print(request.body);
  }

  // print(response.statusCode);

  void uploadSelectedImages(List<File> imageFiles) async {
    if (imageFiles.isEmpty) {
      await showDialog(
          context: context,
          builder: (_) => const AlertDialog(
                title: Text("please add images "),
              ));
      return;
    }
    setState(() {
      selectedImages = imageFiles;
    });
    validateInput();
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
                MyImagePicker(uploadSelectedImages),
              ],
            ),
          )),
    );
  }
}
