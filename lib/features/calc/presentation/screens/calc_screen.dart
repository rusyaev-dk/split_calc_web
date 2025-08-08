import 'package:flutter/material.dart';
import 'package:flutter_app_template/features/calc/domain/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CalcScreen extends StatelessWidget {
  const CalcScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Калькулятор дележки'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_forever),
            onPressed: () => context.read<CalcBloc>().add(CalcClearEvent()),
          ),
        ],
      ),
      body: BlocBuilder<CalcBloc, CalcState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      Text(
                        'Участники',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      ...state.data.participants.map(
                        (p) => ListTile(
                          title: Text(p.name),
                          trailing: IconButton(
                            icon: const Icon(Icons.close),
                            onPressed: () => context.read<CalcBloc>().add(
                              CalcRemoveParticipantEvent(p.id),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Траты',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      ...state.data.expenses.map(
                        (e) => ListTile(
                          title: Text(e.amount.toStringAsFixed(2)),
                          subtitle: Text(
                            'Платил: ${state.data.participants.firstWhere((p) => p.id == e.payerId).name}',
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.close),
                            onPressed: () => context.read<CalcBloc>().add(
                              CalcRemoveExpenseEvent(e.id),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Итог',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      ...state.settlements.map(
                        (t) => ListTile(
                          title: Text('${t.fromId} → ${t.toId}'),
                          trailing: Text(t.amount.toStringAsFixed(2)),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.person_add),
                        label: const Text('Добавить участника'),
                        onPressed: () {
                          // TODO: показать диалог добавления
                        },
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.add_shopping_cart),
                        label: const Text('Добавить трату'),
                        onPressed: () {
                          // TODO: показать диалог добавления
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
