import 'package:login_app/data/irepository.dart';

class UserApiRepository<T> implements IRepository<T> {
  @override
  Future<void> add(Object) => Future.delayed(Duration(seconds: 2), () {});

  @override
  Future<T> get(phone_no) {
    // TODO: implement get
    throw UnimplementedError();
  }
}
