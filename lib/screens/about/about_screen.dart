import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('About Me')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Personal Description
            Text('Who I Am', style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 12),
            const Text(
              'I am a passionate web/app developer with expertise in mobile and web applications. '
              'With a keen eye for design and a commitment to creating intuitive user experiences, '
              'I strive to build applications that not only look good but also provide real value to users.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),

            // Background Information
            Text(
              'My Background',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 12),
            const Text(
              'I have over 4 years of experience in software development, working with various technologies '
              'including Flutter, MySQL, React, and Node.js. My journey in tech began with a passion for problem-solving '
              'and has evolved into a career focused on creating elegant solutions for complex challenges.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),

            // Skills Section
            Text('Skills', style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: [
                _buildSkillChip('Flutter'),
                _buildSkillChip('Dart'),
                _buildSkillChip('React'),
                _buildSkillChip('JavaScript'),
                _buildSkillChip('Node.js'),
                _buildSkillChip('UI/UX Design'),
                _buildSkillChip('Firebase'),
                _buildSkillChip('RESTful APIs'),
              ],
            ),
            const SizedBox(height: 24),

            // Experience Section
            Text(
              'Experience',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 16),
            _buildExperienceTimeline(context),
            const SizedBox(height: 24),

            // Education Section
            Text(
              'Education',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 16),
            _buildEducationTimeline(context),
          ],
        ),
      ),
    );
  }

  Widget _buildSkillChip(String label) {
    return Chip(
      label: Text(label, style: const TextStyle(color: Colors.black)),
      backgroundColor: Colors.blue.shade100,
    );
  }

  Widget _buildExperienceTimeline(BuildContext context) {
    return Column(
      children: [
        _buildTimelineItem(
          context,
          '2022 - Present',
          'Senior Mobile Developer',
          'Tech Innovations Inc.',
          'Leading the mobile development team, focusing on Flutter applications.',
        ),
        _buildTimelineItem(
          context,
          '2020 - 2022',
          'Mobile Developer',
          'Digital Solutions Ltd.',
          'Developed cross-platform applications using Flutter and React Native.',
        ),
        _buildTimelineItem(
          context,
          '2018 - 2020',
          'Junior Developer',
          'StartUp Tech',
          'Worked on web and mobile applications using React and React Native.',
          isLast: true,
        ),
      ],
    );
  }

  Widget _buildEducationTimeline(BuildContext context) {
    return Column(
      children: [
        _buildTimelineItem(
          context,
          '2021 - 2025',
          'B.Tech Computer Science & Engineering',
          'JAIN (Deemed-to-be University)',
          'Graduated with engineering degree, specializing in Mobile Application and Cloud Technology.',
          isLast: true,
        ),
        _buildTimelineItem(
          context,
          '2018 - 2020',
          '+2 (Computer Science)',
          'Tilottama Campus',
          'Graduated with Science, Physic, Chemistry, Mathematics, and Computer Science',
          isLast: true,
        ),
      ],
    );
  }

  Widget _buildTimelineItem(
    BuildContext context,
    String period,
    String title,
    String subtitle,
    String description, {
    bool isLast = false,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).primaryColor,
              ),
            ),
            if (!isLast)
              Container(
                width: 2,
                height: 80,
                color: Theme.of(context).primaryColor,
              ),
          ],
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                period,
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(title, style: Theme.of(context).textTheme.titleMedium),
              Text(
                subtitle,
                style: const TextStyle(fontStyle: FontStyle.italic),
              ),
              const SizedBox(height: 4),
              Text(description),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ],
    );
  }
}
