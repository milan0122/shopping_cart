import 'package:json_annotation/json_annotation.dart';

//part 'cart_model.g.dart';

@JsonSerializable()
class Cart {
  late final int? id;
  final String? productId;
  final String? productName;
  final int? initialPrice;
  //@JsonKey(name: 'product_price')
  final int? productPrice;
  final int? quantity;
  final String? unit;
  final String? image;
  Cart({
    required this.id,
    required this.productId,
    required this.productName,
    required this.initialPrice,
    required this.productPrice,
    required this.quantity,
    required this.unit,
    required this.image,
  });
  // factory Cart.fromJson(Map<String, dynamic> json) => _$CartFromJson(json);
  // Map<String, dynamic> toJson() => _$CartToJson(this);
  Cart.fromMap(Map<dynamic,dynamic>res):
    id=res['id'],
  productId  =res['productId'],
  productName = res['productName'],
  initialPrice = res['initialPrice'],
  productPrice = res['productPrice'],
  quantity = res['quantity'],
  unit = res['unit'],
  image = res['image'];
  Map<String, dynamic> toMap(){
  return{
  'id': id,
  'productId': productId,
  'productName': productName,
  'initialPrice': initialPrice,
  'productPrice':productPrice,
  'quantity': quantity,
  'unit':unit,
  'image': image,
  };
  }
}




