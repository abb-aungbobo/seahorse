import 'package:realm/realm.dart';
import 'package:seahorse/models/database/product_entity/product_entity.dart';

part 'cart_entity.realm.dart';

@RealmModel()
class _CartEntity {
  @PrimaryKey()
  int id = 1;
  List<$ProductEntity> products = [];
}
