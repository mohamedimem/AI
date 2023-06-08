/*import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraScreen extends StatefulWidget {
  final List<CameraDescription> availableCameras ;
  const CameraScreen({super.key,required this.availableCameras,});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  
   CameraController? controller;

Future<void> initCamera()async{
    controller = CameraController(widget.availableCameras[0], ResolutionPreset.max);
    controller?.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            // Handle access errors here.
            break;
          default:
            // Handle other errors here.
            break;
        }
      }
    });
}
  @override
  void initState() {
    initCamera();
    super.initState();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    if(controller == null){
      return const Center(child:  CircularProgressIndicator.adaptive());
      
    }
    if (!controller!.value.isInitialized) {
      return Container();
    }
    return CameraPreview(controller!);
  }
}*/