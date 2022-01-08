import 'package:flutter_champ_architecture/models/cat.dart';
import 'package:flutter_champ_architecture/services/super_service.dart';

class CatService extends SuperService<Cat, String, Stream> {
  @override
  Future<Cat> create(Cat t) {
    return null;
  }

  @override
  Future delete(String id) {
    return null;
  }

  @override
  Stream<Stream> getAll({int offset, int limit}) {
    return null;
  }

  @override
  Future<Cat> getByID(String id) {
    return null;
  }

  @override
  Future update(Cat t) {
    return null;
  }
}
