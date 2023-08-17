// ignore_for_file: public_member_api_docs, sort_constructors_first
class Task {
  final int id;
  final String description;
  final bool check;

  Task({
    required this.id,
    required this.description,
    required this.check,
  });

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
