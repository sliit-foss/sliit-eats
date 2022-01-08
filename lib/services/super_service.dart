abstract class SuperService<T, ID, LIST_TYPE> {
  Future<T>? create(T t);

  Future<dynamic>? update(T t);

  Future<dynamic>? delete(ID id);

  Future<T>? getByID(ID id);

  Stream<LIST_TYPE>? getAll({required int offset, required int limit});
}