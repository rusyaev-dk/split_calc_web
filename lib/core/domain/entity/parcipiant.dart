import 'package:equatable/equatable.dart';

class Participant extends Equatable {
  const Participant({required this.id, required this.name});
  factory Participant.fromJson(Map<String, dynamic> j) =>
      Participant(id: j['id'] as String, name: j['name'] as String);
  final String id;
  final String name;

  Participant copyWith({String? id, String? name}) =>
      Participant(id: id ?? this.id, name: name ?? this.name);

  Map<String, dynamic> toJson() => {"id": id, "name": name};

  @override
  List<Object?> get props => [id, name];
}
