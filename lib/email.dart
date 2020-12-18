import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'password.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Sign up - Email',
      home: MyEmail(storage: EmailStorage()),
    ),
  );
}

// file path
class EmailStorage {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  // new file
  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/email.txt');
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

class MyEmail extends StatefulWidget {
  final EmailStorage storage;

  MyEmail({Key key, @required this.storage}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyEmail> {
  TextEditingController _emailController = new TextEditingController();

  String _emailcontent = '';

  @override
  void initState() {
    super.initState();
    widget.storage.readFile().then((String text) {
      setState(() {
        _emailcontent = text;
      });
    });
  }

  Future<File> _writeStringToTextFile(String text) async {
    setState(() {
      _emailcontent += text + '\r\n';
    });

    return widget.storage.writeFile(text);
  }

  Future<File> _clearContentsInTextFile() async {
    setState(() {
      _emailcontent = '';
    });

    return widget.storage.cleanFile();
  }

  Widget buildEmail() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Email"),
        SizedBox(height: 10.0),
        Container(
          height: 60.0,
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              color: Colors.indigo[500],
              borderRadius: BorderRadius.circular(10.0)),
          child: TextField(
            controller: _emailController,
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.email,
                color: Colors.white,
              ),
              hintText: "Enter Email",
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
        title: Text('Enter Email'),
        backgroundColor: Colors.indigo[500],
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            SizedBox(height: 20.0),
            buildEmail(),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: RaisedButton(
                child: Text('Write to Email'),
                onPressed: () {
                  if (_emailController.text.isNotEmpty) {
                    _writeStringToTextFile(_emailController.text);
                    _emailController.clear();
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
                      builder: (context) =>
                          MyPassword(storage: PasswordStorage()),
                    ),
                  );
                },
              ),
            ),
            Expanded(
              flex: 1,
              child: new SingleChildScrollView(
                child: Text(
                  '"Email" $_emailcontent',
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
