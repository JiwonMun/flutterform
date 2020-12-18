import 'package:flutter/material.dart';
import 'package:hellokhu/revise.dart';
import 'name.dart';
import 'revise.dart';
import 'mypage.dart';

final _formKey = GlobalKey<FormState>();

@override
Widget build(BuildContext context) {
  // Build a Form widget using the _formKey created above.
  return Form(
      key: _formKey,
      child: Column(children: <Widget>[
        // Add TextFormFields and RaisedButton here.
      ]));
}

class LoginPage extends StatefulWidget {
  static String tag = 'login-page';
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isRemember = false;
  final formKey = GlobalKey<FormState>();

  Widget buildMainLogo() {
    return CircleAvatar(
      backgroundColor: Colors.transparent,
      radius: 150.0,
      child: Image.asset('assets/khublue.png'),
    );
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
          child: TextFormField(
            // The validator receives the text that the user has entered.
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
        ),
      ],
    );
  }

  Widget buildPassword() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Password"),
        SizedBox(height: 10.0),
        Container(
          height: 60.0,
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              color: Colors.indigo[500],
              borderRadius: BorderRadius.circular(10.0)),
          child: TextField(
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.lock,
                color: Colors.white,
              ),
              hintText: "Enter your Password",
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }

  Widget buildForgotPass() {
    return Container(
      alignment: Alignment.centerRight,
      child: FlatButton(
        onPressed: () {
          print("pushed button");
        },
        child: Text(
          'Forgot Password?',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }

  Widget buildLoginBtn() {
    return Container(
      width: double.infinity,
      child: RaisedButton(
        onPressed: () {
          Navigator.push(
            context,
            //MaterialPageRoute(builder: (context) => HomePage()),
            MaterialPageRoute(
              builder: (context) => FirstMyPage(storage: FirstStorage()),
            ),
          );
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.indigo[500],
        child: Text(
          'LOGIN',
          style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'OpenSans'),
        ),
      ),
    );
  }

  Widget _createAccountLabel() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MyApp(storage: TextStorage())));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20),
        padding: EdgeInsets.all(15),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Don\'t have an account ?',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Register',
              style: TextStyle(
                  color: Colors.indigo[500],
                  fontSize: 15,
                  fontWeight: FontWeight.w600),
            ),
          ],
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
          SizedBox(height: 100.0),
          buildMainLogo(),
          SizedBox(height: 80.0),
          buildEmail(),
          SizedBox(height: 30.0),
          buildPassword(),
          buildForgotPass(),
          _createAccountLabel(),
          buildLoginBtn(),
        ],
      ),
    ));
  }
}
