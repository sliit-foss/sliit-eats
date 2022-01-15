class Canteen {
  final String id;
  final String name;

  Canteen({required this.id, required this.name});

  factory Canteen.fromDocumentSnapshot(dynamic doc) {
    return Canteen(
      id: doc.data()['id'],
      name: doc.data()['name'],
    );
  }
}
