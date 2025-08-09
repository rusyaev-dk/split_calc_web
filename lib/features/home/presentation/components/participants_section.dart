import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:split_calculator/app/app.dart';
import 'package:split_calculator/core/domain/domain.dart';
import 'package:split_calculator/features/calc/domain/domain.dart';
import 'package:split_calculator/features/home/presentation/components/components.dart';

class ParticipantsSection extends StatelessWidget {
  const ParticipantsSection({required this.nameCtrl, super.key});
  final TextEditingController nameCtrl;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    final textScheme = context.textScheme;
    final participants = context.select<CalcBloc, List<Participant>>(
      (b) => b.state.data.participants,
    );
    final bloc = context.read<CalcBloc>();

    void add() {
      final name = nameCtrl.text.trim();
      if (name.isEmpty) return;
      final id = DateTime.now().microsecondsSinceEpoch.toString();
      bloc.add(CalcAddParticipantEvent(Participant(id: id, name: name)));
      nameCtrl.clear();
    }

    return MinimalCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Участники',
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(color: colorScheme.onSurface),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                flex: 4,
                child: TextField(
                  controller: nameCtrl,
                  decoration: InputDecoration(
                    labelText: 'Имя',
                    hintText: 'Например, Алиса',
                    prefixIcon: Icon(
                      Icons.person_add_alt_1_outlined,
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                  onSubmitted: (_) => add(),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                flex: 2,
                child: FilledButton(
                  onPressed: add,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Добавить',
                      style: textScheme.headline.copyWith(fontSize: 17),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final p in participants)
                HoverChip(
                  label: p.name,
                  onDelete: () => bloc.add(CalcRemoveParticipantEvent(p.id)),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
