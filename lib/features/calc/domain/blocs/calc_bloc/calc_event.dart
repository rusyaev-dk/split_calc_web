part of 'calc_bloc.dart';

abstract class CalcEvent {}

class CalcLoadEvent extends CalcEvent {}

class CalcAddParticipantEvent extends CalcEvent {
  final Participant participant;
  CalcAddParticipantEvent(this.participant);
}

class CalcAddExpenseEvent extends CalcEvent {
  final Expense expense;
  CalcAddExpenseEvent(this.expense);
}

class CalcRemoveParticipantEvent extends CalcEvent {
  final String participantId;
  CalcRemoveParticipantEvent(this.participantId);
}

class CalcRemoveExpenseEvent extends CalcEvent {
  final String expenseId;
  CalcRemoveExpenseEvent(this.expenseId);
}

class CalcClearEvent extends CalcEvent {}
