import 'package:bloc_demo/provider_demo/src/screens/home/home_pro.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'screens/home/providers/home_provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<HomeProvider>(create: (_) => HomeProvider())
    ],
    child: const MyApp(),
  ));
}
