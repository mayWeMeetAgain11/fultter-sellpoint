class CategoryModel {
  int? id;
  String? nameAr;
  String? nameEn;
  var price;
  String? type;
  String? schoolType;
  String? source;
  // bool? visibility;
  String? photo;
  // DateTime? createdAt;
  // DateTime? updatedAt;

  CategoryModel({
    this.id,
    this.nameAr,
    this.nameEn,
    this.price,
    this.type,
    this.schoolType,
    this.source,
    // this.visibility,
    this.photo,
    // this.createdAt,
    // this.updatedAt,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        id: json['id'] as int?,
        nameAr: json['name_ar'] as String?,
        nameEn: json['name_en'] as String?,
        price: json['price'],
        type: json['type'] as String?,
        schoolType: json['school_type'] as String?,
        source: json['source'] as String?,
        // visibility: json['visibility'] as bool?,
        photo: json['photo'] as String?,
        // createdAt: json['createdAt'] == null
        //     ? null
        //     : DateTime.parse(json['createdAt'] as String),
        // updatedAt: json['updatedAt'] == null
        //     ? null
        //     : DateTime.parse(json['updatedAt'] as String),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name_ar': nameAr,
        'name_en': nameEn,
        'price': price,
        'type': type,
        'school_type': schoolType,
        'source': source,
        // 'visibility': visibility,
        'photo': photo,
        // 'createdAt': createdAt?.toIso8601String(),
        // 'updatedAt': updatedAt?.toIso8601String(),
      };
}
