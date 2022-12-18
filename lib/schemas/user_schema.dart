import 'package:realm/realm.dart';

part 'user_schema.g.dart';

@RealmModel()
class _UserRealm {
  @PrimaryKey()
  late int id;

  late String name;
  late String age;
  late String? calories = '0';
  late String weight;
  late String height;
}
