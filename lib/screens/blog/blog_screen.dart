import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:port/screens/blog/blog_post_screen.dart';

class BlogScreen extends StatefulWidget {
  const BlogScreen({super.key});

  @override
  State<BlogScreen> createState() => _BlogScreenState();
}

class _BlogScreenState extends State<BlogScreen> {
  final List<BlogPost> _blogPosts = [];
  bool _isLoading = true;
  bool _hasError = false;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _loadBlogPosts();
  }

  Future<void> _loadBlogPosts() async {
    setState(() {
      _isLoading = true;
      _hasError = false;
    });

    try {
      // Try to load from cache first
      final cachedPosts = await _loadFromCache();
      if (cachedPosts.isNotEmpty) {
        setState(() {
          _blogPosts.clear();
          _blogPosts.addAll(cachedPosts);
          _isLoading = false;
        });
      }

      // Then try to fetch from API
      final posts = await _fetchBlogPosts();

      // Save to cache for offline use
      await _saveToCache(posts);

      if (mounted) {
        setState(() {
          _blogPosts.clear();
          _blogPosts.addAll(posts);
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          // If we have cached posts, still show them
          if (_blogPosts.isEmpty) {
            _hasError = true;
            _errorMessage = 'Failed to load blog posts: ${e.toString()}';
          }
          _isLoading = false;
        });
      }
    }
  }

  Future<List<BlogPost>> _fetchBlogPosts() async {
    // In a real app, replace with your actual API endpoint
    // This is just a mock implementation
    await Future.delayed(const Duration(seconds: 2)); // Simulate network delay

    // Simulating blog posts data (in a real app, this would come from an API)
    return [
      BlogPost(
        id: '1',
        title: 'Getting Started with Flutter',
        excerpt:
            'Learn the basics of Flutter development and create your first app.',
        content:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam euismod orci nec urna lacinia, id tincidunt quam tincidunt. Sed euismod, nisl nec aliquam aliquam, justo risus lacinia eros, nec aliquam risus nisi vel risus. Nulla facilisi...',
        imageUrl: 'assets/images/blog1.jpg',
        date: '2023-05-15',
        author: 'John Doe',
        tags: ['Flutter', 'Mobile Development', 'Dart'],
      ),
      BlogPost(
        id: '2',
        title: 'Advanced State Management in Flutter',
        excerpt:
            'Explore different state management techniques and choose the best one for your app.',
        content:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam euismod orci nec urna lacinia, id tincidunt quam tincidunt. Sed euismod, nisl nec aliquam aliquam, justo risus lacinia eros, nec aliquam risus nisi vel risus. Nulla facilisi...',
        imageUrl: 'assets/images/blog2.jpg',
        date: '2023-06-20',
        author: 'Jane Smith',
        tags: ['Flutter', 'State Management', 'Provider', 'Bloc'],
      ),
      BlogPost(
        id: '3',
        title: 'Responsive UI Design Techniques',
        excerpt:
            'Learn how to create responsive UIs that work well on any screen size.',
        content:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam euismod orci nec urna lacinia, id tincidunt quam tincidunt. Sed euismod, nisl nec aliquam aliquam, justo risus lacinia eros, nec aliquam risus nisi vel risus. Nulla facilisi...',
        imageUrl: 'assets/images/blog3.jpg',
        date: '2023-07-10',
        author: 'Alex Johnson',
        tags: ['UI/UX', 'Responsive Design', 'Flutter'],
      ),
      BlogPost(
        id: '4',
        title: 'Optimizing Flutter Performance',
        excerpt: 'Tips and tricks to make your Flutter app blazing fast.',
        content:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam euismod orci nec urna lacinia, id tincidunt quam tincidunt. Sed euismod, nisl nec aliquam aliquam, justo risus lacinia eros, nec aliquam risus nisi vel risus. Nulla facilisi...',
        imageUrl: 'assets/images/blog4.jpg',
        date: '2023-08-05',
        author: 'Sarah Williams',
        tags: ['Flutter', 'Performance', 'Optimization'],
      ),
    ];
  }

  Future<void> _saveToCache(List<BlogPost> posts) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonData = jsonEncode(posts.map((post) => post.toJson()).toList());
      await prefs.setString('cached_blog_posts', jsonData);
    } catch (e) {
      // Handle cache saving error
      debugPrint('Error saving to cache: $e');
    }
  }

  Future<List<BlogPost>> _loadFromCache() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonData = prefs.getString('cached_blog_posts');

      if (jsonData != null) {
        final List<dynamic> decodedData = jsonDecode(jsonData);
        return decodedData.map((item) => BlogPost.fromJson(item)).toList();
      }
    } catch (e) {
      // Handle cache loading error
      debugPrint('Error loading from cache: $e');
    }

    return [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blog'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadBlogPosts,
          ),
        ],
      ),
      body:
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : _hasError
              ? Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.error_outline,
                        size: 48,
                        color: Colors.red,
                      ),
                      const SizedBox(height: 16),
                      Text(_errorMessage),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: _loadBlogPosts,
                        child: const Text('Try Again'),
                      ),
                    ],
                  ),
                ),
              )
              : _blogPosts.isEmpty
              ? const Center(child: Text('No blog posts available.'))
              : ListView.builder(
                padding: const EdgeInsets.all(16.0),
                itemCount: _blogPosts.length,
                itemBuilder: (context, index) {
                  final post = _blogPosts[index];
                  return _buildBlogPostCard(context, post);
                },
              ),
    );
  }

  Widget _buildBlogPostCard(BuildContext context, BlogPost post) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 16),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => _navigateToBlogPost(context, post),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Featured Image
            Container(
              height: 180,
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
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Icon(Icons.person, size: 12),
                      const SizedBox(width: 4),
                      Text(
                        post.author,
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // Title
                  Text(
                    post.title,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),

                  // Excerpt
                  Text(
                    post.excerpt,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 16),

                  // Tags
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children:
                        post.tags.map((tag) {
                          return Chip(
                            label: Text(
                              tag,
                              style: const TextStyle(fontSize: 12),
                            ),
                            padding: EdgeInsets.zero,
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                          );
                        }).toList(),
                  ),
                  const SizedBox(height: 12),

                  // Read More Button
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton.icon(
                      icon: const Icon(Icons.arrow_forward),
                      label: const Text('Read More'),
                      onPressed: () => _navigateToBlogPost(context, post),
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

  void _navigateToBlogPost(BuildContext context, BlogPost post) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => BlogPostScreen(post: post)),
    );
  }
}

class BlogPost {
  final String id;
  final String title;
  final String excerpt;
  final String content;
  final String imageUrl;
  final String date;
  final String author;
  final List<String> tags;

  BlogPost({
    required this.id,
    required this.title,
    required this.excerpt,
    required this.content,
    required this.imageUrl,
    required this.date,
    required this.author,
    required this.tags,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'excerpt': excerpt,
      'content': content,
      'imageUrl': imageUrl,
      'date': date,
      'author': author,
      'tags': tags,
    };
  }

  factory BlogPost.fromJson(Map<String, dynamic> json) {
    return BlogPost(
      id: json['id'],
      title: json['title'],
      excerpt: json['excerpt'],
      content: json['content'],
      imageUrl: json['imageUrl'],
      date: json['date'],
      author: json['author'],
      tags: List<String>.from(json['tags']),
    );
  }
}
