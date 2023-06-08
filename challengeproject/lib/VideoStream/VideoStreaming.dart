import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'dart:convert';

import 'globals.dart' as globals;

import 'package:challengeproject/VideoStream/websocket.dart';
import 'package:challengeproject/constant.dart';

import 'package:flutter/material.dart';

class VideoStream extends StatelessWidget {
  final String cameraData;
   VideoStream({
    Key? key,
    required this.cameraData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Image.memory(
        Uint8List.fromList(
          base64Decode(
            cameraData,
          ),
        ),
        gaplessPlayback: true,
        excludeFromSemantics: true,
      ),
      // SingleChildScrollView(
      //   child: Padding(
      //     padding: const EdgeInsets.all(10.0),
      //     child: Center(
      //       child: Column(
      //         children: [
      //           Row(
      //             mainAxisAlignment: MainAxisAlignment.center,
      //             children: [
      //               OutlinedButton(
      //                 onPressed: () => connect(context),
      //                 child: const Text("Connect"),
      //               ),
      //             ],
      //           ),
      //           _isConnected
      //               ? StreamBuilder(
      //                   stream: _socket.stream,
      //                   builder: (context, snapshot) {
      //                     if (!snapshot.hasData) {
      //                       return const CircularProgressIndicator();
      //                     }

      //                     final allData = json.decode(snapshot.data);
      //                     final cameraData = allData['camera'].toString();
      //                     //final number = allData['random1'];

      //                     widget.socketCallBack(allData);
      //                     print(allData);
      //                     //final allData = snapshot.data;
      //                     //globals.random = allData['random1'];
      //                     //print(random);
      //                     return ;
      //                   },
      //                 )
      //               : Text("")
      //         ],
      //       ),
      //     ),
      //   ),
      // ),
    );
  }
}
