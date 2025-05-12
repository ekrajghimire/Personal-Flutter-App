import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ServicesScreen extends StatelessWidget {
  const ServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Services')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'What I Offer',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            const Text(
              'I provide high-quality services to help you achieve your digital goals.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),

            // Services Grid
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 0.8,
              children: [
                _buildServiceCard(
                  context,
                  'Mobile App Development',
                  'assets/icons/mobile_app.svg',
                  'Custom mobile applications for iOS and Android platforms.',
                  '\$2000 - \$10000',
                ),
                _buildServiceCard(
                  context,
                  'Web Development',
                  'assets/icons/web_dev.svg',
                  'Responsive websites and web applications.',
                  '\$1500 - \$8000',
                ),
                _buildServiceCard(
                  context,
                  'UI/UX Design',
                  'assets/icons/ui_design.svg',
                  'User-centered design for mobile and web applications.',
                  '\$1000 - \$5000',
                ),
                _buildServiceCard(
                  context,
                  'Consulting',
                  'assets/icons/consulting.svg',
                  'Technical advice and project planning services.',
                  '\$100/hr',
                ),
                _buildServiceCard(
                  context,
                  'Backend Development',
                  'assets/icons/backend.svg',
                  'APIs, databases, and server-side architecture.',
                  '\$2500 - \$12000',
                ),
                _buildServiceCard(
                  context,
                  'Maintenance & Support',
                  'assets/icons/maintenance.svg',
                  'Ongoing updates and technical support for existing apps.',
                  '\$500/month',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildServiceCard(
    BuildContext context,
    String title,
    String iconPath,
    String description,
    String pricing,
  ) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Fallback to an Icon if SVG is not available
            _buildServiceIcon(iconPath),
            const SizedBox(height: 12),
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: Theme.of(context).textTheme.bodySmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              pricing,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildServiceIcon(String iconPath) {
    try {
      return SvgPicture.asset(iconPath, height: 48, width: 48);
    } catch (e) {
      // Fallback to a default icon if the SVG fails to load
      return const Icon(Icons.work, size: 48);
    }
  }
}
