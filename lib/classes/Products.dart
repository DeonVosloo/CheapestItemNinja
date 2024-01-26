class Product
{
  String? id;
  String category;
  String name;
  double units;
  String unitOfMeasurement;
  int quantity;
  double price;
  double pricePerUnitOfMeasurement;
  String barcode;
  String userID;

  Product(this.id, { required this.price, required  this.pricePerUnitOfMeasurement, required this.category, required this.quantity, required this.name,
    required this.units, required this.unitOfMeasurement, required this.barcode, required this.userID});

}