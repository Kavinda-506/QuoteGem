/// Daily Quotes App
///
/// Main entry point for the application. Configures the application theme,
/// initializes the MaterialApp, and sets up the splash screen as the initial route.
///
/// The app uses a deep purple theme with custom styling for the app bar and other elements.
/// The splash screen displays a logo, app name, and tagline with a fade-in animation
/// before automatically transitioning to the quotes list screen.
import 'package:flutter/material.dart';
import 'dart:async';
import 'quotes_list_screen.dart';

void main() {
  runApp(QuoteApp());
}

/// Main application widget that configures the application theme and initial route.
///
/// Sets up the MaterialApp with a deep purple theme, transparent app bar, and other
/// custom styling. The app starts with the SplashScreen as the home widget.
class QuoteApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Daily Quotes',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xFF1D1135),
        scaffoldBackgroundColor: Color(0xFF1D1135),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.white),
          titleTextStyle: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      home: SplashScreen(),
    );
  }
}

/// Splash screen widget displayed when the app first launches.
///
/// Features a fade-in animation for the app logo, name, and tagline.
/// Automatically navigates to the QuotesListScreen after a 3-second delay.
/// The background uses a gradient from deep purple to slightly lighter purple.
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

/// State class for the SplashScreen that manages animations and navigation timing.
///
/// Implements SingleTickerProviderStateMixin to enable animation capabilities.
/// Controls a fade-in animation and handles the timed navigation to the main app screen.
class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    // Create animation controller
    _controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );

    // Create fade-in animation
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

    // Start animation
    _controller.forward();

    // Navigate to QuotesListScreen after 3 seconds
    Timer(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => QuotesListScreen()),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF1D1135), // Deep purple (matching your app theme)
              Color(0xFF2D1F4A), // Slightly lighter purple
            ],
          ),
        ),
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // App logo/image
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.format_quote,
                    size: 60,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 24),

                // App name
                Text(
                  'Daily Quotes',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                ),

                SizedBox(height: 12),

                // Tagline
                Text(
                  'Wisdom for everyday inspiration',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.7),
                    fontSize: 16,
                  ),
                ),

                SizedBox(height: 48),

                // Loading indicator
                SizedBox(
                  width: 40,
                  height: 40,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    strokeWidth: 2,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
