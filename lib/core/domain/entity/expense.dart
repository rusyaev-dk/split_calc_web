import 'package:equatable/equatable.dart';

class Expense extends Equatable {
  factory Expense.fromJson(Map<String, dynamic> j) => Expense(
    id: j['id'] as String,
    title: j['title'] as String? ?? '',
    payerId: j['payerId'] as String,
    amount: (j['amount'] as num).toDouble(),
  );

  const Expense({
    required this.id,
    required this.title,
    required this.payerId,
    required this.amount,
  });
  final String id;
  final String title;
  final String payerId;
  final double amount;

  Expense copyWith({
    String? id,
    String? title,
    String? payerId,
    double? amount,
  }) => Expense(
    id: id ?? this.id,
    title: title ?? this.title,
    payerId: payerId ?? this.payerId,
    amount: amount ?? this.amount,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "payerId": payerId,
    "amount": amount,
  };

  @override
  List<Object?> get props => [id, title, payerId, amount];
}
