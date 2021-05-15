import 'package:login_app/data/irepository.dart';
import 'package:hive/hive.dart';

class HiveRepository<T> implements IRepository<T> {
  final Box _box;

  HiveRepository(this._box);

  @override
  Future<T> get(dynamic phone_no) async {
    if (this.boxIsClosed) {
      return null;
    }

    return this._box.get(phone_no);
  }

  @override
  Future<void> add(T object) async {
    if (this.boxIsClosed) {
      return;
    }

    await this._box.add(object);
  }

  bool get boxIsClosed => !(this._box?.isOpen ?? false);
}
