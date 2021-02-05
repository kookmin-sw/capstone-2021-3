import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraScreen extends StatefulWidget {
  final CameraDescription camera;

  const CameraScreen({Key key, @required this.camera}) : super(key: key);

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController _controller;
  Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(
        widget.camera,
        // 화질 선택.
        ResolutionPreset.medium);

    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    // Dispose 할때 camera controller도 dispose 같이 해줌.
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("분리 배출의 민족")),
        // Camera controller가 initialize 될때까지 기다림.
        body: FutureBuilder<void>(
            future: _initializeControllerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                // Future가 완료되면 화면에 preview 보여줌.
                return CameraPreview(_controller);
              } else {
                // TODO(민호): 현재 카메라 준비 기다릴동안 loading spinner 보여주는데,
                // 다른 방법으로 해결하기. (e.g. 로고를 보여준다던가...)
                return Center(child: CircularProgressIndicator());
              }
            }));
  }
}
