import 'package:safe_guinee/models/probleme.dart';

class Signale {
  final Probleme type;
  final String? description;
  final String imageUrl;
  final DateTime date;
  bool isResolved;

  Signale({
    required this.type,
    this.description,
    required this.imageUrl,
    required this.date,
    this.isResolved = false,
  });

  factory Signale.fromJson(Map<String, dynamic> json) {
    return Signale(
      type: json['type'] ?? '',
      description: json['description'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      date: json['date'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'description': description,
      'imageUrl': imageUrl,
      'date': date,
    };
  }
}



