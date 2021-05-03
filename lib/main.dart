import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_project_login_and_register/screens/HomeScreen/home_screen.dart';
import 'package:first_project_login_and_register/screens/LoginPage/login_screen.dart';
import 'package:first_project_login_and_register/screens/RegisterScreen/register_screen.dart';
import 'package:first_project_login_and_register/screens/WelcomePage/welcome_screen.dart';
import 'package:first_project_login_and_register/services/authentication_service.dart';
import 'package:flutter/material.dart';
// Import the firebase_core plugin
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // tai sao phải có dòng này?
  await Firebase.initializeApp();
  runApp(MyApp());
}

// Get - flutter(list nhu provider) , viet theo mo hinh MVVM(framework)

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthenticationService>(
          create: (_) => AuthenticationService(FirebaseAuth.instance),
        ),
        StreamProvider(
          create: (context) =>
              // context.read<T>(), which returns T without listening to it
              context.read<AuthenticationService>().authStateChanges,
        )
      ],
      child: MaterialApp(
          onGenerateRoute: (settings) {
            switch (settings.name) {
              case '/':
                return MaterialPageRoute(builder: (context) => WelcomeScreen());
              case '/loginScreen':
                return MaterialPageRoute(builder: (context) => LoginScreen());
              case '/registerScreen':
                return MaterialPageRoute(
                    builder: (context) => RegisterScreen());
              case '/homeScreen':
                return MaterialPageRoute(builder: (context) => HomeScreen());
              default:
                return MaterialPageRoute(
                    builder: (_) => Scaffold(
                          appBar: AppBar(
                            title: Text("ERROR"),
                          ),
                          body: Center(
                            child: Text("ERROR"),
                          ),
                        ));
            }
          },
          home: AuthenticationWrapper()),
    );
  }
}

class AuthenticationWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // watch?
    // context.watch<T>(), which makes the widget listen to changes on T
    final firebaseUser = context.watch<User>();
    if (firebaseUser != null) {
      return HomeScreen();
    }
    return WelcomeScreen();
  }
}

/*
context.watch<T>(), which makes the widget listen to changes on T
context.read<T>(), which returns T without listening to it
context.select<T, R>(R cb(T value)), which allows a widget to listen to only a small part of T.
*/
