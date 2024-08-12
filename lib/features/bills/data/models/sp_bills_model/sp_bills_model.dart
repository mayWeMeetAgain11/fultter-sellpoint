import 'category.dart';

class SpBillsModel {
  int? id;
  int? amount;
  var unitPrice;
  var totalPrice;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? categoryId;
  int? sellPointBillId;
  Category? category;

  SpBillsModel({
    this.id,
    this.amount,
    this.unitPrice,
    this.totalPrice,
    this.createdAt,
    this.updatedAt,
    this.categoryId,
    this.sellPointBillId,
    this.category,
  });

  factory SpBillsModel.fromJson(Map<String, dynamic> json) => SpBillsModel(
        id: json['id'] as int?,
        amount: json['amount'] as int?,
        unitPrice: json['unit_price'],
        totalPrice: json['total_price'],
        createdAt: json['createdAt'] == null
            ? null
            : DateTime.parse(json['createdAt'] as String),
        updatedAt: json['updatedAt'] == null
            ? null
            : DateTime.parse(json['updatedAt'] as String),
        categoryId: json['category_id'] as int?,
        sellPointBillId: json['sell_point_bill_id'] as int?,
        category: json['category'] == null
            ? null
            : Category.fromJson(json['category'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'amount': amount,
        'unit_price': unitPrice,
        'total_price': totalPrice,
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
        'category_id': categoryId,
        'sell_point_bill_id': sellPointBillId,
        'category': category?.toJson(),
      };
}
