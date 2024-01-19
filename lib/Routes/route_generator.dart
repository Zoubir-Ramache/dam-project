import 'package:dam_project/Screens/editprofile.dart';
import 'package:flutter/material.dart';
import '../Screens/login.dart';
import '../Screens/signup.dart';
import '../Screens/home.dart';
import '../Screens/profile.dart';
import 'error_route.dart';

class RouteGenerator {
  static Route<dynamic> generator(RouteSettings settings) {
    switch (settings.name) {
      case '/login':
        return MaterialPageRoute(builder: (_) => const Login());
      case '/signup':
        return MaterialPageRoute(builder: (_) => const SignUp());
      case '/home':
        return MaterialPageRoute(builder: (_) => const Home());
      case '/profile':
        return MaterialPageRoute(builder: (_) => const Profile());
      case "editProfile":
        return MaterialPageRoute(builder: (_) => const EditProfile());
      default:
        return MaterialPageRoute(builder: (_) => const ErrorRoute());
    }
  }
}
