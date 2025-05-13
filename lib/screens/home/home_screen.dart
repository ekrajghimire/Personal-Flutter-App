import 'package:flutter/material.dart';
import 'package:port/widgets/common/animated_text.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:port/screens/about/about_screen.dart';
import 'package:port/screens/services/services_screen.dart';
import 'package:port/screens/projects/projects_screen.dart';
import 'package:port/screens/portfolio/portfolio_screen.dart';
import 'package:port/screens/blog/blog_screen.dart';
import 'package:port/screens/contact/contact_screen.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'dart:math' as math;
import 'package:provider/provider.dart';
import 'package:port/providers/theme_provider.dart';
import 'package:port/utils/page_transitions.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Portfolio'),
        actions: [
          // Theme toggle button
          IconButton(
            icon: Icon(
              themeProvider.isDarkMode ? Icons.light_mode : Icons.dark_mode,
            ),
            onPressed: () {
              themeProvider.toggleTheme();
            },
            tooltip:
                themeProvider.isDarkMode
                    ? 'Switch to Light Mode'
                    : 'Switch to Dark Mode',
          ),
          // Developer option to reset onboarding
          PopupMenuButton(
            icon: const Icon(Icons.more_vert),
            itemBuilder:
                (context) => [
                  PopupMenuItem(
                    child: const Text('Reset Onboarding'),
                    onTap: () => _resetOnboarding(context),
                  ),
                ],
          ),
        ],
      ),
      body: const HomeContent(),
    );
  }

  // Reset onboarding state for testing
  Future<void> _resetOnboarding(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboarding_complete', false);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Onboarding reset. App restart required.'),
          duration: Duration(seconds: 3),
        ),
      );
    }
  }
}

class HomeContent extends StatefulWidget {
  const HomeContent({super.key});

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  final List<String> _roles = [
    "Web/App Developer",
    "Graphics Designer",
    "UI/UX Designer",
    "Photographer",
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            // Profile Section
            Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  // Profile Photo with animated light behind it
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      // Animated light effect behind the profile photo
                      Container(
                            width: 180,
                            height: 180,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                colors: [
                                  Theme.of(
                                    context,
                                  ).primaryColor.withOpacity(0.3),
                                  Theme.of(
                                    context,
                                  ).colorScheme.secondary.withOpacity(0.3),
                                ],
                              ),
                            ),
                          )
                          .animate(onPlay: (controller) => controller.repeat())
                          .shimmer(
                            duration: 2.seconds,
                            color: Colors.white.withOpacity(0.7),
                          )
                          .animate()
                          .scale(
                            begin: const Offset(1.0, 1.0),
                            end: const Offset(1.1, 1.1),
                            duration: 3.seconds,
                          )
                          .then()
                          .scale(
                            begin: const Offset(1.1, 1.1),
                            end: const Offset(1.0, 1.0),
                            duration: 3.seconds,
                          )
                          .then(delay: 0.5.seconds),

                      // Second glow effect
                      Container(
                            width: 170,
                            height: 170,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: SweepGradient(
                                colors: [
                                  Theme.of(
                                    context,
                                  ).primaryColor.withOpacity(0.0),
                                  Theme.of(
                                    context,
                                  ).primaryColor.withOpacity(0.2),
                                  Theme.of(
                                    context,
                                  ).colorScheme.secondary.withOpacity(0.2),
                                  Theme.of(
                                    context,
                                  ).primaryColor.withOpacity(0.0),
                                ],
                                stops: const [0.0, 0.3, 0.7, 1.0],
                                transform: const GradientRotation(math.pi / 4),
                              ),
                            ),
                          )
                          .animate(onPlay: (controller) => controller.repeat())
                          .rotate(duration: 8.seconds, end: 1.0)
                          .animate()
                          .fadeIn(duration: 1.seconds),

                      // Profile photo
                      CircleAvatar(
                        radius: 80,
                        backgroundImage: AssetImage(
                          'assets/images/profile.jpg',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Text
                  const Text(
                    'Hello, I\'m',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),

                  // Animated Text
                  AnimatedText(roles: _roles),
                  const SizedBox(height: 20),
                  // Resume Download Button
                  ElevatedButton.icon(
                    onPressed: () => _downloadResume(),
                    icon: const Icon(Icons.download),
                    label: const Text('Download Resume'),
                  ),
                ],
              ),
            ),
            // Navigation Menu
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
                children: [
                  _buildMenuCard(
                    'About Me',
                    Icons.person,
                    () => _navigateToScreen(const AboutScreen()),
                  ),
                  _buildMenuCard(
                    'Services',
                    Icons.work,
                    () => _navigateToScreen(const ServicesScreen()),
                  ),
                  _buildMenuCard(
                    'Projects',
                    Icons.code,
                    () => _navigateToScreen(const ProjectsScreen()),
                  ),
                  _buildMenuCard(
                    'Portfolio',
                    Icons.photo_library,
                    () => _navigateToScreen(const PortfolioScreen()),
                  ),
                  _buildMenuCard(
                    'Blog',
                    Icons.article,
                    () => _navigateToScreen(const BlogScreen()),
                  ),
                  _buildMenuCard(
                    'Contact',
                    Icons.contact_mail,
                    () => _navigateToScreen(const ContactScreen()),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuCard(String title, IconData icon, VoidCallback onTap) {
    return Card(
      elevation: 4,
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40),
            const SizedBox(height: 8),
            Text(title, style: Theme.of(context).textTheme.titleMedium),
          ],
        ),
      ),
    );
  }

  Future<void> _downloadResume() async {
    // Change this URL if needed
    const url =
        'https://www.ekrajghimire.com.np/wp-content/uploads/2023/05/EkrajGhimire.pdf';

    try {
      final Uri uri = Uri.parse(url);

      // Use launchUrl with the correct mode for opening PDFs
      if (await canLaunchUrl(uri)) {
        await launchUrl(
          uri,
          mode: LaunchMode.externalApplication, // Opens in external app
        );
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'Could not open PDF. No app available to handle this file.',
              ),
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error opening resume: ${e.toString()}')),
        );
      }
    }
  }

  void _navigateToScreen(Widget screen) {
    Navigator.push(context, PageTransitions.slideTransition(screen));
  }
}
