import 'package:flutter/material.dart';

class HorizontalCardList extends StatelessWidget {
  final String sectionTitle;
  final List<Map<String, String>> items;
  final VoidCallback? onViewAll;

  const HorizontalCardList({
    super.key,
    required this.sectionTitle,
    required this.items,
    this.onViewAll,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionHeader(title: sectionTitle, onViewAll: onViewAll),
        const SizedBox(height: 8),
        SizedBox(
          height: 100,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: items.length,
            separatorBuilder: (context, index) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              final item = items[index];
              return PlaceCard(
                imageUrl: item['imageUrl']!,
                title: item['title']!,
              );
            },
          ),
        ),
      ],
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onViewAll;

  const _SectionHeader({required this.title, this.onViewAll});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(
            context,
          ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w400),
        ),
        SizedBox(
          height: 30,
          child: TextButton(
            onPressed: onViewAll,
            child: const Text('VIEW ALL', style: TextStyle(fontSize: 12)),
          ),
        ),
      ],
    );
  }
}

class PlaceCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final double width;

  const PlaceCard({
    super.key,
    required this.imageUrl,
    required this.title,
    this.width = 100,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              imageUrl,
              width: width,
              height: 60,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
