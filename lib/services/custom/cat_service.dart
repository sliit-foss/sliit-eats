import 'package:sliit_eats/models/cat.dart';
import 'package:sliit_eats/services/super_service.dart';

class CatService extends SuperService<Cat, String, Stream> {
  @override
  Future<Cat>? create(Cat t) {
    return null;
  }

  @override
  Future? delete(String id) {
    return null;
  }

  @override
  Stream<Stream>? getAll({required int offset, required int limit}) {
    return null;
  }

  @override
  Future<Cat>? getByID(String id) {
    return null;
  }

  @override
  Future? update(Cat t) {
    return null;
  }
}
