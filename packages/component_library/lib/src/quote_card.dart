import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';

class QuoteCard extends StatelessWidget {
  const QuoteCard({
    super.key,
    required this.statement,
    required this.isFavorite,
    this.isHidden,
    this.isPrivate,
    this.author,
    this.top,
    this.bottom,
    this.onTap,
    this.onFavorite,
    this.onHide,
    this.onPrivate,
  });

  final String statement;
  final bool isFavorite;
  final bool? isHidden;
  final bool? isPrivate;
  final String? author;
  final Widget? top;
  final Widget? bottom;
  final VoidCallback? onTap;
  final VoidCallback? onFavorite;
  final VoidCallback? onHide;
  final VoidCallback? onPrivate;

  @override
  Widget build(BuildContext context) {
    final top = this.top;
    final bottom = this.bottom;
    final author = this.author;

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
              message: 'Error loading QuoteCard Theme',
            );
          } else if (snapshot.hasData) {
            return buildCard(
              snapshot.data!,
              top,
              bottom,
              author,
              wallpaperTheme: wallpaperTheme,
            );
          } else {
            return const ExceptionIndicator(
              title: 'Theme Error',
              message: 'Unable to load QuoteCard theme',
            );
          }
        },
      );
    } else if (defaultTheme != null) {
      return buildCard(
        defaultTheme.materialThemeData,
        top,
        bottom,
        author,
        defaultTheme: defaultTheme,
      );
    } else {
      return const ExceptionIndicator(
        title: 'Theme Error',
        message: 'No valid theme available for QuoteCard',
      );
    }
  }

  Card buildCard(
    ThemeData theme,
    Widget? top,
    Widget? bottom,
    String? author, {
    DQThemeDataFromWallpaper? wallpaperTheme,
    DefaultDQThemeData? defaultTheme,
  }) {
    return Card(
      margin: const EdgeInsets.all(0),
      color: theme.colorScheme.surface,
      shadowColor: theme.colorScheme.surfaceDim,
      elevation: 4.0,
      surfaceTintColor: theme.colorScheme.surfaceTint,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              children: [
                if (top != null)
                  Padding(
                    padding: const EdgeInsets.only(left: Spacing.medium),
                    child: top,
                  ),
                const Spacer(),
                IconButton(
                  onPressed: onFavorite,
                  icon: Icon(
                    isFavorite
                        ? Icons.favorite
                        : Icons.favorite_border_outlined,
                    color: isFavorite
                        ? theme.colorScheme.onTertiaryContainer
                        : theme.colorScheme.tertiaryContainer,
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: onHide,
                  icon: Icon(
                    isHidden == true ? Icons.visibility_off : Icons.visibility,
                    color: isHidden == true
                        ? theme.colorScheme.onTertiaryFixedVariant
                        : theme.colorScheme.tertiaryFixed,
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: onPrivate,
                  icon: Icon(
                    isPrivate == true ? Icons.public_off : Icons.public,
                    color: isPrivate == true
                        ? theme.colorScheme.onTertiaryFixed
                        : theme.colorScheme.tertiaryFixedDim,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: Spacing.xLarge,
              ),
              child: Text(
                statement,
                style: wallpaperTheme != null
                    ? wallpaperTheme.quoteTextStyle.copyWith(
                        fontSize: FontSize.large,
                      )
                    : defaultTheme!.quoteTextStyle.copyWith(
                        fontSize: FontSize.large,
                      ),
              ),
            ),
            if (bottom != null)
              Padding(
                padding: const EdgeInsets.only(
                  right: Spacing.medium,
                ),
                child: bottom,
              ),
            const SizedBox(
              height: Spacing.mediumLarge,
            ),
            if (author != null)
              Padding(
                padding: const EdgeInsets.only(
                  bottom: Spacing.medium,
                  right: Spacing.medium,
                ),
                child: Text(author),
              ),
          ],
        ),
      ),
    );
  }
}
