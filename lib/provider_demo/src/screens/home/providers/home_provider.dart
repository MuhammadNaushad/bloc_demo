import 'dart:convert';

import 'package:bloc_demo/provider_demo/src/widgets/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../model/product.dart';

class HomeProvider extends ChangeNotifier {
  List<Product> productList = [];
  List<String> catList = [];

  //Add To Cart
  int cartCount = 0;

  //Dropdown
  List<String> dropDItems = ["--Select Category--"];
  String dropDvalue = "--Select Category--";

  Future<void> init() async {
    dropDItems = ["--Select Category--"];
    dropDvalue = "--Select Category--";
    cartCount = 0;
    await Future.wait([getProductList(), getAllCategoriesList()]);
  }

  final String baseUrl = 'https://fakestoreapi.com';

  Future<List<Product>> getProductList({bool sort = false, String? cat}) async {
    try {
      CommonWidgets.showDialog();

      final String uri = sort ? "products/category/$cat" : "products";
      final response = await http.get(Uri.parse('$baseUrl/$uri'), headers: {
        "Accept": "application/json",
        "content-type": "application/json",
      });
      CommonWidgets.hideDialog();
      if (response.statusCode == 200) {
        productList.clear();
        List<dynamic> data = jsonDecode(response.body);
        List<Product> productListData = data
            .map((json) => Product(
                id: json['id'],
                title: json['title'],
                price: json['price'].toDouble(),
                description: json['description'],
                category: json['category'],
                image: json['image'],
                addToCart: false))
            .toList();
        productList = productListData;
        debugPrint(productList.toString());
        notifyListeners();
        return productList;
      } else {
        CommonWidgets.hideDialog();
        throw Exception('Failed to load products');
      }
    } catch (e) {
      CommonWidgets.hideDialog();
      throw Exception(e);
    }
  }

  Future<void> getAllCategoriesList({bool sort = false}) async {
    //CommonWidgets.showDialog();

    const String uri = "products/categories";
    final response = await http.get(Uri.parse('$baseUrl/$uri'), headers: {
      "Accept": "application/json",
      "content-type": "application/json",
    });
    // CommonWidgets.hideDialog();
    if (response.statusCode == 200) {
      productList.clear();
      List<dynamic> data = jsonDecode(response.body);
      List<dynamic> catList = data;
      catList.map((e) => dropDItems.add(e.toString())).toList();
      debugPrint(catList.toString());
      notifyListeners();
    } else {
      // CommonWidgets.hideDialog();
      throw Exception('Failed to load products');
    }
  }

  void addToCart(int index, {isAdded = false}) {
    if (isAdded == false) {
      productList[index].addToCart = true;
      cartCount++;
    } else {
      productList[index].addToCart = false;
      cartCount--;
    }

    notifyListeners();
  }

  void taps({isAdded = false}) {
    notifyListeners();
  }

  Future<void> setSelectedItem(String cat) async {
    getProductList(sort: true, cat: cat);
    notifyListeners();
  }
}
