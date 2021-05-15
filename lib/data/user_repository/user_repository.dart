import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login_app/data/irepository.dart';
import 'package:login_app/model/cache_user.dart';

class UserRepository implements IRepository<CacheUser> {
  final IRepository<CacheUser> source;
  final IRepository<CacheUser> cache;
  final bool Function() hasConnection;

  UserRepository(
      {@required this.source,
      @required this.cache,
      @required this.hasConnection});

  @override
  Future<CacheUser> get(dynamic phone_no) async {
    final cacheUser = await this.get(phone_no);

    if (cacheUser != null) {
      return cacheUser;
    }

    if (!this.hasConnection()) {
      throw NoConnectionException();
    }

    final remoteUser = await this.source.get(phone_no);

    this.cache.add(remoteUser);

    return remoteUser;
  }

  @override
  Future<void> add(CacheUser object) async {
    if (!this.hasConnection()) {
      throw NoConnectionException();
    }

    await this.source.add(object);
    await this.cache.add(object);
  }
}

class NoConnectionException implements Exception {}
