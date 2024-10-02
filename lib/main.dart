import 'package:api/home.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(const API());
}


class API extends StatelessWidget {
  const API({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home_API(),
    );
  }
}