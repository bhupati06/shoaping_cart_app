import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.06),
            child: Column(
              children: [
                SizedBox(height: size.height * 0.05),

                SizedBox(
                  height: size.height * 0.4,
                  child: Lottie.asset('assets/lottie/grosery.json'),
                ),

                SizedBox(height: size.height * 0.04),
                Text(
                  "Welcome to ShopEasy!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: size.width * 0.06,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),

                SizedBox(height: size.height * 0.02),

                // Subtitle
                Text(
                  "Discover great deals & shop your daily needs with just a tap.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: size.width * 0.045,
                    color: Colors.grey[700],
                  ),
                ),

                SizedBox(height: size.height * 0.05),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: size.height * 0.02, // Vertical padding for the button itself
                  ),
                  child: SizedBox(
                    width: double.infinity,
                    height: size.height * 0.1,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepOrange,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/catalog');
                      },
                      child: Text(
                        "Get Started",
                        style: TextStyle(

                          fontSize: size.width * 0.045,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              SizedBox(height: 5.0,)
              ],
            ),
          ),
        ),
      ),
    );
  }
}