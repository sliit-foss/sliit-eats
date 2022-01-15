class Category {
  final String id;
  final String name;
  final String canteenId;

  Category({required this.id, required this.name, required this.canteenId});

  factory Category.fromDocumentSnapshot(dynamic doc) {
    return Category(
      id: doc.data()['id'],
      name: doc.data()['name'],
      canteenId: doc.data()['canteen_id'],
    );
  }
}
