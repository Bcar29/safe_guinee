class Probleme {
  // String id;
  String title;

  Probleme({required this.title});

  @override
  String toString() {
    return title;
  }

  factory Probleme.fromJson(Map<String, dynamic> json) {
    return Probleme(
      // id: json['id'] as String,
      title: json['title'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {'title': title};
  }

  Probleme copyWith({String? title}) {
    return Probleme(title: title ?? this.title);
  }
}
