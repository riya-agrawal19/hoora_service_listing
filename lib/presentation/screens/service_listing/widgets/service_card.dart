import 'package:flutter/material.dart';
import 'package:hoora_service_listing/core/utils/extensions/custom_theme_extension.dart';
import 'package:hoora_service_listing/data/models/service_model.dart';

class ServiceCard extends StatelessWidget {
  const ServiceCard({
    super.key,
    required this.service,
    required this.onFavorite,
    this.imageProvider,
  });

  final ServiceModel service;
  final void Function(ServiceModel) onFavorite;
  final ImageProvider? imageProvider;

  @override
  Widget build(BuildContext context) {
    final customTheme = Theme.of(context).extension<CustomThemeExtension>()!;
    return Stack(
      children: [
        ListTile(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(color: customTheme.outlineColor, width: 0.8),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 8,
          ),
          leading: CircleAvatar(backgroundImage: imageProvider ?? NetworkImage(service.image)),
          title: Text(
            service.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Text('${service.category} • ₹${service.price}'),
          onTap: () {},
        ),
        Positioned(
          top: 2,
          right: 6,
          child: Material(
            color: Colors.transparent,
            child: IconButton(
              visualDensity: VisualDensity.compact,
              splashRadius: 20,
              icon: Icon(
                service.isFavorite ? Icons.favorite : Icons.favorite_border,
                color: service.isFavorite ? Colors.red : Colors.grey,
              ),
              onPressed: () => onFavorite(service),
            ),
          ),
        ),
      ],
    );
  }
}
