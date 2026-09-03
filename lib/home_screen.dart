import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 100,
      decoration: BoxDecoration(
        // I understand RGB more than this silly color list
        //color: Color.fromARGB(255, 50, 50, 50),
        image: DecorationImage(
          image: NetworkImage(
            // beautiful picture of colorado I found online
            "https://www.colorado.com/_next/image?url=%2Fsites%2Fdefault%2Ffiles%2F2025-07%2F2023_1_1770%2520%25281%2529.jpg&w=2048&q=75",
          ),
          fit: BoxFit.cover,
        ),
        border: Border.all(color: Colors.blueAccent, width: 10),
      ),
      child: Center(
        child: Text(
          "Welcome to Kevin's Homework Tracker!",
          style: TextStyle(
            fontSize: 48,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
