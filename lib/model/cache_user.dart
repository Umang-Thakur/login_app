import 'package:hive/hive.dart';

part 'cache_user.g.dart';

@HiveType(typeId: 0)
class CacheUser extends HiveObject {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String phone_no;

  @HiveField(2)
  final String token;

  @HiveField(3)
  final String referral_code;

  CacheUser(this.name, this.phone_no, this.token, this.referral_code);
}
