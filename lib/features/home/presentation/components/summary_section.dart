import 'package:flutter/material.dart';
import 'package:flutter_app_template/app/app_context_ext.dart';
import 'package:flutter_app_template/features/calc/domain/domain.dart';
import 'package:flutter_app_template/features/home/presentation/presentation.dart';
import 'package:flutter_app_template/uikit/uikit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SummarySection extends StatelessWidget {
  const SummarySection({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = AppColorScheme.of(context);
    final state = context.select<CalcBloc, CalcState>((b) => b.state);
    final total = state.data.expenses.fold<double>(0, (s, e) => s + e.amount);
    final n = state.data.participants.length;
    final share = n == 0 ? 0.0 : total / n;

    String nameOf(String id) =>
        state.data.participants.firstWhere((p) => p.id == id).name;

    return MinimalCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Итоги',
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(color: colorScheme.onSurface),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: Metric(label: 'Всего', value: total.toStringAsFixed(2)),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Metric(
                  label: 'На человека',
                  value: share.toStringAsFixed(2),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'Переводы для сведения:',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: colorScheme.onSurface),
          ),
          const SizedBox(height: 8),
          if (state.settlements.isEmpty)
            Text(
              'Добавьте участников и расходы, чтобы получить переводы.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ...state.settlements.map(
            (t) => _SummaryTile(
              nameFrom: nameOf(t.fromId),
              nameTo: nameOf(t.toId),
              amount: t.amount,
            ),
          ),
        ],
      ),
    );
  }
}

class _SummaryTile extends StatelessWidget {
  const _SummaryTile({
    required this.nameFrom,
    required this.nameTo,
    required this.amount,
  });

  final String nameFrom;
  final String nameTo;
  final double amount;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    final textScheme = context.textScheme;

    return Row(
      children: [
        Text(nameFrom, style: textScheme.headline.copyWith(fontSize: 21)),
        Icon(Icons.arrow_right, size: 25, color: colorScheme.onSurface),
        Text(nameTo, style: textScheme.headline.copyWith(fontSize: 21)),
        Spacer(),
        Text(
          amount.toStringAsFixed(0),
          style: textScheme.headline.copyWith(fontSize: 22),
        ),
      ],
    );
  }
}
