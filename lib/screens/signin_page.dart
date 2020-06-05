import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tic_tac_toe/screens/online_selection.dart';

import 'signup_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String password;
  String email;
  bool hidePassword = true;
  bool validate = true;
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topCenter, colors: [
          Colors.orange[800],
          Colors.orange[600],
          Colors.orange[400],
        ])),
        child: loading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: <Widget>[
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Text(
                      "Login",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          letterSpacing: 1.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(60),
                              topRight: Radius.circular(60))),
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.all(30),
                          child: Column(
                            children: <Widget>[
                              SizedBox(height: 30),
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.white70,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                          color:
                                              Color.fromRGBO(225, 95, 27, .3),
                                          blurRadius: 20,
                                          offset: Offset(0, 10))
                                    ]),
                                child: Form(
                                  key: _formKey,
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            border: Border(
                                                bottom: BorderSide(
                                                    color: Colors.grey[300]))),
                                        child: TextFormField(
                                          onChanged: (value) {
                                            email = value;
                                          },
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          validator: (value) {
                                            return (value.isEmpty ||
                                                    !value.contains('@') ||
                                                    !value.contains('.'))
                                                ? 'Invalid Email'
                                                : null;
                                          },
                                          decoration: InputDecoration(
                                            hintText: "Email",
                                            hintStyle: TextStyle(
                                                color: Colors.grey,
                                                letterSpacing: 1.0),
                                            border: InputBorder.none,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            border: Border(
                                                bottom: BorderSide(
                                                    color: Colors.grey[200]))),
                                        child: TextFormField(
                                          onChanged: (value) {
                                            password = value;
                                          },
                                          validator: (value) {
                                            return (value.isEmpty ||
                                                    value.length < 6)
                                                ? 'Invalid Password'
                                                : null;
                                          },
                                          style: TextStyle(letterSpacing: 1.5),
                                          obscureText: hidePassword,
                                          decoration: InputDecoration(
                                              hintText: "Password",
                                              suffixIcon: IconButton(
                                                icon: Icon(Icons.remove_red_eye,
                                                    color: Colors
                                                        .deepOrangeAccent),
                                                onPressed: () {
                                                  setState(() {
                                                    if (hidePassword)
                                                      hidePassword = false;
                                                    else
                                                      hidePassword = true;
                                                  });
                                                },
                                              ),
                                              hintStyle: TextStyle(
                                                  color: Colors.grey,
                                                  letterSpacing: 1.0),
                                              border: InputBorder.none),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 40,
                              ),
                              Text(
                                "Forgot Password?",
                                style: TextStyle(
                                    color: Colors.grey,
                                    letterSpacing: 1.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 30),
                              Container(
                                height: 50,
                                margin: EdgeInsets.symmetric(horizontal: 50),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: Colors.orange[700]),
                                child: Center(
                                  child: FlatButton(
                                      onPressed: () {
                                        if (_formKey.currentState.validate()) {
                                          signIn();
                                        }
                                      },
                                      child: Text(
                                        "Login",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                            letterSpacing: 1.0),
                                      )),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              FlatButton(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SignUpPage()),
                                  );
                                },
                                child: Text(
                                  "Don't have An Account? SignUp here!",
                                  style: TextStyle(
                                      color: Colors.grey,
                                      letterSpacing: 1.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                "OR Continue with",
                                style: TextStyle(
                                    color: Colors.grey,
                                    letterSpacing: 1.0,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14.0),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Container(
                                      height: 50,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          color: Colors.blue),
                                      child: Center(
                                        child: Text(
                                          "Google",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 30),
                                  Expanded(
                                    child: Container(
                                      height: 50,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          color: Colors.black),
                                      child: Center(
                                        child: Text(
                                          "Github",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
      ),
    );
  }

  void signIn() async {
    FirebaseAuth _auth = FirebaseAuth.instance;

    setState(() {
      loading = true;
    });

    try {
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) => print(value.user.uid));
      Navigator.push(context, MaterialPageRoute(builder: (_) {
        return OnlineSelection();
      }));
    } catch (e) {
      setState(() {
        loading = false;
      });
      print(e.toString());

    }
  }
}
