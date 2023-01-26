// ignore_for_file: depend_on_referenced_packages
//  (size.height - (size.height * 0.81) ) / 2
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
        backgroundColor: Colors.blueAccent,
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
                horizontal: 30, vertical: size.height * 0.03),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                  elevation: 3,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                  child: Container(
                    width: size.width,
                    height: size.height * 0.18,
                    decoration: BoxDecoration(
                      color: Colors.grey[100]?.withOpacity(0.8),
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const SizedBox(width: 35),
                        Container(
                          height: 100,
                          width: 110,
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
                        ),
                        const SizedBox(width: 85),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.03),
                // Last activity box
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  height: size.height - (size.height * 0.84),
                  width: size.width,
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Last time opened
                      Row(
                        children: const [
                          Text(
                            'Last time opened:',
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: Colors.black54),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            controller.lastTimeOpened ?? "No records yet",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: controller.lastTimeOpened == null
                                    ? Colors.black54
                                    : Colors.black87),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),

                      // Last time closed
                      Row(
                        children: const [
                          Text(
                            'Last time closed:',
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: Colors.black54),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            controller.lastTimeClosed ?? "No records yet",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: controller.lastTimeClosed == null
                                    ? Colors.black54
                                    : Colors.black87),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),

                      // Last time full
                      Row(
                        children: const [
                          Text(
                            'Last time full:',
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: Colors.black54),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            controller.lastTimeFull ?? "No records yet",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: controller.lastTimeFull == null
                                    ? Colors.black54
                                    : Colors.black87),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: size.height * 0.03),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 18),
                  width: size.width,
                  decoration: BoxDecoration(
                    color: Colors.grey[100]?.withOpacity(0.7),
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                  ),
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(bottom: 18),
                        child: Text(
                          'Bin Current State',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Colors.black54),
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.only(
                                  bottom: 10, top: controller.open ? 12 : 12),
                              // height: 200,
                              height: size.height * 0.22,
                              decoration: const BoxDecoration(
                                color: Color.fromRGBO(24, 160, 221, 0.06),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12)),
                              ),
                              child: Column(
                                children: [
                                  const SizedBox(height: 15),
                                  controller.open
                                      ? const Image(
                                          image:
                                              AssetImage("assets/bin_open.png"),
                                          height: 110,
                                          width: 100,
                                          color: Colors.black87,
                                        )
                                      : const Image(
                                          image: AssetImage(
                                              "assets/bin-closed.png"),
                                          height: 110,
                                          width: 100,
                                          color: Colors.black87,
                                        ),
                                  const Expanded(child: SizedBox()),
                                  Text(
                                    controller.open
                                        ? ' Bin is Open'
                                        : 'Bin is Closed',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: controller.open
                                            ? Colors.red[800]
                                            : Colors.black),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 15),
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.only(bottom: 10),
                              // height: 200,
                              height: size.height * 0.22,
                              decoration: const BoxDecoration(
                                color: Color.fromRGBO(64, 190, 121, 0.05),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12)),
                              ),
                              child: Column(
                                children: [
                                  const SizedBox(height: 15),
                                  controller.locked
                                      ? const Image(
                                          image: AssetImage(
                                              "assets/lock-closed.png"),
                                          height: 130,
                                          width: 80,
                                          color: Colors.black87,
                                        )
                                      : const Image(
                                          image: AssetImage(
                                              "assets/padlock_open.png"),
                                          height: 150,
                                          width: 100,
                                          color: Colors.black87,
                                        ),
                                  const Expanded(child: SizedBox()),
                                  Text(
                                    controller.locked
                                        ? 'Bin is Locked'
                                        : 'Bin is Unlocked',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: controller.locked
                                            ? Colors.red
                                            : Colors.black),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: size.height * 0.04),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      onPressed: () {
                        print('Custom Button pressed');
                        controller.mqttPublish(controller.open ? "2" : "1");
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: controller.open
                            ? Colors.amber[900]
                            : Colors.blue[400],
                        fixedSize: Size(size.width / 2.5, 50),
                        padding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: Text(
                        controller.open ? "Close" : "Open",
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    //
                    TextButton(
                      onPressed: () {
                        print('Custom Button pressed');
                        controller.mqttPublish(controller.locked ? "2" : "1");
                      },
                      style: TextButton.styleFrom(
                        backgroundColor:
                            controller.locked ? Colors.red : Colors.green[400],
                        fixedSize: Size(size.width / 2.5, 50),
                        padding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
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
                  ],
                ),
                SizedBox(height: size.height * 0.03),
              ],
            ),
          );
        },
      ),
    );
  }
}
