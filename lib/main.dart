import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutterloginui/models/user.dart';
import 'package:flutterloginui/providers/products_provider.dart';
import 'package:flutterloginui/screens/wrapper.dart';
import 'package:flutterloginui/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:splashscreen/splashscreen.dart';

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
    return MaterialApp(
      theme: ThemeData(fontFamily: "Nunito"),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(
        //number of seconds the splash screen will show
        seconds: 7,
        //Page to show after splash screen
        navigateAfterSeconds: AfterSplash(),
        title: new Text(
          'zodongo Foods',
          style: new TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 30.0,
              fontFamily: "Montserrat-Regular"),
        ),
        styleTextUnderTheLoader: new TextStyle(),

        loadingText: new Text(
          'Welcome to Zodongo Foods. All your Favourite foods available at your finger tips',
          style: new TextStyle(
              fontWeight: FontWeight.w100,
              color: Colors.white,
              fontSize: 20.0,
              fontFamily: "Montserrat-Regular"),
        ),
        //Our logo that we have imported in step 2
        image: new Image.asset('assets/images/mexicanplate.png'),
        //Splash Screen Background color
        gradientBackground: LinearGradient(
            colors: [Colors.greenAccent[700], Colors.greenAccent[700]],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight),
        backgroundColor: Colors.white,
        photoSize: 100.0,
        loaderColor: Colors.white,
      ),
    );
  }
}

class AfterSplash extends StatelessWidget {
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
