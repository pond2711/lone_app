import 'package:flutter/material.dart';
class HomePage extends StatefulWidget {
 //change when reload app
 const HomePage({Key? key, required this.title}) : super(key: key);
 final String title;
 @override
 State<HomePage> createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {
 @override
 Widget build(BuildContext context) {
 return Scaffold(
 body: Center(
 child: Text(
 "Welcome to Pond's App",
 style: TextStyle(fontSize: 30),
 ),
 ),
 );
 }
}