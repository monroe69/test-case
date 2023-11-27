import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:tes_api/view/auth/Log-in.dart';

class boarding extends StatelessWidget {
  const boarding({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            ElevatedButton(onPressed: () => Get.to(Login()), child: const Text("masuk"))
          ],
        ),
      ),
    );
  }
}