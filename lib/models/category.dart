class Category {
  final String id;
  final String name;

  Category({required this.id, required this.name});

  factory Category.fromDocumentSnapshot(dynamic doc) {
    return Category(
      id: doc.data()['id'],
      name: doc.data()['name'],
    );
  }
}
