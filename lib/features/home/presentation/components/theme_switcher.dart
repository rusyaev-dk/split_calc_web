import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:split_calculator/app/app.dart';
import 'package:split_calculator/features/settings/presentation/presentation.dart';

class ThemeSwitcher extends StatefulWidget {
  const ThemeSwitcher({required this.initialIsDark, super.key});

  final bool initialIsDark;

  @override
  State<ThemeSwitcher> createState() => _ThemeSwitcherState();
}

class _ThemeSwitcherState extends State<ThemeSwitcher> {
  late bool _isDark;

  @override
  void initState() {
    _isDark = widget.initialIsDark;
    super.initState();
  }

  void _toggle() {
    context.read<SettingsCubit>().swithTheme();
    _isDark = !_isDark;
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;

    return GestureDetector(
      onTap: _toggle,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
        decoration: BoxDecoration(
          color: colorScheme.surfaceContainerLow,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: colorScheme.outlineVariant),
        ),
        width: 92,
        height: 40,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 6),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Icon(
                  Icons.wb_sunny_rounded,
                  size: 18,
                  color: _isDark
                      ? colorScheme.onSurfaceVariant
                      : colorScheme.primary,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 6),
              child: Align(
                alignment: Alignment.centerRight,
                child: Icon(
                  Icons.nights_stay_rounded,
                  size: 18,
                  color: _isDark
                      ? colorScheme.primary
                      : colorScheme.onSurfaceVariant,
                ),
              ),
            ),
            AnimatedAlign(
              alignment: _isDark ? Alignment.centerRight : Alignment.centerLeft,
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeOut,
              child: Container(
                width: 44,
                height: 28,
                decoration: BoxDecoration(
                  color: colorScheme.sectionBackgroundColor,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: colorScheme.outlineVariant),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
