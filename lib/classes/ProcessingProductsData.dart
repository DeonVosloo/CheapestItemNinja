class ProcessingProductsData
{
  int? id;
  String category;
  String name;
  double units;
  String unitOfMeasurement;
  double price;
  double pricePerUnitOfMeasurement;
  String barcode;
  bool success;
  String brand;

  ProcessingProductsData(this.id,this.pricePerUnitOfMeasurement,this.price, this.category,
      this.name, this.units, this.unitOfMeasurement, this.brand, {required this.barcode, required this.success});

  ProcessingProductsData.fromMap(Map<String, dynamic> result)
      : id = result["id"],
        category = result["category"],
        name = result["name"],
        units = result["units"],
        unitOfMeasurement = result["unitOfMeasurement"],
        price = result["price"],
        pricePerUnitOfMeasurement = result["pricePerUnitOfMeasurement"],
        barcode = result["barcode"],
        success = result["success"],
        brand = result["brand"];

}

class APIRawData
{

  String category;
  String title;
  String description;
  String barcode;
  bool success;
  Map<String,Map<String, dynamic>> metadata;
  String brand;

  APIRawData({ required this.category, required this.title, required this.metadata,
    required this.brand, required this.description, required this.barcode, required this.success});

  APIRawData.fromMap(Map<String, dynamic> result)
      : category = result["category"],
        title = result["title"],
        description = result["description"],
        barcode = result["barcode"],
        success = result["success"],
        metadata = result["metadata"],
        brand = result["brand"];

  factory APIRawData.fromJson(Map<String, dynamic> json) {
    return APIRawData(
      category: json["category"] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      barcode: json['barcode'] as String,
      success: json['success'] as bool,
      metadata: json['metadata'] as Map<String,Map<String, dynamic>>,
      brand: json['brand'] as String,
    );
  }
}