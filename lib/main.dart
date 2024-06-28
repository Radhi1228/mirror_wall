import 'package:flutter/material.dart';
import 'package:mirror_wall_1/screen/home/provider/home_provider.dart';
import 'package:mirror_wall_1/utils/routes.dart';
import 'package:provider/provider.dart';

import 'componets/network/provider/network_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value:NetworkProvider()..checkConnectivity()),
        ChangeNotifierProvider.value(value:HomeProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: app_routes,
      ),
    ),
  );
}
