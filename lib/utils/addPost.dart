// import 'dart:io';
// import 'package:http/http.dart' as http;

// Future<void> uploadImage(
//     List<File> imageFiles, Map<String, String> additionalData) async {
//   var uri = Uri.http("localhost", "/dam_project_backend/addPost.php");
//   var request = http.MultipartRequest('POST', uri);

//   // Add additional data as form fields
//   additionalData.forEach((key, value) {
//     request.fields[key] = value;
//   });

//   for (int i = 0; i < imageFiles.length; i++) {
//     var imageFile = imageFiles[i];
//     var stream = http.ByteStream(imageFile.openRead());
//     var length = await imageFile.length();
//     request.files.add(http.MultipartFile('files', stream, length,
//         filename: 'image_$i.jpg'));
//   }

//   var response = await request.send();

//   if (response.statusCode == 200) {
//     print('Images uploaded successfully');
//   } else {
//     print('Images upload failed with status code: ${response.statusCode}');
//   }
// }

// // Example usage

//   // List<File> imageFiles = [
//   //   File('/path/to/your/image1.jpg'),
//   //   File('/path/to/your/image2.jpg'),
//   //   // Add more image files as needed
//   // ];

//   // Map<String, String> additionalData = {
//   //   'key1': 'value1',
//   //   'key2': 'value2',
//   //   // Add more key-value pairs as needed
//   // };

//   // uploadImagesWithAdditionalData(imageFiles, additionalData);

