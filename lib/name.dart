import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hellokhu/email.dart';
import 'package:path_provider/path_provider.dart';

import 'dart:async';
import 'main.dart';
import 'email.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Sign up - Name',
      home: MyApp(storage: TextStorage()),
    ),
  );
}

// file path
class TextStorage {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  // new file
  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/text.txt');
  }

  // read file
  Future<String> readFile() async {
    try {
      final file = await _localFile;

      String content = await file.readAsString();
      return content;
    } catch (e) {
      return '';
    }
  }

  Future<File> writeFile(String text) async {
    final file = await _localFile;
    return file.writeAsString('$text\r\n', mode: FileMode.append);
  }

  Future<File> cleanFile() async {
    final file = await _localFile;
    return file.writeAsString('');
  }
}

class MyApp extends StatefulWidget {
  final TextStorage storage;

  MyApp({Key key, @required this.storage}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TextEditingController _textField = new TextEditingController();

  String _textcontent = '';

  @override
  void initState() {
    super.initState();
    widget.storage.readFile().then((String text) {
      setState(() {
        _textcontent = text;
      });
    });
  }

  Future<File> _writeStringToTextFile(String text) async {
    setState(() {
      _textcontent += text + '\r\n';
    });

    return widget.storage.writeFile(text);
  }

  Future<File> _clearContentsInTextFile() async {
    setState(() {
      _textcontent = '';
    });

    return widget.storage.cleanFile();
  }

  Widget buildName() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Name"),
        SizedBox(height: 10.0),
        Container(
          height: 60.0,
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              color: Colors.indigo[500],
              borderRadius: BorderRadius.circular(10.0)),
          child: TextField(
            controller: _textField,
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.person,
                color: Colors.white,
              ),
              hintText: "Enter Name",
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enter Name'),
        backgroundColor: Colors.indigo[500],
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            SizedBox(height: 20.0),
            buildName(),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: RaisedButton(
                child: Text('Write to Name'),
                onPressed: () {
                  if (_textField.text.isNotEmpty) {
                    _writeStringToTextFile(_textField.text);
                    _textField.clear();
                  }
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 20.0),
              child: RaisedButton(
                child: Text(
                  'Next Step',
                  style: TextStyle(color: Colors.white),
                ),
                color: Colors.redAccent,
                onPressed: () {
                  Navigator.push(
                    context,
                    //MaterialPageRoute(builder: (context) => HomePage()),
                    MaterialPageRoute(
                      builder: (context) => MyEmail(storage: EmailStorage()),
                    ),
                  );
                },
              ),
            ),
            Expanded(
              flex: 1,
              child: new SingleChildScrollView(
                child: Text(
                  '"Name" $_textcontent',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 22.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
