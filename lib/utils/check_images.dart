import 'package:flutter/services.dart' show rootBundle;

Future<bool> doesImageExist(String imagePath) async {
  try {
    await rootBundle.load(imagePath);
    return true;
  } catch (error) {
    return false;
  }
}
