class Product
{
  int? id;
  String category;
  String name;
  double units;
  String unitOfMeasurement;
  double price;
  double pricePerUnitOfMeasurement;
  String barcode;


  Product(this.id,this.price, this.pricePerUnitOfMeasurement, {required this.category, required this.name,
    required this.units, required this.unitOfMeasurement, required this.barcode});

  Product.fromMap(Map<String, dynamic> result)
      : id = result["id"],
        category = result["category"],
        name = result["name"],
        units = result["units"],
        unitOfMeasurement = result["unitOfMeasurement"],
        price = result["price"],
        pricePerUnitOfMeasurement = result["pricePerUnitOfMeasurement"],
        barcode = result["barcode"];

  Map<String, Object> toMap() {
    return
      {
        'category': category,
        'email': name,
        'units': units,
        'unitOfMeasurement': unitOfMeasurement,
        'price': price,
        'pricePerUnitOfMeasurement': pricePerUnitOfMeasurement,
        'barcode': barcode,
      };
  }

}