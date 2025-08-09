import 'package:bloc/bloc.dart';
import 'package:split_calculator/core/data/data.dart';
import 'package:split_calculator/core/domain/domain.dart';

part 'calc_event.dart';
part 'calc_state.dart';

class CalcBloc extends Bloc<CalcEvent, CalcState> {
  CalcBloc({required this.storage}) : super(CalcState.initial()) {
    on<CalcLoadEvent>(_onLoad);
    on<CalcAddParticipantEvent>(_onAddParticipant);
    on<CalcRemoveParticipantEvent>(_onRemoveParticipant);
    on<CalcAddExpenseEvent>(_onAddExpense);
    on<CalcRemoveExpenseEvent>(_onRemoveExpense);
    on<CalcClearEvent>(_onClear);
  }

  final SharedPrefsStorage storage;

  Future<void> _onLoad(CalcLoadEvent event, Emitter<CalcState> emit) async {
    final data =
        await storage.loadAppData() ??
        const AppData(participants: [], expenses: []);
    emit(state.copyWith(data: data, settlements: calculateSettlements(data)));
  }

  Future<void> _onAddParticipant(
    CalcAddParticipantEvent event,
    Emitter<CalcState> emit,
  ) async {
    final newData = state.data.copyWith(
      participants: [...state.data.participants, event.participant],
    );
    await storage.saveAppData(newData);
    emit(
      state.copyWith(data: newData, settlements: calculateSettlements(newData)),
    );
  }

  Future<void> _onRemoveParticipant(
    CalcRemoveParticipantEvent event,
    Emitter<CalcState> emit,
  ) async {
    final newData = state.data.copyWith(
      participants: state.data.participants
          .where((p) => p.id != event.participantId)
          .toList(),
      expenses: state.data.expenses
          .where((e) => e.payerId != event.participantId)
          .toList(),
    );
    await storage.saveAppData(newData);
    emit(
      state.copyWith(data: newData, settlements: calculateSettlements(newData)),
    );
  }

  Future<void> _onAddExpense(
    CalcAddExpenseEvent event,
    Emitter<CalcState> emit,
  ) async {
    final newData = state.data.copyWith(
      expenses: [...state.data.expenses, event.expense],
    );
    await storage.saveAppData(newData);
    emit(
      state.copyWith(data: newData, settlements: calculateSettlements(newData)),
    );
  }

  Future<void> _onRemoveExpense(
    CalcRemoveExpenseEvent event,
    Emitter<CalcState> emit,
  ) async {
    final newData = state.data.copyWith(
      expenses: state.data.expenses
          .where((e) => e.id != event.expenseId)
          .toList(),
    );
    await storage.saveAppData(newData);
    emit(
      state.copyWith(data: newData, settlements: calculateSettlements(newData)),
    );
  }

  Future<void> _onClear(CalcClearEvent event, Emitter<CalcState> emit) async {
    await storage.clearAppData();
    emit(CalcState.initial());
  }

  List<Transfer> calculateSettlements(AppData data) {
    final people = data.participants;
    if (people.isEmpty) return const [];

    final paidBy = <String, double>{for (final p in people) p.id: 0};
    for (final e in data.expenses) {
      paidBy[e.payerId] = (paidBy[e.payerId] ?? 0) + e.amount;
    }

    final total = data.expenses.fold<double>(0, (s, e) => s + e.amount);
    final share = total / people.length;

    // Баланс: >0 — должен получить, <0 — должен заплатить
    final creditors = <MapEntry<String, double>>[];
    final debtors = <MapEntry<String, double>>[];

    for (final p in people) {
      final bal = (paidBy[p.id] ?? 0) - share;
      if (bal > 1e-6) {
        creditors.add(MapEntry(p.id, bal));
      } else if (bal < -1e-6) {
        debtors.add(MapEntry(p.id, bal));
      }
    }

    final res = <Transfer>[];
    var i = 0, j = 0;

    // Жадно сводим кред/дебт
    while (i < creditors.length && j < debtors.length) {
      final cred = creditors[i];
      final debt = debtors[j];
      final give = cred.value;
      final need = -debt.value;
      final amount = give < need ? give : need;
      if (amount > 1e-6) {
        res.add(
          Transfer(
            fromId: debt.key,
            toId: cred.key,
            amount: double.parse(amount.toStringAsFixed(2)),
          ),
        );
      }
      creditors[i] = MapEntry(cred.key, cred.value - amount);
      debtors[j] = MapEntry(debt.key, debt.value + amount);
      if (creditors[i].value <= 1e-6) i++;
      if (debtors[j].value >= -1e-6) j++;
    }
    return res;
  }
}
