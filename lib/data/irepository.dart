abstract class IRepository<T> {
  Future<T> get(dynamic phone_no);
  Future<void> add(T object);
}
