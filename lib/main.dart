import 'dart:io';

import 'package:carsnexus_owner/Authentication/Provider/auth_provider.dart';
import 'package:carsnexus_owner/Employee/Provider/employee_provider.dart';
import 'package:carsnexus_owner/Home%20&%20Shops/Provider/home_provider.dart';
import 'package:carsnexus_owner/Home%20&%20Shops/Provider/shop_provider.dart';
import 'package:carsnexus_owner/Home%20&%20Shops/home_screen.dart';
import 'package:carsnexus_owner/Localization/language_localization.dart';
import 'package:carsnexus_owner/Localization/localization_constant.dart';
import 'package:carsnexus_owner/Package/Provider/package_provider.dart';
import 'package:carsnexus_owner/Profile/Provider/notification_provider.dart';
import 'package:carsnexus_owner/Profile/Provider/profile_provider.dart';
import 'package:carsnexus_owner/Service%20Request/Provider/service_request_provider.dart';
import 'package:carsnexus_owner/Services/Provider/service_provider.dart';
import 'package:carsnexus_owner/Utils/preferences_names.dart';
import 'package:carsnexus_owner/Utils/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'Authentication/login_screen.dart';
import 'Theme/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferenceHelper.init();
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();

  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState state = context.findAncestorStateOfType<_MyAppState>()!;
    state.setLocale(newLocale);
  }
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void didChangeDependencies() {
    getLocale().then((local) => {
          setState(() {
            _locale = local;
          })
        });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    if (_locale == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return MultiProvider(
        providers: [
          ChangeNotifierProvider<AuthProvider>(
            create: (context) => AuthProvider(),
          ),
          ChangeNotifierProvider<HomeProvider>(
            create: (context) => HomeProvider(),
          ),
          ChangeNotifierProvider<ServiceProvider>(
            create: (context) => ServiceProvider(),
          ),
          ChangeNotifierProvider<PackageProvider>(
            create: (context) => PackageProvider(),
          ),
          ChangeNotifierProvider<EmployeeProvider>(
            create: (context) => EmployeeProvider(),
          ),
          ChangeNotifierProvider<NotificationProvider>(
            create: (context) => NotificationProvider(),
          ),
          ChangeNotifierProvider<ProfileProvider>(
            create: (context) => ProfileProvider(),
          ),
          ChangeNotifierProvider<ServiceRequestProvider>(
            create: (context) => ServiceRequestProvider(),
          ),
          ChangeNotifierProvider<ShopProvider>(
            create: (context) => ShopProvider(),
          ),
        ],
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: MaterialApp(
            title: 'Car-Q Owner',
            debugShowCheckedModeBanner: false,
            theme: CustomTheme.lightTheme,
            locale: _locale,
            supportedLocales: const [
              Locale(english, 'US'),
              Locale(arabic, 'AE'),
            ],
            localizationsDelegates: const [
              LanguageLocalization.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            localeResolutionCallback: (deviceLocal, supportedLocales) {
              for (var local in supportedLocales) {
                if (local.languageCode == deviceLocal!.languageCode &&
                    local.countryCode == deviceLocal.countryCode) {
                  return deviceLocal;
                }
              }
              return supportedLocales.first;
            },
            home: SharedPreferenceHelper.getBoolean(PreferencesNames.isLogin) ==
                    false
                ? const LoginScreen()
                : const HomeScreen(),
          ),
        ),
      );
    }
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, host, port) => true;
  }
}
