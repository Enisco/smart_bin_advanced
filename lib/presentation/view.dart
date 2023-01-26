// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_bin_advanced/presentation/controller.dart';

class SmartWasteBinPageView extends StatefulWidget {
  const SmartWasteBinPageView({super.key});

  @override
  State<SmartWasteBinPageView> createState() => _SmartWasteBinPageViewState();
}

class _SmartWasteBinPageViewState extends State<SmartWasteBinPageView> {
  final controller = Get.put(SmartWasteBinController());

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Smart Waste Bin',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: GetBuilder<SmartWasteBinController>(
        init: SmartWasteBinController(),
        builder: (context) {
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(
                horizontal: 40, vertical: size.height * 0.03),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: size.width,
                  height: 150,
                  decoration: BoxDecoration(
                    // color: Color.fromRGBO(24, 160, 251, 0.08),
                    color: Colors.grey[100],
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(width: 25),
                      Container(
                        height: 90,
                        width: 100,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(0),
                          ),
                          image: DecorationImage(
                            image: AssetImage(
                              'assets/waste-bin.gif',
                            ),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Bin fill level:',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.black54),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            '${controller.percentageVal.toString()}%',
                            style: const TextStyle(
                              fontSize: 55,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(height: size.height * 0.04),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    CircleAvatar(
                      radius: 10,
                      backgroundColor: Colors.red,
                    ),
                    SizedBox(width: 10),
                    Text('Filled'),
                    SizedBox(width: 30),
                    CircleAvatar(
                      radius: 10,
                      backgroundColor: Colors.green,
                    ),
                    SizedBox(width: 10),
                    Text('Available'),
                  ],
                ),
                SizedBox(height: size.height * 0.06),
                const Text(
                  'Bin fill level:',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black54),
                ),
                SizedBox(height: size.height * 0.02),
                Text(
                  '${controller.percentageVal.toString()}%',
                  style: const TextStyle(
                    fontSize: 55,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                // const SizedBox(height: 25),
                SizedBox(height: size.height * 0.045),
                Center(
                  child: TextButton(
                    onPressed: () {
                      print('Custom Button pressed');
                      controller.mqttPublish(controller.locked ? "2" : "1");
                    },
                    style: TextButton.styleFrom(
                      backgroundColor:
                          controller.locked ? Colors.red : Colors.green,
                      fixedSize: Size(size.width / 2, 50),
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28),
                      ),
                    ),
                    child: Text(
                      controller.locked ? "Unlock" : "Lock",
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
