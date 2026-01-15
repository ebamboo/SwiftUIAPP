class Assessment {
  final String manpower;
  final String manpowerDetail;
  final String physical;
  final String physicalDetail;
  final String financial;
  final String financialDetail;
  final String detailDescription;

  Assessment({
    required this.manpower,
    required this.manpowerDetail,
    required this.physical,
    required this.physicalDetail,
    required this.financial,
    required this.financialDetail,
    required this.detailDescription,
  });

  Map<String, dynamic> toJson() {
    return {
      'manpower': manpower,
      'manpowerDetail': manpowerDetail,
      'physical': physical,
      'physicalDetail': physicalDetail,
      'financial': financial,
      'financialDetail': financialDetail,
      'detailDescription': detailDescription,
    };
  }

  factory Assessment.fromJson(Map<String, dynamic> json) {
    return Assessment(
      manpower: json['manpower'] ?? '',
      manpowerDetail: json['manpowerDetail'] ?? '',
      physical: json['physical'] ?? '',
      physicalDetail: json['physicalDetail'] ?? '',
      financial: json['financial'] ?? '',
      financialDetail: json['financialDetail'] ?? '',
      detailDescription: json['detailDescription'] ?? '',
    );
  }

  Assessment copyWith({
    String? manpower,
    String? manpowerDetail,
    String? physical,
    String? physicalDetail,
    String? financial,
    String? financialDetail,
    String? detailDescription,
  }) {
    return Assessment(
      manpower: manpower ?? this.manpower,
      manpowerDetail: manpowerDetail ?? this.manpowerDetail,
      physical: physical ?? this.physical,
      physicalDetail: physicalDetail ?? this.physicalDetail,
      financial: financial ?? this.financial,
      financialDetail: financialDetail ?? this.financialDetail,
      detailDescription: detailDescription ?? this.detailDescription,
    );
  }
}