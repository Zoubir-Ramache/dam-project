import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List> getLikedPosts(String id) async {
  
  final request = await http.get(Uri.http(
      "localhost", "/dam_project_backend/likedPosts.php", {'user_id': id}));
  List requestBody = jsonDecode(request.body);
  
  return requestBody;
}
