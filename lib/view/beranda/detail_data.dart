import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:tes_api/controller/authcontroller.dart';

class daetaildata extends GetView<authcontroller> {
  const daetaildata({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Get.find<authcontroller>();
    final index = Get.arguments;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
              onPressed: () => Get.back(), icon: const Icon(Icons.arrow_back,color: Colors.black,)),
        ),
        body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: controller.getUserDocument(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                return const CircularProgressIndicator();
              }
              Map<String, dynamic> data = index.data() as Map<String, dynamic>;
              if (data.containsKey('id') &&
                  data.containsKey('prioritas') &&
                  data.containsKey('status') &&
                  data.containsKey('date') &&
                  data.containsKey('title') &&
                              data.containsKey('isDon')) {
                String id = data['id'];
                String prioritas = data['prioritas'];
 bool isdon = data['isDon'];
                String status = data['status'];
                String date = data['date'];

                String title = data['title'];
                TextEditingController tes = TextEditingController(text: title);
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ListView(
                    children: [
                      Container(
                        height: 253,
                        width: 300,
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black,
                            ),
                            borderRadius: BorderRadius.circular(20)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            controller: tes,
                            style: const TextStyle(color: Colors.black),
                            decoration: const InputDecoration(
                                labelStyle: TextStyle(color: Colors.black),
                                focusColor: Colors.black,
                                fillColor: Colors.black,
                                border: InputBorder.none,
                                hintText: 'What do you want to do ?...',
                                hintStyle: TextStyle(color: Colors.black)),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 66,
                      ),
                      Container(
                        height: 70,
                        width: 300,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Row(
                                children: [
                                  Icon(
                                    Icons.calendar_month_outlined,
                                    color: Colors.black,
                                    size: 40,
                                  ),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Text(
                                    "Batas Waktu",
                                    style: TextStyle(color: Colors.black),
                                  )
                                ],
                              ),
                              Center(
                                child: Text(
                                  "${date}",
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 70,
                        width: 300,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                   isdon
                                        ? Icons.check_circle
                                        : Icons.circle_outlined,
                                    color: isdon
                                        ? Colors.green
                                        : Colors.grey,
                                  ),
                                  const SizedBox(
                                    width: 4,
                                  ),
                                  Text(
                                    isdon
                                        ? 'Sudah Selesai'
                                        : 'Belum Selesai',
                                    style: TextStyle(
                                      color: isdon
                                          ? Colors.green
                                          : Colors.red,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 70,
                        width: 300,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const Icon(
                                    Icons.diamond_outlined,
                                    color: Colors.black,
                                    size: 40,
                                  ),
                                  const SizedBox(
                                    width: 4,
                                  ),
                                  Text(
                                    "${prioritas}",
                                    style: const TextStyle(color: Colors.black),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }
              return const SizedBox();
            }));
  }
}
