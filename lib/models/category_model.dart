class CategoryModel {
  final String id;
  final String name;
  final String? description;
  final String? imageUrl;
  final DateTime? createdAt;
  final String? svgSrc;
  final List<CategoryModel>? subCategories;

  CategoryModel({
    required this.id,
    required this.name,
    this.description,
    this.imageUrl,
    this.createdAt,
    this.svgSrc,
    this.subCategories,
  });

  // Helper constructor for demo/mock data compatibility
  CategoryModel.fromMock({
    required String title,
    String? image,
    String? svgSrc,
    List<CategoryModel>? subCategories,
  }) : this(
    id: '',
    name: title,
    description: null,
    imageUrl: image,
    createdAt: null,
    svgSrc: svgSrc,
    subCategories: subCategories,
  );

  // Factory constructor to create CategoryModel from JSON (Supabase)
  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? 'Unknown Category',
      description: json['description'] as String?,
      imageUrl: json['image_url'] as String?,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : null,
    );
  }

  // Convert CategoryModel to JSON for Supabase
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'image_url': imageUrl,
      'created_at': createdAt?.toIso8601String(),
    };
  }

  // Backward compatibility getter
  String get title => name;
}

final List<CategoryModel> demoCategoriesWithImage = [
  CategoryModel.fromMock(title: "Woman's", image: "https://i.imgur.com/5M89G2P.png"),
  CategoryModel.fromMock(title: "Man's", image: "https://i.imgur.com/UM3GdWg.png"),
  CategoryModel.fromMock(title: "Kid's", image: "https://i.imgur.com/Lp0D6k5.png"),
  CategoryModel.fromMock(title: "Accessories", image: "https://i.imgur.com/3mSE5sN.png"),
];

final List<CategoryModel> demoCategories = [
  CategoryModel.fromMock(
    title: "On sale",
    svgSrc: "assets/icons/Sale.svg",
    subCategories: [
      CategoryModel.fromMock(title: "All Clothing"),
      CategoryModel.fromMock(title: "New In"),
      CategoryModel.fromMock(title: "Coats & Jackets"),
      CategoryModel.fromMock(title: "Dresses"),
      CategoryModel.fromMock(title: "Jeans"),
    ],
  ),
  CategoryModel.fromMock(
    title: "Man's & Woman's",
    svgSrc: "assets/icons/Man&Woman.svg",
    subCategories: [
      CategoryModel.fromMock(title: "All Clothing"),
      CategoryModel.fromMock(title: "New In"),
      CategoryModel.fromMock(title: "Coats & Jackets"),
    ],
  ),
  CategoryModel.fromMock(
    title: "Kids",
    svgSrc: "assets/icons/Child.svg",
    subCategories: [
      CategoryModel.fromMock(title: "All Clothing"),
      CategoryModel.fromMock(title: "New In"),
      CategoryModel.fromMock(title: "Coats & Jackets"),
    ],
  ),
  CategoryModel.fromMock(
    title: "Accessories",
    svgSrc: "assets/icons/Accessories.svg",
    subCategories: [
      CategoryModel.fromMock(title: "All Clothing"),
      CategoryModel.fromMock(title: "New In"),
    ],
  ),
];
