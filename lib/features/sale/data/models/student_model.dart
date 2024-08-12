class StudentModel {
  int? id;
  String? firstName;
  String? midName;
  String? lastName;
  String? email;
  String? phone;
  var balance;
  var threshold;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? schoolId;

  StudentModel({
    this.id,
    this.firstName,
    this.midName,
    this.lastName,
    this.email,
    this.phone,
    this.balance,
    this.threshold,
    this.createdAt,
    this.updatedAt,
    this.schoolId,
  });

  factory StudentModel.fromJson(Map<String, dynamic> json) => StudentModel(
        id: json['id'] as int?,
        firstName: json['first_name'] as String?,
        midName: json['mid_name'] as String?,
        lastName: json['last_name'] as String?,
        email: json['email'] as String?,
        phone: json['phone'] as String?,
        balance: json['balance'],
        threshold: json['threshold'],
        createdAt: json['createdAt'] == null
            ? null
            : DateTime.parse(json['createdAt'] as String),
        updatedAt: json['updatedAt'] == null
            ? null
            : DateTime.parse(json['updatedAt'] as String),
        schoolId: json['school_id'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'first_name': firstName,
        'mid_name': midName,
        'last_name': lastName,
        'email': email,
        'phone': phone,
        'balance': balance,
        'threshold': threshold,
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
        'school_id': schoolId,
      };
}
