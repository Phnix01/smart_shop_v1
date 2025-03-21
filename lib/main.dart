import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:smart_shop_v1/consts/styles.dart';
import 'package:smart_shop_v1/providers/theme_provider.dart';
import 'package:smart_shop_v1/root_screen.dart';
import 'package:smart_shop_v1/screens/auth/forgot_password_screen.dart';
import 'package:smart_shop_v1/screens/auth/login_screen.dart';
import 'package:smart_shop_v1/screens/home_screen.dart';
import 'package:smart_shop_v1/screens/inner_screen.dart/product_detail.dart';

void main() {
  //Do this in main.dart
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) {
            return ThemeProvider();
          },
        )
      ],
      child: Consumer<ThemeProvider>(builder: (context, themeProvider, child) {
        return MaterialApp(
          theme: Styles.themeData(
              isDark: themeProvider.getIsDarkTheme, BuildContext: context),
          home: const ForgotPasswordScreen(),
          routes: {
            ProductDetails.routName: (context) => ProductDetails(),
            RootScreen.routeName: (context) => RootScreen(),
          },
        );
      }),
    );
  }
}
