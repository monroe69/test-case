import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:lottie/lottie.dart';

import 'package:tes_api/controller/authcontroller.dart';

import 'package:tes_api/model/modelnote.dart';
import 'package:tes_api/view/beranda/Genre/prioritas.dart';
import 'package:tes_api/view/beranda/Genre/tgldeadline.dart';
import 'package:tes_api/view/beranda/add_data.dart';
import 'package:tes_api/view/beranda/detail_data.dart';
import 'package:tes_api/view/beranda/done.dart';
import 'package:tes_api/view/beranda/editdata.dart';
import 'package:tes_api/view/loading/loadingasset.dart';

class beranda extends StatefulWidget {
  @override
  State<beranda> createState() => _berandaState();
}

class _berandaState extends State<beranda> {
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
          final DateTime combinedDateTime = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );

          selectedDateTime = combinedDateTime;

          auth.filterbydate(selectedDateTime!);
        } else {

          
        }
      }
    }

    Get.put(authcontroller());

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          height: 1000,
          child: StreamBuilder<QuerySnapshot>(
            stream: auth.getUserDocument(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<QueryDocumentSnapshot> documents = snapshot.data!.docs;
                return ListView(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const CircleAvatar(
                              backgroundColor: Colors.black,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Hello, ${FirebaseAuth.instance.currentUser!.email}",
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    ],
                                ),
                                const Text(
                                  "To do list",
                                  style: TextStyle(color: Colors.black),
                                )
                              ],
                            )
                          ],
                        ),
                        IconButton(
                            onPressed: () => auth.logout(),
                            icon: const Icon(
                              Icons.logout_outlined,
                              color: Colors.black,
                            ))
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                   
                  const SizedBox(
                      height: 20,
                    ),
                   
                    const Text(
                      "Kegiatan",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                   Container(
                    height: Get.height,
                    width: Get.width,
                    decoration: const BoxDecoration(color: Colors.grey,borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20))),
                    child:  SizedBox(
                      height: 20,
                      child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: documents.length,
                        itemBuilder: (context, index) {
                          DocumentSnapshot document = documents[index];
                          Map<String, dynamic> data =
                              document.data() as Map<String, dynamic>;
                          if (data.containsKey('id') &&
                              data.containsKey('prioritas') &&
                              data.containsKey('status') &&
                              data.containsKey('date') &&
                              data.containsKey('title') &&
                              data.containsKey('isDon')) {
                            String id = data['id'].toString();
                            String prioritas = data['prioritas'].toString();
                            bool isdon = data['isDon'];
                            String status = data['status'].toString();
                            String title = data['title'];

                            return InkWell(
                              onTap: () => Get.toNamed('/detail-data',
                                  arguments: document),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 16,right: 16),
                                child: Container(
                                  margin: const EdgeInsets.only(top: 40),
                                  height: 85,
                                  width: 108,
                                  decoration: BoxDecoration(
                                    color: Colors.white, 
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(
                                            0.2),
                                        spreadRadius: 2,
                                        blurRadius: 5,
                                        offset: const Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Checkbox(
                                              value: isdon,
                                              onChanged: (value) {
                                                setState(() {
                                                  isdon = value!;
                                                  auth.isdone(id, value);
                                                });
                                              },
                                            ),
                                            const SizedBox(width: 8),
                                            Text(
                                              "${title}",
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            IconButton(
                                              onPressed: () => Get.to(const editdata(),
                                                  arguments: document),
                                              icon: const Icon(Icons.edit),
                                              color:
                                                  Colors.blue, // Edit icon color
                                            ),
                                            IconButton(
                                              onPressed: () {
                                                Get.defaultDialog(
                                                  middleText: 'Yakin ingin hapus',
                                                  cancel: ElevatedButton(
                                                    onPressed: () => Get.back(),
                                                    child: const Text("Kembali"),
                                                    style: ButtonStyle(
                                                      backgroundColor:
                                                          MaterialStateProperty
                                                              .all(Colors.grey),
                                                    ),
                                                  ),
                                                  confirm: ElevatedButton(
                                                    onPressed: () {
                                                      auth.deleteNote(id);
                                                      Get.back();
                                                    },
                                                    child: const Text("Ya, hapus"),
                                                    style: ButtonStyle(
                                                      backgroundColor:
                                                          MaterialStateProperty
                                                              .all(Colors.red),
                                                    ),
                                                  ),
                                                );
                                              },
                                              icon: const Icon(LineIcons.trash),
                                              color:
                                                  Colors.red, // Trash icon color
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          } else {
                            return Center(
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 20),
                                height: 65,
                                width: 308,
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(255, 255, 255, 255),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Lottie.asset(
                                  "assets/lottie/animation_ln07v442.json",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          }
                        },
                      ),
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
          height: 200,
          width: 200,
          child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Lottie.asset("assets/lottie/animation_ln07p4yj.json",
                  fit: BoxFit.cover)),
        ),
      ),
    );
  }
}
