import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/pages/home_page.dart';
import 'package:qr_reader/pages/map_page.dart';
import 'package:qr_reader/providers/scan_list_provider.dart';
import 'package:qr_reader/providers/ui_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var providers = [
      ChangeNotifierProvider(
        create: (_) => UiProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => ScanListProvider(),
      ),
    ];
    return MultiProvider(
      providers: providers,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'QR Code Reader',
        initialRoute: 'home',
        routes: <String, WidgetBuilder>{
          'home': (_) => HomePage(),
          'mapa': (_) => MapPage(),
        },
        theme: ThemeData.dark().copyWith(
          accentColor: Colors.purple,
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: Colors.deepPurple,
          ),
        ),
      ),
    );
  }
}
