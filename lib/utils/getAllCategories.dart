import 'package:http/http.dart' as http;
import 'dart:convert';

Future <List> getAllCategories() async {
  
  final request =
      await http.get(Uri.http("localhost", "/dam_project_backend/category.php"));
  List requestBody = jsonDecode(request.body);
  
  return requestBody;
}
