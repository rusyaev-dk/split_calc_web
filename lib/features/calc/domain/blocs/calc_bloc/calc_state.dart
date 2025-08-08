part of 'calc_bloc.dart';

class CalcState {
  CalcState({required this.data, required this.settlements, this.shareLink});
  factory CalcState.initial() => CalcState(
    data: const AppData(participants: [], expenses: []),
    settlements: const [],
  );
  final AppData data;
  final List<Transfer> settlements;
  final String? shareLink;
  CalcState copyWith({
    AppData? data,
    List<Transfer>? settlements,
    String? shareLink,
  }) => CalcState(
    data: data ?? this.data,
    settlements: settlements ?? this.settlements,
    shareLink: shareLink ?? this.shareLink,
  );
}
