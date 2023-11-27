import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tes_api/controller/authcontroller.dart';
import 'package:tes_api/routes/routename.dart';
import 'package:tes_api/routes/routes.dart';
import 'package:tes_api/view/beranda/tesmain.dart';
import 'package:tes_api/view/utils/Loadingpage.dart';
import 'view/auth/Log-in.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> main() async {
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
    final authC = Get.put(authcontroller(), permanent: true);
    return StreamBuilder<User?>(
      stream: authC.stremAuthStatus(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          
          return GetMaterialApp(
            title: 'apps',
            debugShowCheckedModeBanner: false,
            initialRoute: snapshot.data != null && snapshot.data!.emailVerified
                ? TodoRoute.Home
                : TodoRoute.login,
            getPages: TodoRoute.page,
          );
        }
       return const LoadingPage();
      },
    );
  }
}
