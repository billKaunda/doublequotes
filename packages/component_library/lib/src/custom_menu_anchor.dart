import 'package:flutter/material.dart';
import 'package:component_library/component_library.dart';

class CustomMenuAnchor extends StatefulWidget {
  const CustomMenuAnchor({
    super.key,
    this.focusNode,
    this.menuChildren,
    this.controller,
  });

  final FocusNode? focusNode;
  final List<CustomMenuItemButton>? menuChildren;
  final MenuController? controller;

  @override
  State<CustomMenuAnchor> createState() => _CustomMenuAnchorState();
}

class _CustomMenuAnchorState extends State<CustomMenuAnchor> {
  late final FocusNode _focusNode;
  late final MenuController _controller;
  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
    _controller = widget.controller ?? MenuController();
  }

  @override
  void dispose() {
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final wallpaperTheme = WallpaperDoubleQuotesTheme.maybeOf(context);
    final defaultTheme = DefaultDoubleQuotesTheme.maybeOf(context);

    if (wallpaperTheme != null) {
      return FutureBuilder(
        future: wallpaperTheme.themeData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CenteredCircularProgressIndicator();
          } else if (snapshot.hasError) {
            return const ExceptionIndicator(
                title: 'Theme Error',
                message: 'Error loading CustomMenuAnchor Theme');
          } else if (snapshot.hasData) {
            return buildMenuAnchor(snapshot.data!);
          } else {
            return const ExceptionIndicator(
                title: 'Theme Error',
                message: 'Error loading CustomMenuAnchor Theme');
          }
        },
      );
    } else if (defaultTheme != null) {
      return buildMenuAnchor(defaultTheme.materialThemeData);
    } else {
      return const ExceptionIndicator(
        title: 'Theme Error',
        message: 'No valid theme available for CustomMenuAnchor',
      );
    }
  }

  MenuAnchor buildMenuAnchor(ThemeData theme) {
    return MenuAnchor(
      controller: _controller,
      builder: (context, controller, child) => IconButton(
        focusNode: _focusNode,
        onPressed: () =>
            controller.isOpen ? controller.close() : controller.open(),
        icon: const Icon(
          Icons.more_vert,
        ),
      ),
      menuChildren: widget.menuChildren ?? <CustomMenuItemButton>[],
      style: MenuStyle(
        backgroundColor:
            theme.colorScheme.surfaceContainerLow as WidgetStateColor,
        shadowColor:
            theme.colorScheme.surfaceContainerLowest as WidgetStateColor,
      ),
    );
  }
}
