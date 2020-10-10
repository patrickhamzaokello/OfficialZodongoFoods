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
              backgroundColor: Colors.green[400],
              elevation: 0.0,
              title: Text('Zodongo Foods'),
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
                        SizedBox(height: 20.0),
                        Container(
                          child: Center(
                            child:
                                Image.asset("assets/images/zodongologo.jpeg"),
                          ),
                        ),
                        AnimatedContainer(
                          curve: Curves.fastLinearToSlowEaseIn,
                          duration: Duration(milliseconds: 1000),
                          padding: EdgeInsets.symmetric(vertical: 20),
                          child: Text(
                            "Sign In to Continue",
                            style: TextStyle(
                                color: Colors.grey[400], fontSize: 20),
                          ),
                        ),
                        TextFormField(
                          decoration: textInputDecoration.copyWith(
                              hintText: 'Email',
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10)),
                          validator: (val) =>
                              val.isEmpty ? 'Enter an Email' : null,
                          onChanged: (val) {
                            setState(() => email = val);
                          },
                        ),
                        SizedBox(height: 20.0),
                        TextFormField(
                          decoration: textInputDecoration.copyWith(
                              hintText: 'Password',
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10)),
                          obscureText: true,
                          validator: (val) => val.length < 6
                              ? 'Enter a password 6+ chars long'
                              : null,
                          onChanged: (val) {
                            setState(() => password = val);
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
                                          'could not sign in with those credentials';
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
                        // RaisedButton(
                        //   color: Colors.pink[400],
                        //   child: Text(
                        //     'Sign In',
                        //     style: TextStyle(color: Colors.white),
                        //   ),
                        //   onPressed: () async {
                        //     if (_formKey.currentState.validate()) {
                        //       setState(() => loading = true);

                        //       dynamic result = await _auth
                        //           .signInWithEmailAndPassword(email, password);

                        //       if (result == null) {
                        //         setState(() {
                        //           error =
                        //               'could not sign in with those credentials';
                        //           loading = false;
                        //         });
                        //       }
                        //     }
                        //   },
                        // ),
                        SizedBox(height: 12.0),
                        Text(
                          error,
                          style: TextStyle(color: Colors.red, fontSize: 14.0),
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
          border: Border.all(color: Color(0xFF5AC035), width: 2),
          borderRadius: BorderRadius.circular(50)),
      padding: EdgeInsets.all(10),
      child: Center(
        child: Text(
          widget.btnText,
          style: TextStyle(color: Color(0xFFB40284A), fontSize: 16),
        ),
      ),
    );
  }
}
