class Data {
  int? id;
  String? name;
  String? user;
  String? password;
  // bool? updated;
  // DateTime? createdAt;
  // DateTime? updatedAt;
  int? driverId;
  int? managerId;
  int? promoterId;
  int? schoolId;

  Data({
    this.id,
    this.name,
    this.user,
    this.password,
    // this.updated,
    // this.createdAt,
    // this.updatedAt,
    this.driverId,
    this.managerId,
    this.promoterId,
    this.schoolId,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json['id'] as int?,
        name: json['name'] as String?,
        user: json['user'] as String?,
        password: json['password'] as String?,
        // updated: json['updated'] as bool?,
        // createdAt: json['createdAt'] == null
        //     ? null
        //     : DateTime.parse(json['createdAt'] as String),
        // updatedAt: json['updatedAt'] == null
        //     ? null
        //     : DateTime.parse(json['updatedAt'] as String),
        driverId: json['driver_id'] as int?,
        managerId: json['Manager_id'] as int?,
        promoterId: json['promoter_id'] as int?,
        schoolId: json['school_id'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'user': user,
        'password': password,
        // 'updated': updated,
        // 'createdAt': createdAt?.toIso8601String(),
        // 'updatedAt': updatedAt?.toIso8601String(),
        'driver_id': driverId,
        'Manager_id': managerId,
        'promoter_id': promoterId,
        'school_id': schoolId,
      };
}
