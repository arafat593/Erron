class KycModel {
  final String idFront;
  final String idBack;
  final String status;
  final String? rejectionReason;
  final DateTime createdAt;
  final DateTime updatedAt;

  KycModel({
    required this.idFront,
    required this.idBack,
    required this.status,
    this.rejectionReason,
    required this.createdAt,
    required this.updatedAt,
  });

  factory KycModel.fromJson(Map<String, dynamic> json) {
    return KycModel(
      idFront: json['id_front'],
      idBack: json['id_back'],
      status: json['status'],
      rejectionReason: json['rejection_reason'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_front': idFront,
      'id_back': idBack,
      'status': status,
      'rejection_reason': rejectionReason,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}