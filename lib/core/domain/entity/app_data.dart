import 'dart:convert';

import 'package:flutter_app_template/core/domain/entity/entity.dart';

class AppData {
  const AppData({required this.participants, required this.expenses});

  factory AppData.fromJson(Map<String, dynamic> j) => AppData(
    participants: (j['participants'] as List<dynamic>? ?? [])
        .map((e) => Participant.fromJson(e as Map<String, dynamic>))
        .toList(),
    expenses: (j['expenses'] as List<dynamic>? ?? [])
        .map((e) => Expense.fromJson(e as Map<String, dynamic>))
        .toList(),
  );

  final List<Participant> participants;
  final List<Expense> expenses;

  AppData copyWith({
    List<Participant>? participants,
    List<Expense>? expenses,
  }) => AppData(
    participants: participants ?? this.participants,
    expenses: expenses ?? this.expenses,
  );

  Map<String, dynamic> toJson() => {
    "participants": participants.map((e) => e.toJson()).toList(),
    "expenses": expenses.map((e) => e.toJson()).toList(),
  };

  static String encodeToUrlSafe(AppData data) =>
      base64UrlEncode(utf8.encode(jsonEncode(data.toJson())));
  static AppData decodeFromUrlSafe(String encoded) => AppData.fromJson(
    jsonDecode(utf8.decode(base64Url.decode(encoded))) as Map<String, dynamic>,
  );
}
