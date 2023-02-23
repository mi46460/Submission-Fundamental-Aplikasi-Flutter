import 'dart:io';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:submission/data/api/api_service.dart';
import 'package:submission/data/db/database_helper.dart';
import 'package:submission/data/sharedpreferences/shared_preferences.dart';
import 'package:submission/pages/detail_page.dart';
import 'package:submission/pages/home_page.dart';
import 'package:submission/common/styles.dart';
import 'package:submission/provider/database_provider.dart';
import 'package:submission/provider/detail_restaurant_provider.dart';
import 'package:submission/provider/list_restaurant_provider.dart';
import 'package:submission/data/model/restaurant.dart';
import 'package:submission/provider/scheduling_provider.dart';
import 'package:submission/provider/search_restaurant_provider.dart';
import 'package:submission/provider/shared_preverence_provider.dart';
import 'package:submission/utils/background_service.dart';
import 'package:submission/utils/notification_helper.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final NotificationHelper notificationHelper = NotificationHelper();
  final BackgroundService service = BackgroundService();
  service.initializeIsolate();
  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }
  await notificationHelper.initNotifications(flutterLocalNotificationsPlugin);
  runApp(
    MultiProvider(
      providers: providers,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: Theme.of(context).colorScheme.copyWith(
            primary: primaryColor,
            onPrimary: Colors.black,
            secondary: secondaryColor),
        primarySwatch: Colors.blue,
        textTheme: myTextTheme,
      ),
      initialRoute: HomePage.route,
      routes: {
        HomePage.route: (context) => const HomePage(),
        DetailPage.route: (context) => DetailPage(
              restaurant:
                  ModalRoute.of(context)?.settings.arguments as RestaurantModel,
            ),
      },
    );
  }
}

List<SingleChildWidget> providers = [
  ChangeNotifierProvider<RestaurantProvider>(
      create: (_) => RestaurantProvider(apiService: ApiService())),
  ChangeNotifierProvider<DetailRestaurantProvider>(
      create: (_) => DetailRestaurantProvider(apiService: ApiService())),
  ChangeNotifierProvider<SearchRestaurantProvider>(
      create: (_) => SearchRestaurantProvider(apiService: ApiService())),
  ChangeNotifierProvider<DatabaseProvider>(
      create: (_) => DatabaseProvider(databaseHelper: DatabaseHelper())),
  ChangeNotifierProvider<SharedPreferenceProvider>(
      create: (_) => SharedPreferenceProvider(
          preferenceHelper: PreferenceHelper(
              sharedPreferences: SharedPreferences.getInstance()))),
  ChangeNotifierProvider<SchedulingProvider>(
      create: (_) => SchedulingProvider()),
];
