import 'package:flutter/material.dart';
import '../component/tombol.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color.fromARGB(255, 246, 255, 243),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 50.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Spacing for top padding
              const SizedBox(height: 25.0),

              // App Name
              Text(
                'Covid Info',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                  letterSpacing: 2.0,
                ),
              ),

              // Center mascot image with adjusted padding
              Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 30.0),
                  child: Image.asset(
                    'assets/images/intro.png',
                    width: 200,// adjust height as needed
                  ),
                ),
              ),

              // Main tagline
             
              // Call to action button
              Mybutton(
                text: 'Get Started',
                onTap: () {
                  Navigator.pushNamed(context, '/login');
                },
              ),

              // Bottom spacing
              const SizedBox(height: 25.0),
            ],
          ),
        ),
      ),
    );
  }
}