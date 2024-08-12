class FromSellPoint {
  int? id;
  String? name;
  String? user;
  String? password;
  bool? updated;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic driverId;
  // dynamic managerId;
  dynamic promoterId;
  int? schoolId;
  dynamic managerId;

  FromSellPoint({
    this.id,
    this.name,
    this.user,
    this.password,
    this.updated,
    this.createdAt,
    this.updatedAt,
    this.driverId,
    // this.managerId,
    this.promoterId,
    this.schoolId,
    this.managerId,
  });

  factory FromSellPoint.fromJson(Map<String, dynamic> json) => FromSellPoint(
        id: json['id'] as int?,
        name: json['name'] as String?,
        user: json['user'] as String?,
        password: json['password'] as String?,
        updated: json['updated'] as bool?,
        createdAt: json['createdAt'] == null
            ? null
            : DateTime.parse(json['createdAt'] as String),
        updatedAt: json['updatedAt'] == null
            ? null
            : DateTime.parse(json['updatedAt'] as String),
        driverId: json['driver_id'] as dynamic,
        // managerId: json['Manager_id'] as dynamic,
        promoterId: json['promoter_id'] as dynamic,
        schoolId: json['school_id'] as int?,
        managerId: json['manager_id'] as dynamic,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'user': user,
        'password': password,
        'updated': updated,
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
        'driver_id': driverId,
        // 'Manager_id': managerId,
        'promoter_id': promoterId,
        'school_id': schoolId,
        'manager_id': managerId,
      };
}
