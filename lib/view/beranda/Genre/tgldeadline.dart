import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:line_icons/line_icons.dart';
import 'package:lottie/lottie.dart';

import 'package:tes_api/controller/authcontroller.dart';



import 'package:tes_api/view/beranda/Genre/prioritas.dart';

import 'package:tes_api/view/beranda/editdata.dart';
import 'package:tes_api/view/beranda/tesmain.dart';


class deadline extends GetView {
  @override
  Widget build(BuildContext context) {
    final auth = Get.find<authcontroller>();
    DateTime? selectedDate;
    DateTime? selectedDateTime;
    Future<void> _selectDate(BuildContext context) async {
      final DateTime pickedDate = (await showDatePicker(
        context: context,
        initialDate: selectedDateTime ?? DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2101),
      ))!;

      if (pickedDate != null) {
        final TimeOfDay pickedTime = (await showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
        ))!;

        if (pickedTime != null) {
          // Combine the picked date and time into a single DateTime.
          final DateTime combinedDateTime = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );

          // Update the selectedDateTime variable.
          selectedDateTime = combinedDateTime;

          // Now, you can use selectedDateTime for filtering or any other purpose.
          auth.filterbydate(selectedDateTime!);
        }
      }
    }

 
    Get.put(authcontroller());

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 21, 22, 31),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          height: 1000,
          child: StreamBuilder<QuerySnapshot>(
            stream: auth.orderbydate(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<QueryDocumentSnapshot> documents = snapshot.data!.docs;

                return ListView(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.white,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Hello,Users",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Icon(
                                      Icons.check_circle,
                                      color: Colors.white,
                                      size: 15,
                                    )
                                  ],
                                ),
                                Text(
                                  "To do list",
                                  style: TextStyle(color: Colors.white),
                                )
                              ],
                            )
                          ],
                        ),
                        IconButton(
                            onPressed: () => auth.logout(),
                            icon: const Icon(
                              Icons.logout_outlined,
                              color: Colors.white,
                            ))
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                       
                        InkWell(
                          onTap: () => Get.to(beranda()),
                          child: Container(
                            margin: const EdgeInsets.only(right: 10),
                            height: 42,
                            width: 80,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Colors.white)),
                            child: const Center(
                                child: Text(
                              "Title",
                              style: TextStyle(color: Colors.white),
                            )),
                          ),
                        ),
                        InkWell(
                          onTap: () => Get.to(prioritas()),
                          child: Container(
                            margin: const EdgeInsets.only(right: 10),
                            height: 42,
                            width: 80,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Colors.white)),
                            child: const Center(
                                child: Text(
                              "Prioritas",
                              style: TextStyle(color: Colors.white),
                            )),
                          ),
                        ),
                        InkWell(
                          onTap: () => deadline(),
                          child: Container(
                            margin: const EdgeInsets.only(right: 10),
                            height: 42,
                            width: 80,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Colors.white)),
                            child: const Center(
                                child: Text(
                              "Deadline",
                              style: TextStyle(color: Colors.white),
                            )),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    // InkWell(
                    //   onTap: () => _selectDate,
                    //   child: Container(
                    //     margin: EdgeInsets.only(right: 10),
                    //     height: 42,
                    //     width: 84,
                    //     decoration: BoxDecoration(
                    //         border: Border.all(color: Colors.white)),
                    //     child: Center(
                    //         child: Text(
                    //       "Tgl Deadline",
                    //       style: TextStyle(color: Colors.white),
                    //     )),
                    //   ),
                    // ),
                    const SizedBox(
                      height: 20,
                    ),
                     const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "- Deadline",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                     const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "My Task",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 1000,
                      child: ListView.builder(
                        itemCount: documents.length,
                        itemBuilder: (context, index) {
                          DocumentSnapshot document = documents[index];
                          Map<String, dynamic> data =
                              document.data() as Map<String, dynamic>;
                          if (data.containsKey('id') &&
                              data.containsKey('prioritas') &&
                              data.containsKey('status') &&
                              data.containsKey('date') &&
                              data.containsKey('title')) {
                            String id = data['id'];
                            String prioritas = data['prioritas'];

                            String status = data['status'];
                            // DateTime date = data['date'];

                            String title = data['title'];

                            return InkWell(
                              onTap: () => Get.toNamed('/detail-data',
                                  arguments: document),
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 20),
                                height: 65,
                                width: 308,
                                decoration: BoxDecoration(
                                    color: const Color.fromARGB(255, 255, 255, 255),
                                    borderRadius: BorderRadius.circular(20)),
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Obx(() => Checkbox(
                                                value: auth.Ischecked.value,
                                                onChanged: (value) {
                                                  auth.toggleCheckbox(id);
                                                  auth.isdone(id, value!);
                                                },
                                              )),
                                          const SizedBox(
                                            width: 2,
                                          ),
                                          Text("${title}")
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          IconButton(
                                              onPressed: () => Get.to(const editdata()),
                                              icon: const Icon(Icons.edit)),
                                          IconButton(
                                              onPressed: () {
                                               Get.defaultDialog(
                                                middleText: 'Yakin ingin hapus',
                                                cancel: ElevatedButton(onPressed: () => Get.back(), child:const Text("Kembali")),
                                                confirm: ElevatedButton(onPressed: () {
                                                  auth.deleteNote(id);
                                                  Get.back();
                                                }, child: const Text("Ya, hapus"))
                                               );
                                              },
                                              icon: const Icon(LineIcons.trash)),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          } else {
                            return Container();
                          }
                        },
                      ),
                    )
                  ],
                );
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return const Text('Loading...');
              }
            },
          ),
        ),
      ),
      floatingActionButton: InkWell(
        onTap: () => Get.toNamed('/add-data'),
        child: Container(
          height: 100,
          width: 100,
          child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Lottie.asset("assets/lottie/animation_ln07v442.json",
                  fit: BoxFit.cover)),
        ),
      ),
    );
  }
}
