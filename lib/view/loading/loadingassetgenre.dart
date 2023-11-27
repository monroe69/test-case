import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:lottie/lottie.dart';

class loadingassetanim extends StatelessWidget {
  const loadingassetanim({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: const Color.fromARGB(255, 21, 22, 31),
      body: Center(
        child: Container(
          height: 100,
          width: 100,
          child: Lottie.asset("assets/lottie/loadinganim.json")),
      ),
    );
  }}