import 'package:realm/realm.dart';
import 'package:seahorse/models/database/cart_entity/cart_entity.dart';
import 'package:seahorse/models/database/product_entity/product_entity.dart';

final config = Configuration.local(
  [
    CartEntity.schema,
    ProductEntity.schema,
  ],
  schemaVersion: 1,
);
