import 'from_sell_point.dart';

class BillsOrderdFromMe {
  int? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? fromSellPointId;
  int? toSellPointId;
  FromSellPoint? fromSellPoint;

  BillsOrderdFromMe({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.fromSellPointId,
    this.toSellPointId,
    this.fromSellPoint,
  });

  factory BillsOrderdFromMe.fromJson(Map<String, dynamic> json) {
    return BillsOrderdFromMe(
      id: json['id'] as int?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      fromSellPointId: json['from_sell_point_id'] as int?,
      toSellPointId: json['to_sell_point_id'] as int?,
      fromSellPoint: json['from_sell_point'] == null
          ? null
          : FromSellPoint.fromJson(
              json['from_sell_point'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
        'from_sell_point_id': fromSellPointId,
        'to_sell_point_id': toSellPointId,
        'from_sell_point': fromSellPoint?.toJson(),
      };
}
