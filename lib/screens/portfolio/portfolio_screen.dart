import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class PortfolioScreen extends StatefulWidget {
  const PortfolioScreen({super.key});

  @override
  State<PortfolioScreen> createState() => _PortfolioScreenState();
}

class _PortfolioScreenState extends State<PortfolioScreen> {
  bool _isGridView = true;
  String _selectedCategory = 'All';
  final List<String> _categories = [
    'All',
    'UI/UX',
    'Branding',
    'Photography',
    'Illustration',
  ];

  final List<PortfolioItem> _items = [
    PortfolioItem(
      title: 'Mobile App UI Design',
      description: 'UI/UX design for a mobile application',
      imageUrl: 'assets/images/portfolio1.jpg',
      category: 'UI/UX',
    ),
    PortfolioItem(
      title: 'Brand Identity',
      description: 'Brand identity design for a startup',
      imageUrl: 'assets/images/portfolio2.jpg',
      category: 'Branding',
    ),
    PortfolioItem(
      title: 'Product Photography',
      description: 'Professional product photography for an e-commerce store',
      imageUrl: 'assets/images/portfolio3.jpg',
      category: 'Photography',
    ),
    PortfolioItem(
      title: 'Custom Illustrations',
      description: 'Custom illustrations for a children\'s book',
      imageUrl: 'assets/images/portfolio4.jpg',
      category: 'Illustration',
    ),
    PortfolioItem(
      title: 'Website Redesign',
      description: 'Complete redesign of a corporate website',
      imageUrl: 'assets/images/portfolio5.jpg',
      category: 'UI/UX',
    ),
    PortfolioItem(
      title: 'Logo Collection',
      description: 'A collection of logo designs for various clients',
      imageUrl: 'assets/images/portfolio6.jpg',
      category: 'Branding',
    ),
    PortfolioItem(
      title: 'Event Photography',
      description: 'Photography for a corporate event',
      imageUrl: 'assets/images/portfolio7.jpg',
      category: 'Photography',
    ),
    PortfolioItem(
      title: 'Icon Set',
      description: 'Custom icon set for a mobile application',
      imageUrl: 'assets/images/portfolio8.jpg',
      category: 'Illustration',
    ),
  ];

  List<PortfolioItem> get _filteredItems {
    if (_selectedCategory == 'All') {
      return _items;
    }
    return _items.where((item) => item.category == _selectedCategory).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Portfolio'),
        actions: [
          // Grid/List View Toggle
          IconButton(
            icon: Icon(_isGridView ? Icons.view_list : Icons.grid_view),
            onPressed: () {
              setState(() {
                _isGridView = !_isGridView;
              });
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Category Filter
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 16.0,
              horizontal: 8.0,
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children:
                    _categories.map((category) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: FilterChip(
                          selected: _selectedCategory == category,
                          label: Text(category),
                          onSelected: (selected) {
                            setState(() {
                              _selectedCategory = category;
                            });
                          },
                        ),
                      );
                    }).toList(),
              ),
            ),
          ),

          // Gallery View
          Expanded(
            child:
                _filteredItems.isEmpty
                    ? const Center(
                      child: Text('No items found for this category.'),
                    )
                    : _isGridView
                    ? _buildGridView()
                    : _buildListView(),
          ),
        ],
      ),
    );
  }

  Widget _buildGridView() {
    return GridView.builder(
      padding: const EdgeInsets.all(16.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.0,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: _filteredItems.length,
      itemBuilder: (context, index) {
        final item = _filteredItems[index];
        return _buildPortfolioItem(item);
      },
    );
  }

  Widget _buildListView() {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: _filteredItems.length,
      itemBuilder: (context, index) {
        final item = _filteredItems[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: Card(
            elevation: 4,
            child: Row(
              children: [
                // Image
                SizedBox(
                  width: 120,
                  height: 120,
                  child: _buildImageThumbnail(item.imageUrl),
                ),
                // Text Info
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.title,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          item.description,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        const SizedBox(height: 8),
                        Chip(
                          label: Text(
                            item.category,
                            style: const TextStyle(fontSize: 12),
                          ),
                          padding: EdgeInsets.zero,
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildPortfolioItem(PortfolioItem item) {
    return GestureDetector(
      onTap: () => _showImagePreview(context, item),
      child: Card(
        elevation: 4,
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            Expanded(child: _buildImageThumbnail(item.imageUrl)),
            // Title
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: Theme.of(context).textTheme.titleSmall,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item.category,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageThumbnail(String imageUrl) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(color: Colors.grey.shade200),
      child: Image.asset(
        imageUrl,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return const Center(child: Icon(Icons.image, size: 50));
        },
      ),
    );
  }

  void _showImagePreview(BuildContext context, PortfolioItem item) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          insetPadding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Close Button
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
              // Image
              InteractiveViewer(
                minScale: 0.5,
                maxScale: 3.0,
                child: Image.asset(
                  item.imageUrl,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 300,
                      width: double.infinity,
                      color: Colors.grey.shade200,
                      child: const Center(child: Icon(Icons.image, size: 100)),
                    );
                  },
                ),
              ),
              // Details
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      item.description,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 8),
                    Chip(label: Text(item.category)),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class PortfolioItem {
  final String title;
  final String description;
  final String imageUrl;
  final String category;

  PortfolioItem({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.category,
  });
}
