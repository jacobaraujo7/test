// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class Task extends Equatable {
  final int id;
  final String description;
  final bool check;

  const Task({
    required this.id,
    required this.description,
    this.check = false,
  });

  @override
  List<Object?> get props => [id, description, check];

  Task copyWith({
    int? id,
    String? description,
    bool? check,
  }) {
    return Task(
      id: id ?? this.id,
      description: description ?? this.description,
      check: check ?? this.check,
    );
  }
}
