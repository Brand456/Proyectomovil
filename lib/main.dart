import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:productos_app/screens/actividad_screen.dart';
import 'package:productos_app/screens/home_chat.dart';
import 'package:productos_app/screens/home_elegir.dart';
import 'package:productos_app/screens/home_tesista.dart';
import 'package:productos_app/screens/login_screen2.dart';
import 'package:productos_app/screens/register_screen2.dart';
import 'package:productos_app/screens/tesista_gestiontesis.dart';
import 'package:provider/provider.dart';
import 'package:productos_app/screens/screens.dart';
import 'package:productos_app/services/servicesGestion/services.dart';
import 'package:productos_app/services/servicesActi/services.dart';
import 'package:productos_app/services/servicesaviso/services.dart';
import 'package:productos_app/services/servicesTarea/products_service.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(AppState());
}

class AppState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ActivityService()),
        ChangeNotifierProvider(create: (_) => AuthService()),
        ChangeNotifierProvider(create: (_) => ProductsService()),
        ChangeNotifierProvider(create: (_) => TareaService()),
        ChangeNotifierProvider(create: (_) => AvisoService()),
      ],
      child: MyApp(),
    );
  }
}

class MyApp extends StatefulWidget {
  @override
  _MyappState createState() => _MyappState();
}

class _MyappState extends State<MyApp> {
  final client = StreamChatClient('ykad9sa468gp', logLevel: Level.INFO);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Tesis App',
        initialRoute: 'homeelegir',
        routes: {
          'checking': (_) => CheckAuthScreen(),
          'homechat': (_) => Homechat(),
          'homechatver': (_) => HomeActiopc(),
          'home': (_) => Homegestion(),
          'tareas': (_) => ActivityScreen(),
          'activi': (_) => Homeactivi(),
          'tarea': (_) => TareaScreen(),
          'ver': (_) => LookScreen(),
          'home2': (_) => Homegestiontesista(),
          'homeprin': (_) => BotonesPage(),
          'homeelegir': (_) => Homeopc(),
          'product': (_) => ProductScreen(),
          'login': (_) => LoginScreen(),
          'login2': (_) => LoginScreen2(),
          'register': (_) => RegisterScreen(),
          'register2': (_) => RegisterScreen2(),
          'homeavis': (_) => Homeaviso(),
          'hometesis': (_) => Hometesista(),
          'avis': (_) => AvisoScreen(),
        },
        scaffoldMessengerKey: NotificationsService.messengerKey,
        theme: ThemeData.light().copyWith(
            scaffoldBackgroundColor: Colors.grey[300],
            appBarTheme: AppBarTheme(elevation: 0, color: Colors.indigo),
            floatingActionButtonTheme: FloatingActionButtonThemeData(
                backgroundColor: Colors.indigo, elevation: 0)),
        builder: (context, child) {
          return StreamChat(client: client, child: child);
        });
  }
}
