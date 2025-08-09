import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:split_calculator/app/app.dart';
import 'package:split_calculator/features/home/presentation/presentation.dart';
import 'package:split_calculator/features/settings/presentation/presentation.dart';

class HomeAppBar extends StatefulWidget implements PreferredSizeWidget {
  const HomeAppBar({
    super.key,
    this.scrollController,
    this.title = 'SplitCalc',
  });

  final ScrollController? scrollController;
  final String title;

  @override
  State<HomeAppBar> createState() => _HomeAppBarState();

  @override
  Size get preferredSize => const Size(double.infinity, 60);
}

class _HomeAppBarState extends State<HomeAppBar> {
  ScrollController? _controller;
  bool _scrolledUnder = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _attachController(
      widget.scrollController ?? PrimaryScrollController.of(context),
    );
  }

  @override
  void didUpdateWidget(covariant HomeAppBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.scrollController != widget.scrollController) {
      _attachController(
        widget.scrollController ?? PrimaryScrollController.of(context),
      );
    }
  }

  void _attachController(ScrollController? c) {
    _controller?.removeListener(_onScroll);
    _controller = c;
    _controller?.addListener(_onScroll);
    _onScroll();
  }

  void _onScroll() {
    final offset = _controller?.hasClients == true ? _controller!.offset : 0.0;
    final next = offset > 0;
    if (next != _scrolledUnder && mounted) {
      setState(() => _scrolledUnder = next);
    }
  }

  @override
  void dispose() {
    _controller?.removeListener(_onScroll);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    final isDark = context.read<SettingsCubit>().state.theme == AppTheme.dark;

    // Чем больше скролл, тем менее прозрачный фон
    final opacity = _scrolledUnder ? 0.75 : 0.4;
    final blur = _scrolledUnder ? 20.0 : 12.0;

    return Container(
      // Чтобы эффект был заметен — не закрашиваем полностью
      color: Colors.transparent,
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            height: widget.preferredSize.height,
            decoration: BoxDecoration(
              color: colorScheme.surface.withOpacity(opacity),
              border: Border(
                bottom: BorderSide(
                  color: colorScheme.outlineVariant.withOpacity(0.6),
                ),
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            alignment: Alignment.center,
            child: Row(
              children: [
                Text(
                  widget.title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: colorScheme.onSurface,
                  ),
                ),
                const Spacer(),
                ThemeSwitcher(initialIsDark: isDark),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
