import 'getAllPosts.dart';

Future<List> filterPosts(String? name, String? category, String? place) async {
  final data = await getAllPosts();
  if (name != null) {
    data.removeWhere((element) => element["name"] != name);
  }
  if (place != null) {
    data.removeWhere((element) => element["place"] != place);
  }
  if (category != null) {
    data.removeWhere((element) => element["category"] != category);
  }
  return data;
}
