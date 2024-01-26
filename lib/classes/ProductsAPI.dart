class ProductsAPI
{
  String token = "F5EA8111191BF22F6B5ED7C19EE41446";
  String url = "https://api.upcdatabase.org/product/";
  String barcode;


  ProductsAPI({required this.barcode});

  ProductsAPI.fromMap(Map<String, dynamic> result)
      : barcode = result["barcode"];

}
