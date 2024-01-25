class Products
{
  String token = "F5EA8111191BF22F6B5ED7C19EE41446";
  String url = "https://api.upcdatabase.org/product/";
  String barcode;


  Products(this.token, this.url, {required this.barcode});

  Products.fromMap(Map<String, dynamic> result)
      : barcode = result["barcode"];

  Map<String, Object> toMap() {
    return
      {
        'token': token,
        'url': url,
        'barcode': barcode,
      };
  }

}