import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:tes_api/controller/authcontroller.dart';

class Registrasi extends GetView<authcontroller> {
  Registrasi({super.key});
  // final display = Get.find<Profilecustomer>();
  final alamat = TextEditingController();
  final emailC = TextEditingController();
  final passwordC = TextEditingController();
  final nohp = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 100,
                ),
                const Text(
                  'Lets Get Started',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  'signup and we will continue',
                  style: TextStyle(
                      color: Colors.grey[500], fontWeight: FontWeight.w300),
                ),

                const SizedBox(
                  height: 100,
                ),
                Container(
                  height: 60,
                  width: 292,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.grey),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: TextFormField(
                      controller: emailC,
                      style: const TextStyle(color: Colors.black),
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Email',
                          hintStyle: TextStyle(color: Colors.white)),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Container(
                    margin: const EdgeInsets.only(top: 15),
                    height: 60,
                    width: 292,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.grey),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: TextFormField(
                        controller: passwordC,
                        style: const TextStyle(color: Colors.black),
                        decoration: const InputDecoration(
                           
                            border: InputBorder.none,
                            hintText: 'Password',
                            hintStyle: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                //             Container(
                //   padding: EdgeInsets.symmetric(horizontal: 16.0),
                //   child: Obx(
                //     () => DropdownButton(
                //       isExpanded: true,
                //       hint: Text('Pilih opsi'),
                //       value: controller.selectedOption.value,
                //       onChanged: (newValue) {
                //         controller.selectedOption.value = newValue!;
                //       },
                //       items: controller.options.map((option) {
                //         return DropdownMenuItem(
                //           child: Text(option),
                //           value: option,
                //         );
                //       }).toList(),
                //     ),
                //   ),
                // ),
                ElevatedButton(
                    onPressed: () =>
                        controller.signup(emailC.text, passwordC.text),
                    child: const Text('Daftar'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
