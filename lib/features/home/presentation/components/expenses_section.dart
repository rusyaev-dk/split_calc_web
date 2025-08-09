import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_template/app/app.dart';
import 'package:flutter_app_template/core/domain/domain.dart';
import 'package:flutter_app_template/features/calc/domain/domain.dart';
import 'package:flutter_app_template/features/home/presentation/presentation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExpensesSection extends StatelessWidget {
  const ExpensesSection({
    required this.titleCtrl,
    required this.amountCtrl,
    required this.selectedPayer,
    required this.onSelectedPayerChanged,
    required this.onSubmit,
    super.key,
  });

  final TextEditingController titleCtrl, amountCtrl;
  final String? selectedPayer;
  final ValueChanged<String?> onSelectedPayerChanged;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    final bloc = context.read<CalcBloc>();
    final data = context.select<CalcBloc, AppData>((b) => b.state.data);

    final ids = data.participants.map((p) => p.id).toList(growable: false);
    final safeValue = (selectedPayer != null && ids.contains(selectedPayer))
        ? selectedPayer
        : (ids.isNotEmpty ? ids.first : null);

    return MinimalCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Добавить расход',
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(color: colorScheme.onSurface),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: titleCtrl,
            decoration: InputDecoration(
              labelText: 'Описание',
              hintText: 'Например, пицца',
              prefixIcon: Icon(
                Icons.edit_outlined,
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: DropdownButtonFormField<String>(
                  key: ValueKey(ids.join(',')),
                  initialValue: safeValue, // <-- было initialValue
                  decoration: InputDecoration(
                    labelText: 'Кто платил',
                    prefixIcon: Icon(
                      Icons.account_circle_outlined,
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                  items: [
                    for (final p in data.participants)
                      DropdownMenuItem(value: p.id, child: Text(p.name)),
                  ],
                  onChanged: onSelectedPayerChanged,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: TextField(
                  controller: amountCtrl,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9\.,]')),
                  ],
                  decoration: InputDecoration(
                    labelText: 'Сумма',
                    hintText: '0.00',
                    prefixIcon: Icon(
                      Icons.payments_outlined,
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                  onSubmitted: (_) => onSubmit(),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          FilledButton.icon(
            onPressed: data.participants.isEmpty ? null : onSubmit,
            icon: const Icon(Icons.add),
            label: const Text('Добавить'),
          ),
          const SizedBox(height: 12),
          Divider(height: 24, color: colorScheme.outlineVariant),
          ...data.expenses.map((e) {
            final payer = data.participants
                .firstWhere((p) => p.id == e.payerId)
                .name;
            return ListTile(
              dense: true,
              contentPadding: EdgeInsets.zero,
              leading: Icon(
                Icons.receipt_long_outlined,
                color: colorScheme.onSurfaceVariant,
              ),
              title: Text(
                e.title.isEmpty ? 'Без описания' : e.title,
                style: TextStyle(color: colorScheme.onSurface),
              ),
              subtitle: Text(
                '$payer • ${e.amount.toStringAsFixed(2)}',
                style: TextStyle(color: colorScheme.onSurfaceVariant),
              ),
              trailing: IconButton(
                icon: Icon(
                  Icons.delete_outline,
                  color: colorScheme.onSurfaceVariant,
                ),
                onPressed: () => bloc.add(CalcRemoveExpenseEvent(e.id)),
              ),
            );
          }),
        ],
      ),
    );
  }
}
