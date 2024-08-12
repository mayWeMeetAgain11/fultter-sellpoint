import 'bills_to_factory.dart';
import 'bills_to_sell_point.dart';

class AllBillsModel {
  List<BillsToFactory>? billsToFactory;
  List<BillsToSellPoint>? billsToSellPoint;

  AllBillsModel({this.billsToFactory, this.billsToSellPoint});

  factory AllBillsModel.fromJson(Map<String, dynamic> json) => AllBillsModel(
        billsToFactory: (json['bills_to_factory'] as List<dynamic>?)
            ?.map((e) => BillsToFactory.fromJson(e as Map<String, dynamic>))
            .toList(),
        billsToSellPoint: (json['bills_to_sell_point'] as List<dynamic>?)
            ?.map((e) => BillsToSellPoint.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'bills_to_factory': billsToFactory?.map((e) => e.toJson()).toList(),
        'bills_to_sell_point':
            billsToSellPoint?.map((e) => e.toJson()).toList(),
      };
}
