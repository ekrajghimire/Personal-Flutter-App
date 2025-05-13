import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectsScreen extends StatefulWidget {
  const ProjectsScreen({super.key});

  @override
  State<ProjectsScreen> createState() => _ProjectsScreenState();
}

class _ProjectsScreenState extends State<ProjectsScreen> {
  String _currentFilter = 'All';
  final List<String> _filters = ['All', 'Mobile', 'Web', 'Design'];

  final List<ProjectItem> _projects = [
    ProjectItem(
      title: 'E-Commerce App',
      description:
          'A Flutter-based e-commerce application with Firebase backend.',
      imageUrl: 'assets/images/project1.jpg',
      category: 'Mobile',
      technologies: ['Flutter', 'Firebase', 'Stripe'],
      demoUrl: 'https://example.com/ecommerce-demo',
      githubUrl: 'https://github.com/example/ecommerce-app',
    ),
    ProjectItem(
      title: 'Portfolio Website',
      description:
          'A responsive portfolio website built with React and Next.js.',
      imageUrl: 'assets/images/project2.jpg',
      category: 'Web',
      technologies: ['React', 'Next.js', 'Tailwind CSS'],
      demoUrl: 'https://example.com/portfolio-demo',
      githubUrl: 'https://github.com/example/portfolio-website',
    ),
    ProjectItem(
      title: 'Task Management App',
      description: 'A productivity app for task management with cloud sync.',
      imageUrl: 'assets/images/project3.jpg',
      category: 'Mobile',
      technologies: ['Flutter', 'SQLite', 'Provider'],
      demoUrl: 'https://example.com/task-app-demo',
      githubUrl: 'https://github.com/example/task-app',
    ),
    ProjectItem(
      title: 'Restaurant UI Kit',
      description: 'A UI kit for restaurant and food delivery applications.',
      imageUrl: 'assets/images/project4.jpg',
      category: 'Design',
      technologies: ['Figma', 'Adobe XD'],
      demoUrl: 'https://example.com/restaurant-ui',
      githubUrl: null,
    ),
    ProjectItem(
      title: 'Weather Application',
      description: 'A weather app with beautiful visualizations and forecasts.',
      imageUrl: 'assets/images/project5.jpg',
      category: 'Mobile',
      technologies: ['Flutter', 'REST API', 'BLoC'],
      demoUrl: 'https://example.com/weather-app-demo',
      githubUrl: 'https://github.com/example/weather-app',
    ),
    ProjectItem(
      title: 'Corporate Website',
      description: 'A corporate website with CMS integration.',
      imageUrl: 'assets/images/project6.jpg',
      category: 'Web',
      technologies: ['JavaScript', 'WordPress', 'PHP'],
      demoUrl: 'https://example.com/corporate-demo',
      githubUrl: null,
    ),
  ];

  List<ProjectItem> get _filteredProjects {
    if (_currentFilter == 'All') {
      return _projects;
    }
    return _projects
        .where((project) => project.category == _currentFilter)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Projects')),
      body: Column(
        children: [
          // Filter Chips
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 16.0,
              horizontal: 8.0,
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children:
                    _filters.map((filter) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: FilterChip(
                          selected: _currentFilter == filter,
                          label: Text(filter),
                          onSelected: (selected) {
                            setState(() {
                              _currentFilter = filter;
                            });
                          },
                        ),
                      );
                    }).toList(),
              ),
            ),
          ),

          // Projects Grid
          Expanded(
            child:
                _filteredProjects.isEmpty
                    ? const Center(
                      child: Text('No projects found for this category.'),
                    )
                    : GridView.builder(
                      padding: const EdgeInsets.all(16.0),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.75,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                          ),
                      itemCount: _filteredProjects.length,
                      itemBuilder: (context, index) {
                        final project = _filteredProjects[index];
                        return _buildProjectCard(context, project);
                      },
                    ),
          ),
        ],
      ),
    );
  }

  Widget _buildProjectCard(BuildContext context, ProjectItem project) {
    return GestureDetector(
      onTap: () => _showProjectDetails(context, project),
      child: Card(
        elevation: 4,
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Project Image
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(color: Colors.grey.shade200),
                child: Image.asset(
                  project.imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Center(child: Icon(Icons.image, size: 50));
                  },
                ),
              ),
            ),

            // Project Info
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    project.title,
                    style: Theme.of(context).textTheme.titleMedium,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    project.description,
                    style: Theme.of(context).textTheme.bodySmall,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Chip(
                    label: Text(
                      project.category,
                      style: const TextStyle(fontSize: 12),
                    ),
                    padding: EdgeInsets.zero,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showProjectDetails(BuildContext context, ProjectItem project) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.7,
          maxChildSize: 0.9,
          minChildSize: 0.5,
          expand: false,
          builder: (context, scrollController) {
            return SingleChildScrollView(
              controller: scrollController,
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Image
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      project.imageUrl,
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          height: 200,
                          width: double.infinity,
                          color: Colors.grey.shade200,
                          child: const Center(
                            child: Icon(Icons.image, size: 50),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Title
                  Text(
                    project.title,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),

                  // Category
                  Chip(label: Text(project.category)),
                  const SizedBox(height: 12),

                  // Description
                  Text(
                    'Description',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(project.description),
                  const SizedBox(height: 16),

                  // Technologies
                  Text(
                    'Technologies',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children:
                        project.technologies.map((tech) {
                          return Chip(label: Text(tech));
                        }).toList(),
                  ),
                  const SizedBox(height: 16),

                  // Links
                  Text(
                    'Links',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      ElevatedButton.icon(
                        onPressed: () => _launchUrl(project.demoUrl),
                        icon: const Icon(Icons.open_in_new),
                        label: const Text('Live Demo'),
                      ),
                      const SizedBox(width: 8),
                      if (project.githubUrl != null)
                        OutlinedButton.icon(
                          onPressed: () => _launchUrl(project.githubUrl!),
                          icon: const Icon(Icons.code),
                          label: const Text('GitHub'),
                        ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Future<void> _launchUrl(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Could not launch URL')));
      }
    }
  }
}

class ProjectItem {
  final String title;
  final String description;
  final String imageUrl;
  final String category;
  final List<String> technologies;
  final String demoUrl;
  final String? githubUrl;

  ProjectItem({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.category,
    required this.technologies,
    required this.demoUrl,
    this.githubUrl,
  });
}
