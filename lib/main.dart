import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pokeblog/config/config.dart';

import 'views/home.dart';



void main() async {
  final configurations = Configurations();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: configurations.apiKey,
          appId: configurations.appId,
          messagingSenderId: configurations.messagingSenderId,
          projectId: configurations.projectId));
  runApp(const MyApp());
}



class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PokeBlog',
      theme: ThemeData(),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}














// void main()  async{
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//     name: 'blogger',
//       options: FirebaseOptions(
//         apiKey: "AIzaSyBBQE6JKz7NizcLc1FBoEq61cHV9fUhSYU",
//         authDomain: "fir-90126.firebaseapp.com",
//         projectId: "fir-90126",
//         storageBucket: "fir-90126.appspot.com",
//         messagingSenderId: "1057157034551",
//         appId: "1:1057157034551:web:6a9db7b9d0251b77d685b2"
//       )
//   );
//
//   runApp(const MyApp());
// }