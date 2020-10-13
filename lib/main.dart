// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutterloginui/providers/products_provider.dart';
// import 'package:keyboard_visibility/keyboard_visibility.dart';
// import 'package:provider/provider.dart';
// import 'Browse.dart';

// import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutterloginui/models/user.dart';
import 'package:flutterloginui/providers/products_provider.dart';
// import 'package:flutterloginui/screens/authenticate/authenticate.dart';
// import 'package:flutterloginui/providers/products_provider.dart';
import 'package:flutterloginui/screens/wrapper.dart';
import 'package:flutterloginui/services/auth.dart';
import 'package:provider/provider.dart';
// import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MyApp(),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProductProvider(),
      child: StreamProvider<UserObj>.value(
        value: AuthService().user,
        child: MaterialApp(
          theme: ThemeData(fontFamily: "Nunito"),
          debugShowCheckedModeBanner: false,
          home: Scaffold(
            resizeToAvoidBottomInset: false,
            body: Container(
              child: Wrapper(),
            ),
          ),
        ),
      ),
    );
  }
}
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (context) => ProductProvider(),
//       child: MaterialApp(
//         theme: ThemeData(fontFamily: "Nunito"),
//         debugShowCheckedModeBanner: false,
//         home: Scaffold(
//           resizeToAvoidBottomInset: false,
//           body: Container(
//             child: Wrapper(),
//           ),
//         ),
//       ),
//     );
//   }
// }
