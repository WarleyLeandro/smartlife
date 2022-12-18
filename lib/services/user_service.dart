import 'package:flutter/foundation.dart';
import 'package:realm/realm.dart';

import '../schemas/user_schema.dart';

final _config = Configuration.local([UserRealm.schema]);
final realm = Realm(_config);

class UserRealmService {
  late Realm _realm;

  UserRealmService() {
    openRealm();

    try {
      _realm.write(() {
        _realm.add<UserRealm>(UserRealm(1, '', '1', calories: '1', '1', '1'));
      });
    } on RealmException catch (e) {
      debugPrint(e.message);
    }
  }
  openRealm() {
    _realm = Realm(_config);
  }

  closeRealm() {
    if (!_realm.isClosed) {
      _realm.close();
    }
  }

  RealmResults<UserRealm> getItems() {
    return _realm.all<UserRealm>().query('id == 1');
  }

  bool updateUser(UserRealm user, int id, String name, String age,
      String? calories, String weight, String height) {
    try {
      _realm.write(() {
        if (user.id == 1) {
          user.name = name;
          user.age = age;
          user.calories = calories;
          user.weight = weight;
          user.height = height;
        } else {
          print('erro ao editar user');
        }
      });
      return true;
    } on RealmException catch (e) {
      debugPrint(e.message);
      return false;
    } finally {
      closeRealm();
    }
  }

  bool deleteUser(RealmResults<UserRealm> user) {
    realm.write(() {
      realm.deleteMany(user);
    });
    return true;
  }
}
