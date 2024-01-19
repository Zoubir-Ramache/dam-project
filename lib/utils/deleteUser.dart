import 'package:http/http.dart' as http;


Future <void> deleteUser(String id) async {
  
  
      await http.post(Uri.http("localhost", "/dam_project_backend/users.php") , body: {"id":id , "status":"delete"});
  
}
