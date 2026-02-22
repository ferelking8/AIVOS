// Supabase Integration
import 'package:aivo/constants.dart';

class ProductModel {
  final String id;
  final String title;
  final String? description;
  final String? brand;
  final double price;
  final String? currency;
  final int stock;
  final bool active;
  final String? imageUrl;
  final List<String> tags;
  final String? categoryId;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  ProductModel({
    required this.id,
    required this.title,
    this.description,
    this.brand,
    required this.price,
    this.currency = 'USD',
    this.stock = 0,
    this.active = true,
    this.imageUrl,
    this.tags = const [],
    this.categoryId,
    this.createdAt,
    this.updatedAt,
  });

  // Helper constructor for demo/mock data compatibility
  ProductModel.fromMock({
    required String image,
    required String brandName,
    required String title,
    required double price,
    double? priceAfetDiscount,
    int? dicountpercent,
  }) : this(
    id: '',
    title: title,
    brand: brandName,
    price: price,
    imageUrl: image,
    description: null,
    currency: 'USD',
    stock: 0,
    active: true,
    tags: [],
    categoryId: null,
    createdAt: null,
    updatedAt: null,
  );

  // Factory constructor to create ProductModel from JSON (Supabase)
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? 'Unknown Product',
      description: json['description'] as String?,
      brand: json['brand'] as String?,
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      currency: json['currency'] as String? ?? 'USD',
      stock: json['stock'] as int? ?? 0,
      active: json['active'] as bool? ?? true,
      imageUrl: json['image_url'] as String?,
      tags: json['tags'] != null
          ? List<String>.from(json['tags'] as List)
          : [],
      categoryId: json['category_id'] as String?,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'] as String)
          : null,
    );
  }

  // Convert ProductModel to JSON for Supabase
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'brand': brand,
      'price': price,
      'currency': currency,
      'stock': stock,
      'active': active,
      'image_url': imageUrl,
      'tags': tags,
      'category_id': categoryId,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}

List<ProductModel> demoPopularProducts = [
  ProductModel(
    image: productDemoImg1,
    title: "Mountain Warehouse for Women",
    brandName: "Lipsy london",
    price: 540,
    priceAfetDiscount: 420,
    dicountpercent: 20,
  ),
  ProductModel(
    image: productDemoImg4,
    title: "Mountain Beta Warehouse",
    brandName: "Lipsy london",
    price: 800,
  ),
  ProductModel(
    image: productDemoImg5,
    title: "FS - Nike Air Max 270 Really React",
    brandName: "Lipsy london",
    price: 650.62,
    priceAfetDiscount: 390.36,
    dicountpercent: 40,
  ),
  ProductModel(
    image: productDemoImg6,
    title: "Green Poplin Ruched Front",
    brandName: "Lipsy london",
    price: 1264,
    priceAfetDiscount: 1200.8,
    dicountpercent: 5,
  ),
  ProductModel(
    image: "https://i.imgur.com/tXyOMMG.png",
    title: "Green Poplin Ruched Front",
    brandName: "Lipsy london",
    price: 650.62,
    priceAfetDiscount: 390.36,
    dicountpercent: 40,
  ),
  ProductModel(
    image: "https://i.imgur.com/h2LqppX.png",
    title: "white satin corset top",
    brandName: "Lipsy london",
    price: 1264,
    priceAfetDiscount: 1200.8,
    dicountpercent: 5,
  ),
];
List<ProductModel> demoFlashSaleProducts = [
  ProductModel(
    image: productDemoImg5,
    title: "FS - Nike Air Max 270 Really React",
    brandName: "Lipsy london",
    price: 650.62,
    priceAfetDiscount: 390.36,
    dicountpercent: 40,
  ),
  ProductModel(
    image: productDemoImg6,
    title: "Green Poplin Ruched Front",
    brandName: "Lipsy london",
    price: 1264,
    priceAfetDiscount: 1200.8,
    dicountpercent: 5,
  ),
  ProductModel(
    image: productDemoImg4,
    title: "Mountain Beta Warehouse",
    brandName: "Lipsy london",
    price: 800,
    priceAfetDiscount: 680,
    dicountpercent: 15,
  ),
];
List<ProductModel> demoBestSellersProducts = [
  ProductModel(
    image: "https://i.imgur.com/tXyOMMG.png",
    title: "Green Poplin Ruched Front",
    brandName: "Lipsy london",
    price: 650.62,
    priceAfetDiscount: 390.36,
    dicountpercent: 40,
  ),
  ProductModel(
    image: "https://i.imgur.com/h2LqppX.png",
    title: "white satin corset top",
    brandName: "Lipsy london",
    price: 1264,
    priceAfetDiscount: 1200.8,
    dicountpercent: 5,
  ),
  ProductModel(
    image: productDemoImg4,
    title: "Mountain Beta Warehouse",
    brandName: "Lipsy london",
    price: 800,
    priceAfetDiscount: 680,
    dicountpercent: 15,
  ),
];
List<ProductModel> kidsProducts = [
  ProductModel(
    image: "https://i.imgur.com/dbbT6PA.png",
    title: "Green Poplin Ruched Front",
    brandName: "Lipsy london",
    price: 650.62,
    priceAfetDiscount: 590.36,
    dicountpercent: 24,
  ),
  ProductModel(
    image: "https://i.imgur.com/7fSxC7k.png",
    title: "Printed Sleeveless Tiered Swing Dress",
    brandName: "Lipsy london",
    price: 650.62,
  ),
  ProductModel(
    image: "https://i.imgur.com/pXnYE9Q.png",
    title: "Ruffle-Sleeve Ponte-Knit Sheath ",
    brandName: "Lipsy london",
    price: 400,
  ),
  ProductModel(
    image: "https://i.imgur.com/V1MXgfa.png",
    title: "Green Mountain Beta Warehouse",
    brandName: "Lipsy london",
    price: 400,
    priceAfetDiscount: 360,
    dicountpercent: 20,
  ),
  ProductModel(
    image: "https://i.imgur.com/8gvE5Ss.png",
    title: "Printed Sleeveless Tiered Swing Dress",
    brandName: "Lipsy london",
    price: 654,
  ),
  ProductModel(
    image: "https://i.imgur.com/cBvB5YB.png",
    title: "Mountain Beta Warehouse",
    brandName: "Lipsy london",
    price: 250,
  ),
];
