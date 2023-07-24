


import 'package:flutter/material.dart';

class Developer {
  final String name;
  final String role;
  final String description;

  Developer(this.name, this.role, this.description);
}

class AboutUs extends StatelessWidget {
  final Developer developer = Developer(
    "Ahmed Mohamed Ghanam",
    "Flutter Developer",
    "I am a passionate Flutter developer, constantly learning and building exciting apps.",
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0.0,
        backgroundColor: Colors.white,
        title: const Text(
            "About Developer",
            style:TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            )
        ),
      ),
        body: Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundImage: AssetImage('assets/images/ahmed.jpeg'),
                radius: 60,
              ),
              SizedBox(height: 20),
              Text(
                developer.name,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                developer.role,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  developer.description,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
    );
  }
}