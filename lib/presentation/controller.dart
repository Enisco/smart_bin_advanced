// ignore_for_file: depend_on_referenced_packages

import 'dart:async';
import 'dart:io';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:smart_bin_advanced/services/local_notif_services.dart';

class SmartWasteBinController extends GetxController {
  LocalNotificationServices localNotificationServices =
      LocalNotificationServices();

  var receivedMessage = '0';
  int percentageVal = 0;
  bool locked = false;
  bool open = false;
  String? lastTimeOpened, lastTimeClosed, lastTimeFull;

  String getLastTime() {
    DateTime now = DateTime.now();
    String lastTime =
        "${DateFormat.yMMMEd().format(now)} ${DateFormat.jm().format(DateTime.now())}";
    print(lastTime);
    return lastTime;
  }

  /// MQTT EMQX Credentials
  final client =
      MqttServerClient.withPort('broker.emqx.io', 'wastebinapp_client1', 1883);
  var pongCount = 0, connStatus = 0;
  final builder = MqttClientPayloadBuilder();
  String pubTopic = 'wastebinapp/apptobin';
  String subTopic = 'wastebinapp/bintoapp';

  /// Functions
  Future<void> mqttConnect() async {
    Completer<MqttServerClient> completer = Completer();

    client.logging(on: true);
    client.autoReconnect = true; //FOR AUTORECONNECT
    client.onAutoReconnect = onAutoReconnect;
    client.keepAlivePeriod = 60;
    client.onDisconnected = onDisconnected;
    client.onConnected = onConnected;
    client.onAutoReconnected = onAutoReconnected;
    client.onSubscribed = onSubscribed;
    client.pongCallback = pong;

    final connMess = MqttConnectMessage().withWillQos(MqttQos.atMostOnce);
    print('EMQX client connecting....');
    client.connectionMessage = connMess;

    try {
      await client.connect();
    } on NoConnectionException catch (e) {
      print(' client exception - $e');
      client.disconnect();
    } on SocketException catch (e) {
      // Raised by the socket layer
      print(' socket exception - $e');
      client.disconnect();
    }

    /// Check we are connected
    if (client.connectionStatus!.state == MqttConnectionState.connected) {
      connStatus = 1;
      print('EMQX client connected');
      completer.complete(client);
    } else {
      /// Use status here rather than state if you also want the broker return code.
      connStatus = 0;
      print(
          'EMQX client connection failed - disconnecting, status is ${client.connectionStatus}');
      client.disconnect();
    }

    /// Ok, lets try a subscription
    print('Subscribing to $subTopic topic');
    client.subscribe(subTopic, MqttQos.atMostOnce);
    String valCheck = "!";

    client.updates?.listen((List<MqttReceivedMessage<MqttMessage?>>? c) {
          final recMess = c![0].payload as MqttPublishMessage;

          receivedMessage =
              MqttPublishPayload.bytesToStringAsString(recMess.payload.message);

          print(
              'Topic is <${c[0].topic}>, payload is => $receivedMessage => $valCheck');

          if (receivedMessage.contains('l')) {
            locked = true;
            print("bin is now locked: locked = $locked");
          } else if (receivedMessage.contains('u')) {
            locked = false;
            print("bin is now unlocked: locked = $locked");
          } else if (receivedMessage.contains('o')) {
            open = true;
            lastTimeOpened = getLastTime();
            print("lastTimeOpened: $lastTimeOpened");
            update();
            print("bin is now open: open = $open");
          } else if (receivedMessage.contains('c')) {
            open = false;
            lastTimeClosed = getLastTime();
            print("lastTimeClosed: $lastTimeClosed");
            update();
            print("bin is now closed: open = $open");
          } else {
            try {
              percentageVal = int.parse(receivedMessage);
            } catch (e) {
              print("Error! Could not parse invalid command");
            }
          }

          if (percentageVal >= 90) {
            localNotificationServices.showNotification(percentageVal);
            locked = true;
            print("bin is now locked: locked = $locked");
            lastTimeFull = getLastTime();
            print("lastTimeFull: $lastTimeFull");
            update();
            print('Full: $percentageVal is greater than 90%');
          } else {
            print('$percentageVal is less than 90');
          }
          update();
        }) ??
        client.published?.listen((MqttPublishMessage message) {
          print(
              'Published notification:: topic is ${message.variableHeader!.topicName}, with Qos ${message.header!.qos}');
        }) ??
        1;
    return;
  }

//------------------------------------------------------------------------------

  void mqttSubscribe() {
    // Subscribe to GsmClientTest/ledStatus
    print('Subscribing to the $subTopic topic');
    client.subscribe(subTopic, MqttQos.atMostOnce);
  }

  void mqttPublish(String msg) {
    builder.clear();
    builder.addString(msg);

    // Publish it
    print('Publishing message: $msg');
    client.publishMessage(pubTopic, MqttQos.atMostOnce, builder.payload!);
  }

  void mqttUnsubscribe() {
    client.unsubscribe(subTopic);
  }

  void mqttDisconnect() {
    client.disconnect();
  }

//******************************************************************************/

  void onConnected() {
    print('Connected');
  }

// unconnected
  void onDisconnected() {
    print('Disconnected');
  }

// subscribe to topic succeeded
  void onSubscribed(String subTopic) {
    print('Subscribed topic: $subTopic');
  }

// subscribe to topic failed
  void onSubscribeFail(String subTopic) {
    print('Failed to subscribe $subTopic');
  }

// unsubscribe succeeded
  void onUnsubscribed(String subTopic) {
    print('Unsubscribed topic: $subTopic');
  }

// PING response received
  void pong() {
    print('Ping response client callback invoked');
  }

  /// The pre auto re connect callback
  void onAutoReconnect() {
    print(
        ' onAutoReconnect client callback - Client auto reconnection sequence will start');
  }

  /// The post auto re connect callback
  void onAutoReconnected() {
    print(
        ' onAutoReconnected client callback - Client auto reconnection sequence has completed');
  }
}
