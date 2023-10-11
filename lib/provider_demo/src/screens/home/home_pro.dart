import 'package:bloc_demo/provider_demo/src/screens/home/product_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      title: 'Material App',
      home: ProductList(),
      debugShowCheckedModeBanner: false,
    );
  }
}
