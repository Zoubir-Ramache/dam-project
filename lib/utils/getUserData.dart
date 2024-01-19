import 'package:http/http.dart' as http;
import 'dart:convert';

Future<Map<String, dynamic>> getUserData(String id) async {
  final request = await http
      .get(Uri.http("localhost", "/dam_project_backend/users.php" , {"id":id}));
  Map<String, dynamic> requestBody = jsonDecode(request.body);
  return requestBody;
}

