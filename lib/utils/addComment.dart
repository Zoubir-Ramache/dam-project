import 'package:http/http.dart' as http;

Future<void> addComment(String postId, String userId, String content) async {
  await http.post(
      Uri.http("localhost", "/dam_project_backend/comments.php"),
      body: {"postId": postId, "userId": userId, "content": content});

}
