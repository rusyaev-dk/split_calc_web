import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:split_calculator/core/domain/domain.dart';
import 'package:split_calculator/features/calc/domain/domain.dart';
import 'package:split_calculator/features/home/presentation/presentation.dart';
import 'package:split_calculator/features/settings/presentation/presentation.dart';

enum _BP { sm, lg, xl }

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final TextEditingController _nameCtrl;
  late final TextEditingController _titleCtrl;
  late final TextEditingController _amountCtrl;
  String? _selectedPayer;

  @override
  void initState() {
    super.initState();
    _nameCtrl = TextEditingController();
    _titleCtrl = TextEditingController();
    _amountCtrl = TextEditingController();
    context.read<CalcBloc>().add(CalcLoadEvent());
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: cs.surface,
      appBar: HomeAppBar(),
      body: Stack(
        fit: StackFit.expand,
        children: [
          const GradientBackground(),
          BlocBuilder<CalcBloc, CalcState>(
            builder: (context, state) {
              final width = MediaQuery.of(context).size.width;
              final bp = _breakpoint(width);

              final participants = ParticipantsSection(nameCtrl: _nameCtrl);
              final expenses = ExpensesSection(
                titleCtrl: _titleCtrl,
                amountCtrl: _amountCtrl,
                selectedPayer: _selectedPayer,
                onSelectedPayerChanged: (v) =>
                    setState(() => _selectedPayer = v),
                onSubmit: () => _tryAddExpense(context),
              );
              final summary = SummarySection();

              Widget layout;
              if (bp == _BP.xl) {
                // 3 колонки: участники | расходы | итоги (фикс ширина)
                layout = Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: participants),
                    const SizedBox(width: 16),
                    Expanded(child: expenses),
                    const SizedBox(width: 16),
                    SizedBox(width: 360, child: summary),
                  ],
                );
              } else if (bp == _BP.lg) {
                // 2 колонки и итоги внизу
                layout = Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: participants),
                    const SizedBox(width: 16),
                    Expanded(child: expenses),
                  ],
                );
              } else {
                // Мобильный / узкий web: список
                layout = Column(
                  children: [
                    participants,
                    const SizedBox(height: 16),
                    expenses,
                    const SizedBox(height: 16),
                    summary,
                  ],
                );
              }

              return Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1280),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            padding: EdgeInsets.only(top: 60),
                            child: Column(
                              children: [
                                if (bp == _BP.xl) ...[
                                  // xl: summary уже в третьей колонке
                                  layout,
                                ] else if (bp == _BP.lg) ...[
                                  // lg: две колонки + summary снизу
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(child: participants),
                                      const SizedBox(width: 16),
                                      Expanded(child: expenses),
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                  summary,
                                ] else ...[
                                  // sm: список (у тебя уже есть)
                                  layout,
                                ],
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  _BP _breakpoint(double width) {
    if (width >= 1280) return _BP.xl; // 3 колонки
    if (width >= 960) return _BP.lg; // 2 колонки
    return _BP.sm; // 1 колонка
  }

  void _tryAddExpense(BuildContext context) {
    final bloc = context.read<CalcBloc>();
    final state = bloc.state;
    if (state.data.participants.isEmpty) return;

    final payerId =
        _selectedPayer ??
        (state.data.participants.isNotEmpty
            ? state.data.participants.first.id
            : null);
    if (payerId == null) return;

    final raw = _amountCtrl.text.replaceAll(',', '.');
    final amount = double.tryParse(raw);
    if (amount == null || amount <= 0) return;

    final id = DateTime.now().microsecondsSinceEpoch.toString();
    final e = Expense(
      id: id,
      title: _titleCtrl.text.trim(),
      payerId: payerId,
      amount: amount,
    );
    bloc.add(CalcAddExpenseEvent(e));
    _titleCtrl.clear();
    _amountCtrl.clear();
    _selectedPayer = payerId; // запомним последнего плательщика
    setState(() {});
  }

  @override
  void dispose() {
    _amountCtrl.dispose();
    _nameCtrl.dispose();
    _titleCtrl.dispose();
    super.dispose();
  }
}

class HeaderBar extends StatelessWidget {
  const HeaderBar({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<CalcBloc>();
    final cs = Theme.of(context).colorScheme;
    return MinimalCard(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Icon(Icons.calculate_rounded, color: cs.primary),
          const SizedBox(width: 8),
          Text('SplitCalc', style: Theme.of(context).textTheme.titleMedium),
          const Spacer(),
          IconButton(
            onPressed: () => context.read<SettingsCubit>().swithTheme(),
            icon: Icon(Icons.nightlife),
          ),
          FilledButton.tonalIcon(
            onPressed: () => bloc.add(CalcClearEvent()),
            icon: const Icon(Icons.restart_alt_rounded),
            label: const Text('Сбросить'),
          ),
        ],
      ),
    );
  }
}
