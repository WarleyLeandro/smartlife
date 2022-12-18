// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_schema.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

class UserRealm extends _UserRealm
    with RealmEntity, RealmObjectBase, RealmObject {
  static var _defaultsSet = false;

  UserRealm(
    int id,
    String name,
    String age,
    String weight,
    String height, {
    String? calories = '0',
  }) {
    if (!_defaultsSet) {
      _defaultsSet = RealmObjectBase.setDefaults<UserRealm>({
        'calories': '0',
      });
    }
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'name', name);
    RealmObjectBase.set(this, 'age', age);
    RealmObjectBase.set(this, 'calories', calories);
    RealmObjectBase.set(this, 'weight', weight);
    RealmObjectBase.set(this, 'height', height);
  }

  UserRealm._();

  @override
  int get id => RealmObjectBase.get<int>(this, 'id') as int;
  @override
  set id(int value) => RealmObjectBase.set(this, 'id', value);

  @override
  String get name => RealmObjectBase.get<String>(this, 'name') as String;
  @override
  set name(String value) => RealmObjectBase.set(this, 'name', value);

  @override
  String get age => RealmObjectBase.get<String>(this, 'age') as String;
  @override
  set age(String value) => RealmObjectBase.set(this, 'age', value);

  @override
  String? get calories =>
      RealmObjectBase.get<String>(this, 'calories') as String?;
  @override
  set calories(String? value) => RealmObjectBase.set(this, 'calories', value);

  @override
  String get weight => RealmObjectBase.get<String>(this, 'weight') as String;
  @override
  set weight(String value) => RealmObjectBase.set(this, 'weight', value);

  @override
  String get height => RealmObjectBase.get<String>(this, 'height') as String;
  @override
  set height(String value) => RealmObjectBase.set(this, 'height', value);

  @override
  Stream<RealmObjectChanges<UserRealm>> get changes =>
      RealmObjectBase.getChanges<UserRealm>(this);

  @override
  UserRealm freeze() => RealmObjectBase.freezeObject<UserRealm>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(UserRealm._);
    return const SchemaObject(ObjectType.realmObject, UserRealm, 'UserRealm', [
      SchemaProperty('id', RealmPropertyType.int, primaryKey: true),
      SchemaProperty('name', RealmPropertyType.string),
      SchemaProperty('age', RealmPropertyType.string),
      SchemaProperty('calories', RealmPropertyType.string, optional: true),
      SchemaProperty('weight', RealmPropertyType.string),
      SchemaProperty('height', RealmPropertyType.string),
    ]);
  }
}
