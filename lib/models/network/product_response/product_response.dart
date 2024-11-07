import 'package:json_annotation/json_annotation.dart';
import 'package:seahorse/models/database/product_entity/product_entity.dart';
import 'package:seahorse/models/network/rating_response/rating_response.dart';
import 'package:seahorse/ui_components/product_card_view/product_card_view_model.dart';
import 'package:seahorse/ui_components/product_detail_card_view/product_detail_card_view_model.dart';
import 'package:seahorse/utilities/currency_formatter/currency_formatter.dart';

part 'product_response.g.dart';

@JsonSerializable()
class ProductResponse {
  final int id;
  final String title;
  final double price;
  final String description;
  final String category;
  final String image;
  final RatingResponse rating;

  const ProductResponse({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    required this.rating,
  });

  factory ProductResponse.fromJson(Map<String, dynamic> json) =>
      _$ProductResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ProductResponseToJson(this);
}

extension ProductResponseToProductCardViewModel on ProductResponse {
  ProductCardViewModel toProductCardViewModel() {
    return ProductCardViewModel(
      image: image,
      title: title,
      price: currencyFormatter.format(price),
      rate: rating.rate.toString(),
    );
  }
}

extension ProductResponseToProductDetailCardViewModel on ProductResponse {
  ProductDetailCardViewModel toProductDetailCardViewModel() {
    return ProductDetailCardViewModel(
      image: image,
      title: title,
      description: description,
      price: currencyFormatter.format(price),
      category: category,
      rate: rating.rate.toString(),
    );
  }
}

extension ProductResponseToProductEntity on ProductResponse {
  ProductEntity toProductEntity(int quantity) {
    return ProductEntity(
      id,
      title,
      price,
      image,
      quantity,
    );
  }
}
