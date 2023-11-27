import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';

class done extends StatelessWidget {
  const done({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 21, 22, 31),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: ListView(
          children: [
            const SizedBox(height: 80,),
            const Center(
              child: Center(child: Text("Done task",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 20),),),
            ),
             const SizedBox(height: 80,),
            SizedBox(
              height: 1000,
              child: ListView.builder(
                itemCount: 2,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () => Get.toNamed('/detail-data'),
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      height: 65,
                      width: 308,
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 199, 194, 194),
                          borderRadius: BorderRadius.circular(20)),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          children: [
                            IconButton(
                                onPressed: () => null,
                                icon: const Icon(Icons.check_circle_outline_rounded)),
                            const SizedBox(
                              width: 2,
                            ),
                            const Text("Task 1")
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
