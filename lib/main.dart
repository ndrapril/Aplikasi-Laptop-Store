import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_kelompok/provider/cart_provider.dart'; 
import 'package:project_kelompok/provider/imagepick_provider.dart';
import 'package:project_kelompok/screen/cart_screen.dart';
import 'package:project_kelompok/screen/home_screen.dart';
import 'package:project_kelompok/screen/login_screen.dart';
import 'package:project_kelompok/provider/auth_provider.dart' as my_auth_provider;
import 'package:project_kelompok/screen/profile_screen.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => my_auth_provider.AuthProvider()),
        ChangeNotifierProvider(create: (_) => ImagePickProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()), // Add CartProvider here
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Laptop Store',
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          primarySwatch: Colors.green,
        ),
        themeMode: ThemeMode.dark,
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (ctx, snapshot) {
            if (snapshot.hasData) {
              return const HomePage();
            }
            return const LoginScreen();
          },
        ),
        routes: {
          '/profile': (context) => const ProfileScreen(),
        },
      ),
    );
  }
}
