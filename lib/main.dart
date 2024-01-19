import 'package:flutter/material.dart';
import 'Routes/route_generator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false, // todo later delete this line 
      initialRoute: '/login',
      onGenerateRoute: ((settings) {
        return RouteGenerator.generator(settings);
      }),

    );
  }
}
