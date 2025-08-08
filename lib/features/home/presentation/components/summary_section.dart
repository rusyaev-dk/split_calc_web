import 'package:flutter/material.dart';
import 'package:flutter_app_template/features/calc/domain/domain.dart';
import 'package:flutter_app_template/features/home/presentation/presentation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SummarySection extends StatelessWidget {
  const SummarySection({super.key});
  @override
  Widget build(BuildContext context) {
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
          Text('Итоги', style: Theme.of(context).textTheme.titleMedium),
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
          const Text('Переводы для сведения:'),
          const SizedBox(height: 8),
          if (state.settlements.isEmpty)
            const Text(
              'Добавьте участников и расходы, чтобы получить переводы.',
            ),
          ...state.settlements.map(
            (t) => ListTile(
              dense: true,
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.swap_horiz),
              title: Text('${nameOf(t.fromId)} → ${nameOf(t.toId)}'),
              trailing: Text(t.amount.toStringAsFixed(2)),
            ),
          ),
        ],
      ),
    );
  }
}
