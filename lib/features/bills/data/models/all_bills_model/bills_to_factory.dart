class BillsToFactory {
  int? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? sellPointId;

  BillsToFactory({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.sellPointId,
  });

  factory BillsToFactory.fromJson(Map<String, dynamic> json) {
    return BillsToFactory(
      id: json['id'] as int?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      sellPointId: json['sell_point_id'] as int?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
        'sell_point_id': sellPointId,
      };
}
