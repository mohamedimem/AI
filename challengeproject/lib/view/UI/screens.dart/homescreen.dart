import 'dart:convert';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:challengeproject/constant.dart';
import 'package:challengeproject/spacing_extension.dart';
import 'package:challengeproject/view/UI/widgets/contact_header.dart';
import 'package:challengeproject/view/UI/widgets/home_body.dart';
import 'package:challengeproject/view/UI/widgets/home_header.dart';
import 'package:challengeproject/VideoStream/websocket.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final WebSocket _socket = WebSocket(Constants.videoWebsocketURL);

  bool _isConnected = false;

  void connect() {
    _socket.connect();
    setState(() {
      _isConnected = true;
    });
  }

  void disconnect() {
    _socket.disconnect();
    setState(() {
      _isConnected = false;
    });
  }

  bool isShowCamera = false;
  List<CameraDescription>? _cameras;

  @override
  void initState() {
    connect();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    print("_cameras: ${_cameras?.length}");

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: StreamBuilder<dynamic>(
        stream: _socket.stream,
        builder: (context, snapshot) {
          print("snapshot: $snapshot");

          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final allData = json.decode(snapshot.data.toString());
          final cameraData = allData['camera'].toString();

          final value3 = allData['peaks_total']?.toString() ?? "0";
          final value = allData['count_jonglage'].toString();
          final value1 = allData['peaks_total Tete']?.toString() ?? "0";
          final value2 = allData['peaks_total genaux']?.toString() ?? "0";

          return SingleChildScrollView(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    "assets/images/Background.png",
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              child: SafeArea(
                child: Column(
                  children: [
                    HomeHeader(
                      number3: value3,
                    ),
                    //  SizedBox(height: 33),
                    Expanded(
                      flex: 5,
                      child: HomeBody(
                        number: value,
                        number1: value2,
                        number2: value1,
                        cameraData: cameraData,
                      ),
                    ),
                    // const SizedBox(height: 30),
                    Contact(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
