import 'package:flutter/material.dart';
import 'package:port/screens/blog/blog_screen.dart';
import 'package:share_plus/share_plus.dart';

class BlogPostScreen extends StatelessWidget {
  final BlogPost post;

  const BlogPostScreen({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blog Post'),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () => _sharePost(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Featured Image
            Container(
              height: 220,
              width: double.infinity,
              decoration: BoxDecoration(color: Colors.grey.shade200),
              child: Image.asset(
                post.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Center(child: Icon(Icons.image, size: 50));
                },
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Date and Author
                  Row(
                    children: [
                      Text(
                        post.date,
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(width: 16),
                      const Icon(Icons.person, size: 16),
                      const SizedBox(width: 4),
                      Text(
                        post.author,
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Title
                  Text(
                    post.title,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 16),

                  // Tags
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children:
                        post.tags.map((tag) {
                          return Chip(label: Text(tag));
                        }).toList(),
                  ),
                  const SizedBox(height: 24),

                  // Content
                  Text(
                    post.content,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),

                  const SizedBox(height: 32),

                  // Related Content Section (Placeholder)
                  Text(
                    'Related Posts',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),

                  // This would typically be populated with actual related posts
                  // For now, we'll just show a placeholder
                  Container(
                    height: 120,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Center(
                      child: Text('Related posts would appear here'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _sharePost(BuildContext context) {
    Share.share('Check out this blog post: ${post.title}\n\n${post.excerpt}');
  }
}
