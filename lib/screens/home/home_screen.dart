import 'package:flutter/material.dart';
import 'package:port/widgets/common/animated_text.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:port/screens/about/about_screen.dart';
import 'package:port/screens/services/services_screen.dart';
import 'package:port/screens/projects/projects_screen.dart';
import 'package:port/screens/portfolio/portfolio_screen.dart';
import 'package:port/screens/blog/blog_screen.dart';
import 'package:port/screens/contact/contact_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final int _selectedIndex = 0;

  final List<String> _roles = [
    "Web/App Developer",
    "Graphics Designer",
    "UI/UX Designer",
    "Photographer",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Profile Section
              Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    // Profile Photo
                    CircleAvatar(
                      radius: 80,
                      backgroundImage: AssetImage('assets/images/profile.jpg'),
                    ),
                    const SizedBox(height: 20),
                    // Text
                    const Text(
                      'Hello, I\'m',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
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
    // Replace with your resume URL
    const url = 'https://example.com/resume.pdf';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not download resume')),
        );
      }
    }
  }

  void _navigateToScreen(Widget screen) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
  }
}
