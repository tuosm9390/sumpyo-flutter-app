class WellnessMission {
  final String id;
  final String title;
  final String description;
  final String category;
  final bool isCompleted;
  final DateTime date;

  const WellnessMission({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    this.isCompleted = false,
    required this.date,
  });

  WellnessMission copyWith({
    String? id,
    String? title,
    String? description,
    String? category,
    bool? isCompleted,
    DateTime? date,
  }) {
    return WellnessMission(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      category: category ?? this.category,
      isCompleted: isCompleted ?? this.isCompleted,
      date: date ?? this.date,
    );
  }

  factory WellnessMission.fromJson(Map<String, dynamic> json) {
    return WellnessMission(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      category: json['category'] as String,
      isCompleted: json['isCompleted'] as bool,
      date: DateTime.parse(json['date'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'category': category,
      'isCompleted': isCompleted,
      'date': date.toIso8601String(),
    };
  }
}
