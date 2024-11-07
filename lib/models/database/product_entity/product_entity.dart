import 'package:realm/realm.dart';
import 'package:seahorse/ui_components/cart_card_view/cart_card_view_model.dart';
import 'package:seahorse/utilities/currency_formatter/currency_formatter.dart';

part 'product_entity.realm.dart';

@RealmModel()
class $ProductEntity {
  @PrimaryKey()
  late int id;
  late String title;
  late double price;
  late String image;
  late int quantity;

  double get totalPrice => price * quantity;
}

extension ProductEntityToCartCardViewModel on $ProductEntity {
  CartCardViewModel toCartCardViewModel() {
    final formattedPrice = currencyFormatter.format(price);
    final formattedTotalPrice = currencyFormatter.format(totalPrice);
    return CartCardViewModel(
      image: image,
      title: title,
      price: "$formattedPrice (total: $formattedTotalPrice)",
      quantity: quantity,
    );
  }
}
