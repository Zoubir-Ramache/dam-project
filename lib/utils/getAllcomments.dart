import 'package:http/http.dart' as http;
import 'dart:convert';

Future <List> getAllComments(String postId) async {
  
  final request =
      await http.get(Uri.http("localhost", "/dam_project_backend/comments.php" , {"id":postId}));
  List requestBody = jsonDecode(request.body);
  
  return requestBody;
}
