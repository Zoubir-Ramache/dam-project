import 'package:http/http.dart' as http;

Future<void> likePost(String userId, String postId) async {
   await http.post(
      Uri.http(
        "localhost",
        "/dam_project_backend/likedPosts.php",
      ),
      body: {'user_id': userId, 'post_id': postId, "status": 'add'});
}
