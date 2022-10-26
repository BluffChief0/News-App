import 'package:equatable/equatable.dart';

class Source extends Equatable {
  final String? id;
  final String? name;

  const Source({required this.id, required this.name});

  factory Source.fromJSON(Map<String, dynamic> json) {
    return Source(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJSON() => {
        'id': id,
        'name': name,
      };

  @override
  List<Object?> get props => [id, name];
}
