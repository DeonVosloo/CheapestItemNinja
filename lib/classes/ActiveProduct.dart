import 'package:cheapest_item_ninja/classes/Products.dart';

class ActiveProduct extends Product
{
  bool isActive;

  ActiveProduct(super.id, {required super.price,
    required super.pricePerUnitOfMeasurement,
    required super.category, required super.quantity,
    required super.name, required super.units,
    required super.unitOfMeasurement,
    required super.barcode,required this.isActive,
    required super.userID});

}