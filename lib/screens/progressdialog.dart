
/*
import 'package:flutter/material.dart';

class ProgressDialog extends StatefulWidget {
  @override
  _ProgressDialogState createState() => _ProgressDialogState();
}

class _ProgressDialogState extends State<ProgressDialog> {
  double _progressValue = 0.0;
  String _progressText = "Starting...";

  void _updateProgress() {
    setState(() {
      _progressValue += 0.25;
      switch ((_progressValue * 4).toInt()) {
        case 0:
          _progressText = "Starting...";
          break;
        case 1:
          _progressText = "Loading... 25%";
          break;
        case 2:
          _progressText = "Loading... 50%";
          break;
        case 3:
          _progressText = "Loading... 75%";
          break;
        case 4:
          _progressText = "Loading... 100%";
          Navigator.of(context).pop();
          break;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _updateProgress();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        height: 120,
        width: 200,
        child: Column(
          children: [
            LinearProgressIndicator(
              value: _progressValue,
            ),
            SizedBox(
              height: 20,
            ),
            Text(_progressText),
          ],
        ),
      ),
    );
  }
}
*/