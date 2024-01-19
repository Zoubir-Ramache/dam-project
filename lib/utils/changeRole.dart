import 'package:http/http.dart' as http;


Future <void> changeRole(String id , String role) async {
  
  
      await http.post(Uri.http("localhost", "/dam_project_backend/admin.php") , body: {"id":id , "role":role });
  
}
