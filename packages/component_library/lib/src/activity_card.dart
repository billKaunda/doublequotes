import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';

const double borderRadius = 12;

class ActivityCard extends StatelessWidget {
  const ActivityCard({
    super.key,
    this.ownerType,
    this.ownerValue,
    this.action,
    this.trackableType,
    this.trackableValue,
    this.message,
    this.onLongPress,
  });

  final String? ownerType;
  final String? ownerValue;
  final String? action;
  final String? trackableType;
  final String? trackableValue;
  final String? message;
  final VoidCallback? onLongPress;

  @override
  Widget build(BuildContext context) {
    final wallpaperTheme = WallpaperDoubleQuotesTheme.maybeOf(context);
    final defaultTheme = DefaultDoubleQuotesTheme.maybeOf(context);

    if (wallpaperTheme != null) {
      return FutureBuilder<ThemeData>(
        future: wallpaperTheme.themeData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CenteredCircularProgressIndicator();
          } else if (snapshot.hasError) {
            return const ExceptionIndicator(
                title: 'Theme Error',
                message: 'Error loading ActivityCard Theme');
          } else if (snapshot.hasData) {
            final theme = snapshot.data!;
            return buildCard(context, theme);
          } else {
            return const ExceptionIndicator(
              title: 'Theme Error',
              message: 'Unable to load ActivityCard theme',
            );
          }
        },
      );
    } else if (defaultTheme != null) {
      return buildCard(
        context,
        defaultTheme.materialThemeData,
      );
    } else {
      return const ExceptionIndicator(
        title: 'Theme Error',
        message: 'No valid theme available for ActivityCard',
      );
    }
  }

  Card buildCard(BuildContext context, ThemeData theme) {
    return Card(
      margin: const EdgeInsets.all(0),
      color: theme.colorScheme.surface,
      shadowColor: theme.colorScheme.surfaceDim,
      elevation: 4.0,
      surfaceTintColor: theme.colorScheme.surfaceTint,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: InkWell(
        onLongPress: onLongPress,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                //Header: Owner Type and action
                Icon(
                  ownerType == 'Author'
                      ? Icons.menu_book
                      : ownerType == 'Tag'
                          ? Icons.loyalty
                          : Icons.person,
                ),
                const SizedBox(width: Spacing.small),
                Text(
                  '$ownerValue $action',
                  style: theme.textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: Spacing.medium),
                //Content: Trackable type and ID
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      trackableType == 'Quote'
                          ? Icons.format_quote
                          : trackableType == 'Tag'
                              ? Icons.loyalty
                              : trackableType == 'Author'
                                  ? Icons.menu_book
                                  : Icons.person_2,
                    ),
                    const SizedBox(width: Spacing.small),
                    Expanded(
                      child: Text(
                        trackableValue ?? '',
                        style: theme.textTheme.bodyLarge!.copyWith(
                          color: theme.colorScheme.onSurface,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: Spacing.medium),
                //Footer
                Text(
                  message ?? '',
                  style: theme.textTheme.bodyMedium!.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
