import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:tes_api/controller/authcontroller.dart';

class editdata extends StatefulWidget {
  const editdata({super.key});

  @override
  State<editdata> createState() => _editdataState();
}

class _editdataState extends State<editdata> {
  @override
  Widget build(BuildContext context) {
    var selectedOption = ''.obs;
    var selectedOption1 = ''.obs;
    List<String> items = ['Sudah Selesai', 'Belum Selesai'];
    List<String> item = ['Sangat penting', 'Penting', 'Biasa saja'];
    
    final auth = Get.find<authcontroller>();
    final index = Get.arguments;
    final controller = Get.find<authcontroller>();
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
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
                  data.containsKey('title')) {
                String id = data['id'];
                String prioritas = data['prioritas'];

                String status = data['status'];
                String date = data['date'];

                String title = data['title'];
                TextEditingController dateController =
                    TextEditingController(text: date);
                void selectDateTime(BuildContext context) {
                  DatePicker.showDateTimePicker(
                    context,
                    showTitleActions: true,
                    minTime: DateTime(2000),
                    maxTime: DateTime(2101),
                    onConfirm: (DateTime picked) {
                      setState(() {
                        dateController.text = picked.toString();
                      });
                    },
                    currentTime: DateTime.now(),
                  );
                }

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
                              InkWell(
                                onTap: () => selectDateTime(context),
                                child: Container(
                                  height: 80,
                                  width: 150,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    color: const Color.fromARGB(255, 21, 22, 31),
                                  ),
                                  child: TextFormField(
                                    style: const TextStyle(color: Colors.white),
                                    controller: dateController,
                                    readOnly: true,
                                    decoration: InputDecoration(
                                      labelText: 'Pilih Tanggal',
                                      labelStyle:
                                          const TextStyle(color: Colors.black),
                                      suffixIcon: GestureDetector(
                                        onTap: () => selectDateTime(context),
                                        child: const Icon(
                                          Icons.calendar_today,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Obx(
                          () => DropdownButton(
                            isExpanded: true,
                            hint: const Text(
                              'Pilih Status',
                              style: TextStyle(color: Colors.black),
                            ),
                            value: items.contains(selectedOption.value)
                                ? selectedOption.value
                                : null,
                            onChanged: (newValue) {
                              selectedOption.value = newValue!;
                            },
                            items: items.map((option) {
                              return DropdownMenuItem(
                                child: Text(
                                  option,
                                  style: const TextStyle(color: Colors.green),
                                ),
                                value: option,
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Obx(
                          () => DropdownButton(
                            isExpanded: true,
                            hint: const Text(
                              'Pilih Prioritas',
                              style: TextStyle(color: Colors.black),
                            ),
                            value: item.contains(selectedOption1.value)
                                ? selectedOption1.value
                                : null,
                            onChanged: (newValue) {
                              selectedOption1.value = newValue!;
                            },
                            items: item.map((option) {
                              return DropdownMenuItem(
                                child: Text(
                                  option,
                                  style: const TextStyle(color: Colors.green),
                                ),
                                value: option,
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              Map<String, dynamic> updatedData = {
                                "title": title.isNotEmpty
                                    ? tes.text
                                    : title,
                                "prioritas": prioritas.isNotEmpty
                                    ? selectedOption1.value
                                    : prioritas,
                                "status": status.isNotEmpty
                                    ? selectedOption.value
                                    : status,
                                "date": date.isNotEmpty
                                    ? dateController.text
                                    : date
                              };
print("tesssssssssss $updatedData");
                              controller.edit(updatedData, id);
                            },
                            child: Container(
                              height: 50,
                              width: 114,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  color: const Color(0xffD9D9D9)),
                              child: const Center(
                                child: Text(
                                  "Edit",
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Container(
                            height: 50,
                            width: 114,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                color: const Color(0xffA75555)),
                            child: const Center(
                              child: Text(
                                "Batal",
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                );
              }
              return const SizedBox();
            }));
  }
}
