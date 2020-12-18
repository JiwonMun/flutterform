import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hellokhu/utility.dart';
import 'package:path_provider/path_provider.dart';
import 'loginpage.dart';
import 'package:hellokhu/detailpage.dart';
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'name.dart';
import 'revise.dart';
import 'homepage.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'First My Page',
      home: FirstMyPage(storage: FirstStorage()),
    ),
  );
}

class FirstMyPage extends StatefulWidget {
  final FirstStorage storage;

  FirstMyPage({Key key, @required this.storage}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class FirstStorage {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  // new file
  Future<File> get _namelocalFile async {
    final path = await _localPath;
    return File('$path/text.txt');
  }

  // read file
  Future<String> namereadFile() async {
    try {
      final file = await _namelocalFile;

      String content = await file.readAsString();
      return content;
    } catch (e) {
      return '';
    }
  }

  // new file
  Future<File> get _emaillocalFile async {
    final path = await _localPath;
    return File('$path/email.txt');
  }

  // read file
  Future<String> emailreadFile() async {
    try {
      final file = await _emaillocalFile;

      String content = await file.readAsString();
      return content;
    } catch (e) {
      return '';
    }
  }

  // new file
  Future<File> get _passwordlocalFile async {
    final path = await _localPath;
    return File('$path/password.txt');
  }

  // read file
  Future<String> passwordreadFile() async {
    try {
      final file = await _passwordlocalFile;

      String content = await file.readAsString();
      return content;
    } catch (e) {
      return '';
    }
  }
}

class _MyAppState extends State<FirstMyPage> {
  String _textcontent = '';
  String _emailcontent = '';
  String _passwordcontent = '';

  Widget _backButton() {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 0, top: 10, bottom: 10),
              child: Icon(Icons.keyboard_arrow_left, color: Colors.black),
            ),
            Text('Back',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500))
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    widget.storage.namereadFile().then((String text) {
      setState(() {
        _textcontent = text;
      });
    });
    widget.storage.emailreadFile().then((String text) {
      setState(() {
        _emailcontent = text;
      });
    });

    widget.storage.passwordreadFile().then((String text) {
      setState(() {
        _passwordcontent = text;
      });
    });
  }

  Widget _UserField(String title) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          Center(
            child: Text(
              '$_textcontent',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _EmailField(String title) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          Center(
            child: Text(
              '$_emailcontent',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _PasswordField(String title) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          Center(
            child: Text(
              '$_passwordcontent',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _submitButton() {
    return Container(
      width: double.infinity,
      child: RaisedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => RevisePage(
                      storage: ReviseStorage(),
                    )),
          );
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        color: Colors.indigo[500],
        child: Text(
          'Revise Information',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }

  Widget _moveButton() {
    return Container(
      width: double.infinity,
      child: RaisedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
          );
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        color: Colors.indigo[500],
        child: Text(
          'Go HomePage',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        horizontal: 40.0,
      ),
      child: Column(
        children: [
          SizedBox(height: 130.0),
          Positioned(top: 40, left: 0, child: _backButton()),
          SizedBox(height: 110.0),
          _UserField("Name"),
          SizedBox(height: 90.0),
          _EmailField("Email id"),
          SizedBox(height: 70.0),
          _PasswordField("Password"),
          SizedBox(height: 30.0),
          _submitButton(),
          _moveButton(),
        ],
      ),
    ));
  }
}
