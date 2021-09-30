import 'package:flutter/material.dart';
import 'package:practice/providers/auth.dart';
import 'package:practice/providers/cart.dart';
import 'package:practice/providers/order.dart';
import 'package:practice/providers/products.dart';
import 'package:practice/providers/theme.dart';
import 'package:practice/providers/user_details.dart';
import 'package:practice/screens/splach_screen.dart';
import 'package:provider/provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'clothes Shop';

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: Auth()),
        ChangeNotifierProvider.value(value: ThemeNotfire()),
        ChangeNotifierProvider.value(value: UserDatails()),
        ChangeNotifierProxyProvider<Auth, Products>(
          create: (ctx) => Products('', [], ''),
          update: (context, auth, previous) => Products(
            auth.userId,
            previous!.items,
            auth.token,
          ),
        ),
        ChangeNotifierProxyProvider<Auth, Order>(
          create: (ctx) => Order('', [], ''),
          update: (context, auth, previous) => Order(
            auth.userId,
            previous!.orders,
            auth.token,
          ),
        ),
        ChangeNotifierProvider.value(value: Cart()),
      ],
      child: Consumer<ThemeNotfire>(
        builder: (ctx, theme, child) => MaterialApp(
          title: _title,
          debugShowCheckedModeBanner: false,
          theme: theme.getTheme(),
          home: SplachScreen(),
        ),
      ),
    );
  }
}
/*

*/