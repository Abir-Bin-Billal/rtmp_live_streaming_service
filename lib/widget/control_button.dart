import 'package:flutter/material.dart';

import '../services/streaming_controller.dart';

class ControlButtons extends StatelessWidget {
  final bool isStreaming;
  final VoidCallback onStart;
  final VoidCallback onStop;
  final StreamingController streamingController;

  const ControlButtons({
    super.key,
    required this.isStreaming,
    required this.onStart,
    required this.onStop,
    required this.streamingController,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        CustomButton(
          text: isStreaming ? 'Stop' : 'Start',
          onPressed: isStreaming ? onStop : onStart,
          color: isStreaming ? Colors.red : Colors.green,
        ),
        CustomButton(
          text: 'Switch Camera',
          onPressed: streamingController.switchCamera,
          color: Colors.blue,
        ),
      ],
    );
  }
  Widget CustomButton({required String text, required VoidCallback onPressed, required Color color}) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
