// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterloginui/services/auth.dart';
import 'package:flutterloginui/shareds/constants.dart';
import 'package:flutterloginui/shareds/loading.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  //text field state
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            // backgroundColor: Colors.white[100],
            appBar: AppBar(
              backgroundColor: Color(0xFF5AC035),
              elevation: 0.0,
              title: Text('Zodongo Foods'),
              actions: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FlatButton.icon(
                    onPressed: () async {
                      widget.toggleView();
                    },
                    textColor: Colors.white,
                    icon: Icon(Icons.person_add),
                    label: Text('New User'),
                    color: Colors.green,
                  ),
                )
              ],
            ),
            body: AnimatedContainer(
              curve: Curves.fastLinearToSlowEaseIn,
              duration: Duration(milliseconds: 1000),
              child: Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
                  child: Form(
                    key: _formKey,
                    child: ListView(
                      children: <Widget>[
                        SizedBox(height: 10.0),
                        AnimatedContainer(
                          curve: Curves.fastLinearToSlowEaseIn,
                          duration: Duration(milliseconds: 1000),
                          padding: EdgeInsets.symmetric(horizontal: 50),
                          child: Center(
                            child:
                                Image.asset("assets/images/zodongologo.jpeg"),
                          ),
                        ),
                        SizedBox(height: 20.0),
                        Container(
                          child: Center(
                            child: Text(
                              'Sign In to Continue / Create an Account',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Montserrat'),
                            ),
                          ),
                        ),
                        SizedBox(height: 10.0),
                        Container(
                          child: Center(
                            child: Text(error,
                                style: TextStyle(
                                    color: Colors.red, fontSize: 14.0)),
                          ),
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                              labelText: 'EMAIL',
                              labelStyle: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.green))),
                          validator: (val) =>
                              val.isEmpty ? 'Enter an Email' : null,
                          onChanged: (val) {
                            setState(() => email = val.trim());
                          },
                        ),
                        SizedBox(height: 20.0),
                        TextFormField(
                          decoration: InputDecoration(
                              labelText: 'PASSWORD',
                              labelStyle: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.green))),
                          obscureText: true,
                          validator: (val) => val.length < 6
                              ? 'Enter a password 6+ chars long'
                              : null,
                          onChanged: (val) {
                            setState(() => password = val.trim());
                          },
                        ),
                        SizedBox(height: 20.0),
                        Column(
                          children: <Widget>[
                            GestureDetector(
                              onTap: () async {
                                if (_formKey.currentState.validate()) {
                                  setState(() => loading = true);

                                  dynamic result =
                                      await _auth.signInWithEmailAndPassword(
                                          email, password);

                                  if (result == null) {
                                    setState(() {
                                      error =
                                          'sign in failed with those credentials, check your network connection';
                                      loading = false;
                                    });
                                  }
                                }
                              },
                              child: PrimaryButton(
                                btnText: "Sign In",
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            GestureDetector(
                              onTap: () async {
                                widget.toggleView();
                              },
                              child: OutlineBtn(
                                btnText: "Create Account",
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  )),
            ),
          );
  }
}

class PrimaryButton extends StatefulWidget {
  final String btnText;
  PrimaryButton({this.btnText});

  @override
  _PrimaryButtonState createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFF5AC035),
        borderRadius: BorderRadius.circular(50),
      ),
      padding: EdgeInsets.all(10),
      child: Center(
        child: Text(
          widget.btnText,
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }
}

class OutlineBtn extends StatefulWidget {
  final String btnText;
  OutlineBtn({this.btnText});

  @override
  _OutlineBtnState createState() => _OutlineBtnState();
}

class _OutlineBtnState extends State<OutlineBtn> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Color(0xFF5AC035)),
          borderRadius: BorderRadius.circular(50)),
      padding: EdgeInsets.all(10),
      child: Center(
        child: Text(
          widget.btnText,
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
