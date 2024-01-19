import 'package:http/http.dart' as http;

void fun() async {
  final request =
      await http.get(Uri.http("localhost" , "/dam_project_backend/"));
  print(request.body);
}
