// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_entity.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

// ignore_for_file: type=lint
class CartEntity extends _CartEntity
    with RealmEntity, RealmObjectBase, RealmObject {
  static var _defaultsSet = false;

  CartEntity(
    int id, {
    Iterable<ProductEntity> products = const [],
  }) {
    if (!_defaultsSet) {
      _defaultsSet = RealmObjectBase.setDefaults<CartEntity>({
        'id': 1,
      });
    }
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set<RealmList<ProductEntity>>(
        this, 'products', RealmList<ProductEntity>(products));
  }

  CartEntity._();

  @override
  int get id => RealmObjectBase.get<int>(this, 'id') as int;
  @override
  set id(int value) => RealmObjectBase.set(this, 'id', value);

  @override
  RealmList<ProductEntity> get products =>
      RealmObjectBase.get<ProductEntity>(this, 'products')
          as RealmList<ProductEntity>;
  @override
  set products(covariant RealmList<ProductEntity> value) =>
      throw RealmUnsupportedSetError();

  @override
  Stream<RealmObjectChanges<CartEntity>> get changes =>
      RealmObjectBase.getChanges<CartEntity>(this);

  @override
  Stream<RealmObjectChanges<CartEntity>> changesFor([List<String>? keyPaths]) =>
      RealmObjectBase.getChangesFor<CartEntity>(this, keyPaths);

  @override
  CartEntity freeze() => RealmObjectBase.freezeObject<CartEntity>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'id': id.toEJson(),
      'products': products.toEJson(),
    };
  }

  static EJsonValue _toEJson(CartEntity value) => value.toEJson();
  static CartEntity _fromEJson(EJsonValue ejson) {
    if (ejson is! Map<String, dynamic>) return raiseInvalidEJson(ejson);
    return switch (ejson) {
      {
        'id': EJsonValue id,
      } =>
        CartEntity(
          fromEJson(ejson['id'], defaultValue: 1),
          products: fromEJson(ejson['products'], defaultValue: const []),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(CartEntity._);
    register(_toEJson, _fromEJson);
    return const SchemaObject(
        ObjectType.realmObject, CartEntity, 'CartEntity', [
      SchemaProperty('id', RealmPropertyType.int, primaryKey: true),
      SchemaProperty('products', RealmPropertyType.object,
          linkTarget: 'ProductEntity',
          collectionType: RealmCollectionType.list),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}
