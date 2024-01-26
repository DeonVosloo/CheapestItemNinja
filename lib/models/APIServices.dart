import 'dart:convert';

import 'package:cheapest_item_ninja/classes/Products.dart';
import 'package:cheapest_item_ninja/classes/ProductsAPI.dart';
import 'package:http/http.dart' as http;

import '../classes/ProcessingProductsData.dart';

class APIServices
{

Product getProductData(String barcode)
{
    return Product(0, 0, 0, category: "category", name: "name", units: 0, unitOfMeasurement: "", barcode: barcode);
}

Future<APIRawData> getAPIData (String barcode)
async {
  ProductsAPI productsAPI =  ProductsAPI(barcode: barcode);

  var settings = {
    "url": "${productsAPI.url}${productsAPI.barcode}",
    "method": "GET",
    "timeout": 0,
    "headers": {
      "Authorization": "Bearer ${productsAPI.token}"
    },
  };

  try
  {
    var url = Uri.parse(productsAPI.url + productsAPI.barcode);
    Map<String, String> header = {"Authorization":"Bearer ${productsAPI.token}"};
    var response = await http.get(url, headers: header);
    if (response.statusCode == 200) {
      APIRawData rawData = apiRawDataFromJson(response.body);
      return rawData;
    }
    else if(response.statusCode == 400 || response.statusCode == 403 || response.statusCode == 404)
      {

      }
  }
  catch (exception)
  {
    //catch exception
  }
}

}