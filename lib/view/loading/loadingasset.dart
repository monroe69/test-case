import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:lottie/lottie.dart';

class loadingasset extends StatelessWidget {
  const loadingasset({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: const Color.fromARGB(255, 21, 22, 31),
      body: Center(
        child: Container(
          height: 200,
          width: 200,
          child: Lottie.asset("assets/lottie/loading.json")),
      ),
    );
  }
}