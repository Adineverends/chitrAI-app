
/*
import 'package:flutter/material.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _text = '';
  bool _isSubmitEnabled = false;
  String? _selectedStyle;

  void _handleTextChange(String text) {
    setState(() {
      _text = text;
      _isSubmitEnabled = text.isNotEmpty;
    });
  }

  void _submitHandler() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => StylePage()),
    );
    setState(() {
      _selectedStyle = result;
    });
  }

  void _showResult() {
    if (_selectedStyle == null) {
      return;
    }
    final result = 'You have selected $_selectedStyle with text: $_text';
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text(result),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Style Selector App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Enter some text',
              ),
              onChanged: _handleTextChange,
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              child: Text('choose Style'),
              onPressed: _isSubmitEnabled ? _submitHandler : null,
            ),
            SizedBox(height: 16.0),
            if (_selectedStyle != null) Text('Selected style: $_selectedStyle'),
            if (_selectedStyle != null) SizedBox(height: 16.0),
            if (_isSubmitEnabled && _selectedStyle != null)
              ElevatedButton(
                child: Text('Show Result'),
                onPressed: _showResult,
              ),
          ],
        ),
      ),
    );
  }
}

class StylePage extends StatelessWidget {
  final List<String> _styles = [
    'Style 1',
    'Style 2',
    'Style 3',
    'Style 4',
    'Style 5',
    'Style 6',
    'Style 7',
    'Style 8',
    'Style 9',
    'Style 10',
  ];

  void _styleSelectedHandler(BuildContext context, String style) {
    Navigator.pop(context, style);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select a Style'),
      ),
      body: ListView.builder(
        itemCount: _styles.length,
        itemBuilder: (context, index) {
          final style = _styles[index];
          return ListTile(
            title: Text(style),
            onTap: () {
              _styleSelectedHandler(context, style);
            },
          );
        },
      ),
    );
  }
}

*/


// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.


// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// to translate
/*
import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;


class TranslateApp extends StatefulWidget {
  @override
  _TranslateAppState createState() => _TranslateAppState();
}

class _TranslateAppState extends State<TranslateApp> {
  String _inputText = '';
  String _translatedText = '';
  String _targetLanguage = 'en'; // default to English

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ChatGPT Translator'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            onChanged: (text) => setState(() => _inputText = text),
            decoration: InputDecoration(
              hintText: 'Enter text to translate',
            ),
          ),
          SizedBox(height: 20),
          DropdownButton(
            value: _targetLanguage,
            onChanged: (value) => setState(() => _targetLanguage = value as String),
            items: [
              DropdownMenuItem(child: Text('English'), value: 'en'),
              DropdownMenuItem(child: Text('Spanish'), value: 'es'),
              DropdownMenuItem(child: Text('French'), value: 'fr'),
              DropdownMenuItem(child: Text('German'), value: 'de'),
              DropdownMenuItem(child: Text('Italian'), value: 'it'),
              DropdownMenuItem(child: Text('Portuguese'), value: 'pt'),
              DropdownMenuItem(child: Text('Russian'), value: 'ru'),
              DropdownMenuItem(child: Text('Chinese (Simplified)'), value: 'zh-cn'),
              DropdownMenuItem(child: Text('Japanese'), value: 'ja'),
              DropdownMenuItem(child: Text('Korean'), value: 'ko'),
            ],
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: _onTranslatePressed,
            child: Text('Translate'),
          ),
          SizedBox(height: 20),
          Expanded(
              
              child: SingleChildScrollView(child: Text(_translatedText))),
        ],
      ),
    );
  }

  void _onTranslatePressed() async {
    if (_inputText.isNotEmpty) {
      final apiKey = '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';
      final endpoint = 'https://api.chatgpt.com/translate';
      final response = await http.post(Uri.parse(endpoint), headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey',
      }, body: {
        'text': _inputText,
        'to': _targetLanguage,
      });
      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        if (responseBody['status'] == 'success') {
          final translatedText = responseBody['translation'] as String;
          print('Translated text: $translatedText');
          setState(() => _translatedText = translatedText);
        } else {
          print('Translation failed: ${responseBody['message']}');
        }
      } else {
        print('Translation API request failed with status code ${response.statusCode}');
      }
    }
  }

}
*/

/*
import 'dart:convert';
import 'package:chitrai/api_consts.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class QuestionScreen extends StatefulWidget {
  @override
  _QuestionScreenState createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  final TextEditingController _textEditingController = TextEditingController();
  String ? _answer ;
  String apikey = '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';
  String url = 'https://api.openai.com/v1';

  void _getAnswer() async {

    var response = await http.post(
      Uri.parse("$BASE_URL/completions"),
      headers: {
        'Authorization': 'Bearer $API_KEY',
        "Content-Type": "application/json"
      },
      body: jsonEncode(
        {
          "model": "text-davinci-003",
          "prompt": _textEditingController.text,
          "max_tokens": 300,
          "temperature": 0.9,
          "max_tokens": 150,
          "top_p": 1,
          "frequency_penalty": 0.0,
          "presence_penalty": 0.6,
          "stop": [" Human:", " AI:"]
        },
      ),
    );

    Map jsonResponse = jsonDecode(response.body);


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Ask a Question')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _textEditingController,
              decoration: InputDecoration(
                labelText: 'Enter your question',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: ()  {


                setState(() {
//print(_answer);
                 _getAnswer();

                });
              },
              child: Text('Submit'),
            ),
            SizedBox(height: 16),
            _answer==null?Text('enter text'):

            Text(

              _answer!,
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
*/


// REELS DOWNLOADER
/*

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class ReelsDownloader extends StatefulWidget {
  const ReelsDownloader({Key? key}) : super(key: key);

  @override
  _ReelsDownloaderState createState() => _ReelsDownloaderState();
}

class _ReelsDownloaderState extends State<ReelsDownloader> {
  final TextEditingController _urlController = TextEditingController();
  final TextEditingController _fileNameController = TextEditingController();
  bool _downloading = false;
  String? _downloadStatus;


  Future<void> _downloadReel() async {
    setState(() {
      _downloading = true;
      _downloadStatus = null;
    });

    // Request file system permission.
    if (await Permission.storage.request().isGranted) {
      try {
        var response = await http.get(Uri.parse(_urlController.text.trim()));
        var externalStorageDirectory = await getExternalStorageDirectory();
        var reelsDirectory = Directory('${externalStorageDirectory?.path}/My Reels');
        await reelsDirectory.create(recursive: true);
        var file = File('${reelsDirectory.path}/${_fileNameController.text.trim()}');
        await file.writeAsBytes(response.bodyBytes);

        setState(() {
          _downloading = false;
          _downloadStatus = 'Download successful!';
        });
      } catch (e) {
        setState(() {
          _downloading = false;
          _downloadStatus = 'Download failed: $e';
        });
      }
    } else {
      setState(() {
        _downloading = false;
        _downloadStatus = 'Permission denied to save file';
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reels Downloader'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _urlController,
              decoration: const InputDecoration(
                labelText: 'Reels URL',
              ),
            ),
            TextField(
              controller: _fileNameController,
              decoration: const InputDecoration(
                labelText: 'File Name',
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _downloading ? null : _downloadReel,
              child: Text(_downloading ? 'Downloading...' : 'Download'),
            ),
            if (_downloadStatus != null)
              Text(
                _downloadStatus!,
                style: TextStyle(
                  color: _downloadStatus!.startsWith('Download failed')
                      ? Colors.red
                      : Colors.green,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

//



 */

//scrollX
/*
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:fluttertoast/fluttertoast.dart';



class ReelTimerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Reel Timer',
      home: ReelTimer(),
    );
  }
}

class ReelTimer extends StatefulWidget {
  @override
  _ReelTimerState createState() => _ReelTimerState();
}

class _ReelTimerState extends State<ReelTimer> {
  bool _blockScreen = false;
  int _timeLimit = 5; // in minutes
  Timer ? _timer;

  void startTimer() {
    const oneMinute = Duration(minutes: 1);
    var duration = Duration(minutes: _timeLimit);
    _timer = Timer.periodic(oneMinute, (timer) {
      if (duration.inSeconds <= 0) {
        _timer!.cancel();
        showStopDialog();
      } else {
        duration -= oneMinute;
      }
    });
  }

  void showStopDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Time\'s up!'),
          content: Text('Stop watching reels and do your work.'),
          actions: <Widget>[
            ElevatedButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void stopTimer() {
    if (_timer != null) {
      _timer!.cancel();
    }
  }

  @override
  void dispose() {
    stopTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reel Timer'),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Time limit (minutes):'),
            SizedBox(height: 8.0),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter time limit',
              ),
              onChanged: (value) {
                setState(() {
                  _timeLimit = int.tryParse(value) ?? 0;
                });
              },
            ),
            SizedBox(height: 16.0),
            Text('Block screen:'),
            Switch(
              value: _blockScreen,
              onChanged: (value) {
                setState(() {
                  _blockScreen = value;
                });
              },
            ),
            SizedBox(height: 16.0),
            Row(
              children: <Widget>[
                ElevatedButton(
                  child: Text('Start'),
                  onPressed: () {
                    startTimer();


                    Fluttertoast.showToast(
                        msg: "Timer started!",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 3,
                        backgroundColor: Colors.black,
                        textColor: Colors.white,
                        fontSize: 16.0
                    );
                  },
                ),
                SizedBox(width: 8.0),
                ElevatedButton(
                  child: Text('Stop'),
                  onPressed: () {
                    stopTimer();
                    Fluttertoast.showToast(
                        msg: "Stop",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 3,
                        backgroundColor: Colors.black,
                        textColor: Colors.white,
                        fontSize: 16.0
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

*/

import 'package:flutter/material.dart';

class WhatsAppHomeScreen extends StatefulWidget {
  @override
  _WhatsAppHomeScreenState createState() => _WhatsAppHomeScreenState();
}

class _WhatsAppHomeScreenState extends State<WhatsAppHomeScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WhatsApp'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: PageView(
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        children: [
          ChatListPage(),
          StatusPage(),
          CallsPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Chats',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.camera_alt),
            label: 'Status',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.call),
            label: 'Calls',
          ),
        ],
      ),
    );
  }
}

class ChatListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Chats'),
    );
  }
}

class StatusPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Status'),
    );
  }
}

class CallsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Calls'),
    );
  }
}
