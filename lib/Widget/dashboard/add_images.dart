import 'dart:io';

// import 'package:dam_project/utils/AddPost.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MyImagePicker extends StatelessWidget {
  const MyImagePicker(this.uploadImages, {super.key});
  final Function(List<File>) uploadImages;

  @override
  Widget build(BuildContext context) {
    return  MultipleImageSelector(uploadImages);
  }
}

class MultipleImageSelector extends StatefulWidget {
  const MultipleImageSelector(this.uploadImages ,{super.key});

  final Function(List<File>) uploadImages;
  @override
  State<MultipleImageSelector> createState() => _MultipleImageSelectorState();
}

class _MultipleImageSelectorState extends State<MultipleImageSelector> {
  List<File> selectedImages = [];
  final picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    // display image selected from gallery
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.green)),
          child: const Text('Select Image from Gallery and Camera'),
          onPressed: () {
            getImages();
          },
        ),
        Container(
          color: Colors.blue[200],
          height: 200,
          child: selectedImages.isEmpty
              ? const Center(child: Text('Sorry nothing selected!!'))
              : GridView.builder(
                  itemCount: selectedImages.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3),
                  itemBuilder: (BuildContext context, int index) {
                    return kIsWeb
                        ? Image.network(selectedImages[index].path)
                        : Image.file(selectedImages[index]);
                  }),
        ),
        ElevatedButton(
            onPressed: () {
              widget.uploadImages(selectedImages);
            },
            child: const Text("save"))
      ],
    );
  }

  Future getImages() async {
    final pickedFile = await picker.pickMultiImage(
        imageQuality: 100, maxHeight: 1000, maxWidth: 1000);
    List<XFile> xfilePick = pickedFile;

    setState(
      () {
        if (xfilePick.isNotEmpty) {
          for (var i = 0; i < xfilePick.length; i++) {
            selectedImages.add(File(xfilePick[i].path));
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Nothing is selected')));
        }
      },
    );
  }
}
