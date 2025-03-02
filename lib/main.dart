import 'package:agora_call/screen/home.dart';
import 'package:agora_call/utils/const/const.dart';
import 'package:connectivity_wrapper/connectivity_wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(

  );
  runApp(
    ConnectivityAppWrapper(
      app: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              primarySwatch: Colors.blue,
              scaffoldBackgroundColor: Colors.teal.shade100,
              appBarTheme: const AppBarTheme(
                  backgroundColor: Colors.teal,
                  titleTextStyle: TextStyle(color: Colors.white, fontSize: 20)),
              elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  textStyle: const TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
              )),
          navigatorKey: AgoraConstants.navigatorKey,
          home: const HomeScreen(), 
          
           builder: (buildContext, widget) {
          return ConnectivityWidgetWrapper(
            disableInteraction: true,
            height: 80,
            child: widget!,
          );
        },),
    ),
  );
}
