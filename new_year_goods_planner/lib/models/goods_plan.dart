import 'assessment.dart';

class GoodsPlan {
  final String id;
  final String name;
  final String category;
  final bool isCustom;
  final DateTime? targetDate;
  final bool isCompleted;
  final Assessment assessment;
  final DateTime createdAt;

  GoodsPlan({
    required this.id,
    required this.name,
    required this.category,
    required this.isCustom,
    this.targetDate,
    this.isCompleted = false,
    required this.assessment,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'isCustom': isCustom,
      'targetDate': targetDate?.toIso8601String(),
      'isCompleted': isCompleted,
      'assessment': assessment.toJson(),
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory GoodsPlan.fromJson(Map<String, dynamic> json) {
    return GoodsPlan(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      category: json['category'] ?? '',
      isCustom: json['isCustom'] ?? false,
      targetDate: json['targetDate'] != null
          ? DateTime.parse(json['targetDate'])
          : null,
      isCompleted: json['isCompleted'] ?? false,
      assessment: json['assessment'] != null
          ? Assessment.fromJson(json['assessment'])
          : Assessment(
              manpower: '',
              manpowerDetail: '',
              physical: '',
              physicalDetail: '',
              financial: '',
              financialDetail: '',
              detailDescription: '',
            ),
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : DateTime.now(),
    );
  }

  GoodsPlan copyWith({
    String? id,
    String? name,
    String? category,
    bool? isCustom,
    DateTime? targetDate,
    bool? isCompleted,
    Assessment? assessment,
    DateTime? createdAt,
  }) {
    return GoodsPlan(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      isCustom: isCustom ?? this.isCustom,
      targetDate: targetDate ?? this.targetDate,
      isCompleted: isCompleted ?? this.isCompleted,
      assessment: assessment ?? this.assessment,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}