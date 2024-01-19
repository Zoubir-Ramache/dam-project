import 'package:flutter/material.dart';

class ErrorRoute extends StatelessWidget {
  const ErrorRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Error , what are you doing here ?',
          style: TextStyle(color: Colors.red , fontSize: 30 ),
        ),
      ),
    );
  }
}
