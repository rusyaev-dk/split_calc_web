import 'package:flutter/material.dart';
import 'package:split_calculator/app/app.dart';

class MinimalCard extends StatelessWidget {
  const MinimalCard({
    required this.child,
    this.padding = const EdgeInsets.all(16),
    super.key,
  });
  final Widget child;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    final c = context.colorScheme;
    return Container(
      decoration: BoxDecoration(
        color: c.sectionBackgroundColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: c.outlineVariant),
      ),
      padding: padding,
      child: child,
    );
  }
}

class Metric extends StatelessWidget {
  const Metric({required this.label, required this.value, super.key});
  final String label, value;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: colorScheme.outlineVariant),
      ),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 12, color: colorScheme.onSurfaceVariant),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
          ),
        ],
      ),
    );
  }
}

class HoverChip extends StatelessWidget {
  const HoverChip({required this.label, required this.onDelete, super.key});
  final String label;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: InputChip(
        label: Text(label, style: TextStyle(color: colorScheme.onSurface)),
        backgroundColor: colorScheme.surfaceContainerLow,
        side: BorderSide(color: colorScheme.outlineVariant),
        deleteIcon: Icon(
          Icons.close,
          size: 18,
          color: colorScheme.onSurfaceVariant,
        ),
        onDeleted: onDelete,
      ),
    );
  }
}
