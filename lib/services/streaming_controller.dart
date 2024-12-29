import 'package:apivideo_live_stream/apivideo_live_stream.dart';
import 'package:flutter/services.dart';

class StreamingController {
  late final ApiVideoLiveStreamController _controller;
  bool isStreaming = false;

  Future<void> initialize() async {
    _controller = ApiVideoLiveStreamController(
      initialAudioConfig: AudioConfig(),
      initialVideoConfig: VideoConfig.withDefaultBitrate(),
      onConnectionSuccess: () {
        print('Connection succeeded');
      },
      onConnectionFailed: (error) {
        print('Connection failed: $error');
      },
      onDisconnection: () {
        print('Disconnected');
      },
    );
    await _controller.initialize().catchError((e) {
      print('Failed to initialize controller: $e');
    });
  }

  Future<void> startStreaming(String streamKey) async {
    try {
      await _controller.startStreaming(
        url: 'rtmp://a.rtmp.youtube.com/live2',
        streamKey: streamKey,
      );
      isStreaming = true;
      print("Stream started successfully");
    } catch (error) {
      print("Error: failed to start stream: $error");
      if (error is PlatformException) {
        print("PlatformException details: ${error.details}");
      }
      isStreaming = false;
    }
  }
  Future<void> stopStreaming() async {
    await _controller.stopStreaming();
    isStreaming = false;
  }

 Future<void> switchCamera() async {
  if (_controller.isInitialized) {
    try {
      if (isStreaming) {
        await stopStreaming(); // Stop streaming if active
      }
      await _controller.switchCamera();
      print('Camera switched successfully');
    } catch (e) {
      print('Error switching camera: $e');
    }
  } else {
    print('Camera controller is not initialized.');
  }
}

ApiVideoLiveStreamController? get controller => _controller.isInitialized ? _controller : null;
}
