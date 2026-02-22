class CategoryModel {
  final String id;
  final String name;
  final String? description;
  final String? imageUrl;
  final DateTime? createdAt;

  CategoryModel({
    required this.id,
    required this.name,
    this.description,
    this.imageUrl,
    this.createdAt,
  });

  // Helper constructor for demo/mock data compatibility
  CategoryModel.fromMock({
    required String title,
    String? image,
  }) : this(
    id: '',
    name: title,
    description: null,
    imageUrl: image,
    createdAt: null,
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
}

final List<CategoryModel> demoCategoriesWithImage = [
  CategoryModel(title: "Woman’s", image: "https://i.imgur.com/5M89G2P.png"),
  CategoryModel(title: "Man’s", image: "https://i.imgur.com/UM3GdWg.png"),
  CategoryModel(title: "Kid’s", image: "https://i.imgur.com/Lp0D6k5.png"),
  CategoryModel(title: "Accessories", image: "https://i.imgur.com/3mSE5sN.png"),
];

final List<CategoryModel> demoCategories = [
  CategoryModel(
    title: "On sale",
    svgSrc: "assets/icons/Sale.svg",
    subCategories: [
      CategoryModel(title: "All Clothing"),
      CategoryModel(title: "New In"),
      CategoryModel(title: "Coats & Jackets"),
      CategoryModel(title: "Dresses"),
      CategoryModel(title: "Jeans"),
    ],
  ),
  CategoryModel(
    title: "Man’s & Woman’s",
    svgSrc: "assets/icons/Man&Woman.svg",
    subCategories: [
      CategoryModel(title: "All Clothing"),
      CategoryModel(title: "New In"),
      CategoryModel(title: "Coats & Jackets"),
    ],
  ),
  CategoryModel(
    title: "Kids",
    svgSrc: "assets/icons/Child.svg",
    subCategories: [
      CategoryModel(title: "All Clothing"),
      CategoryModel(title: "New In"),
      CategoryModel(title: "Coats & Jackets"),
    ],
  ),
  CategoryModel(
    title: "Accessories",
    svgSrc: "assets/icons/Accessories.svg",
    subCategories: [
      CategoryModel(title: "All Clothing"),
      CategoryModel(title: "New In"),
    ],
  ),
];
