import 'package:apivideo_live_stream/apivideo_live_stream.dart';
import 'package:flutter/material.dart';
import 'package:rtmp_streaming_service/services/streaming_controller.dart';
import 'package:rtmp_streaming_service/widget/control_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final StreamingController _streamingController;
  final TextEditingController _streamKeyController = TextEditingController();
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeController();
  }

  @override
  void dispose() {
    super.dispose();
    _streamingController.controller?.dispose();
  }

  Future<void> _initializeController() async {
    _streamingController = StreamingController();
    await _streamingController.initialize();
    setState(() {
      _isInitialized = true;
    });
  }

  void _startStreaming() async {
    await _streamingController.startStreaming(_streamKeyController.text);
    setState(() {});
  }

  void _stopStreaming() async {
    await _streamingController.stopStreaming();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("App Preview"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextFormField(
            controller: _streamKeyController,
            decoration: const InputDecoration(
              icon: Icon(Icons.videocam),
              labelText: 'Stream Key',
              hintText: 'Enter Stream Key',
            ),
          ),
          SizedBox(height: 30,),
          Container(
            height: 300,
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            child: _streamingController.controller != null
                ? ApiVideoCameraPreview(
                    controller: _streamingController.controller!)
                : const CircularProgressIndicator(),
          ),
          ControlButtons(
            isStreaming: _streamingController.isStreaming,
            onStart: _startStreaming,
            onStop: _stopStreaming,
            streamingController: _streamingController, // Pass the controller here
          ),
        ],
      ),
    );
  }
}
