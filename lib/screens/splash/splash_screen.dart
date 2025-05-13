import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:port/screens/home/home_screen.dart';
import 'package:port/screens/onboarding/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNextScreen();
  }

  Future<void> _navigateToNextScreen() async {
    // Delay for splash screen animation (3 seconds)
    await Future.delayed(const Duration(seconds: 3));

    if (!mounted) return;

    // Check if user has completed onboarding
    final prefs = await SharedPreferences.getInstance();
    final onboardingComplete = prefs.getBool('onboarding_complete') ?? false;

    if (mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder:
              (context) =>
                  onboardingComplete
                      ? const HomeScreen()
                      : const OnboardingScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.person,
                size: 80,
                color: Theme.of(context).colorScheme.primary,
              ),
            ).animate().scale(
              duration: 1.seconds,
              curve: Curves.easeOutBack,
              begin: const Offset(0.0, 0.0),
              end: const Offset(1.0, 1.0),
            ),

            const SizedBox(height: 40),

            // App Name
            Text(
                  'My Portfolio',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                )
                .animate()
                .fadeIn(delay: 0.5.seconds, duration: 0.5.seconds)
                .slideY(begin: 0.2, end: 0),

            const SizedBox(height: 16),

            // Tagline
            Text(
                  'Showcase your best work',
                  style: Theme.of(context).textTheme.bodyLarge,
                )
                .animate()
                .fadeIn(delay: 0.8.seconds, duration: 0.5.seconds)
                .slideY(begin: 0.2, end: 0),

            const SizedBox(height: 60),

            // Loading indicator
            CircularProgressIndicator(
              color: Theme.of(context).colorScheme.primary,
            ).animate().fadeIn(delay: 1.seconds, duration: 0.5.seconds),
          ],
        ),
      ),
    );
  }
}
