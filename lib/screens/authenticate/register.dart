import 'package:flutter/material.dart';
import 'package:flutterloginui/services/auth.dart';
import 'package:flutterloginui/shareds/constants.dart';
import 'package:flutterloginui/shareds/loading.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  //text field state
  String email = '';
  String password = '';
  String phonenumber = '';
  String fullname = '';

  String error = '';
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            appBar: AppBar(
              backgroundColor: Color(0xFF5AC035),
              elevation: 0.0,
              title: Text('Create Account'),
              actions: <Widget>[
                FlatButton.icon(
                    onPressed: () async {
                      widget.toggleView();
                    },
                    icon: Icon(Icons.person),
                    // color: Colors.white,
                    label: Text('Sign In'))
              ],
            ),
            body: AnimatedContainer(
              curve: Curves.fastLinearToSlowEaseIn,
              duration: Duration(milliseconds: 1000),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
                child: Form(
                  key: _formKey,
                  child: ListView(
                    children: <Widget>[
                      SizedBox(height: 20.0),
                      AnimatedContainer(
                        curve: Curves.fastLinearToSlowEaseIn,
                        duration: Duration(milliseconds: 1000),
                        child: Text(
                          "Zodongo Foods",
                          style: TextStyle(color: Colors.black, fontSize: 35.0),
                        ),
                      ),
                      AnimatedContainer(
                        curve: Curves.fastLinearToSlowEaseIn,
                        duration: Duration(milliseconds: 1000),
                        child: Text(
                          "Create an Account to Order Now!",
                          style: TextStyle(color: Colors.black, fontSize: 20.0),
                        ),
                      ),
                      SizedBox(height: 20.0),
                      Text(
                        error,
                        style: TextStyle(color: Colors.red, fontSize: 14.0),
                      ),
                      SizedBox(height: 20.0),
                      TextFormField(
                        decoration: textInputDecoration.copyWith(
                          hintText: 'Full Name',
                          labelText: 'Full Name:',
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                        ),
                        validator: (val) =>
                            val.isEmpty ? 'Enter Full Name' : null,
                        onChanged: (val) {
                          setState(() => fullname = val.trim());
                        },
                      ),
                      SizedBox(height: 20.0),
                      TextFormField(
                        decoration: textInputDecoration.copyWith(
                          hintText: 'Phone',
                          labelText: 'Phone Number:',
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                        ),
                        validator: (val) =>
                            val.isEmpty ? 'Enter Phone Number' : null,
                        onChanged: (val) {
                          setState(() => phonenumber = val.trim());
                        },
                      ),
                      SizedBox(height: 20.0),
                      TextFormField(
                        decoration: textInputDecoration.copyWith(
                          hintText: 'Email',
                          labelText: 'Email:',
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                        ),
                        validator: (val) =>
                            val.isEmpty ? 'Enter an Email' : null,
                        onChanged: (val) {
                          setState(() => email = val.trim());
                        },
                      ),
                      SizedBox(height: 20.0),
                      TextFormField(
                        decoration: textInputDecoration.copyWith(
                          hintText: 'Password',
                          labelText: 'Password:',
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                        ),
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
                                    await _auth.registerWithEmailAndPassword(
                                        email, password, phonenumber, fullname);

                                if (result == null) {
                                  setState(() {
                                    error =
                                        'check your details and internet connection and try again';
                                    loading = false;
                                  });
                                }
                              }
                            },
                            child: PrimaryButton(
                              btnText: "Create Account",
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
                              btnText: "Sign In",
                            ),
                          )
                        ],
                      ),
                      // RaisedButton(
                      //   color: Colors.pink[400],
                      //   child: Text(
                      //     'Register',
                      //     style: TextStyle(color: Colors.white),
                      //   ),
                      //   onPressed: () async {
                      //     if (_formKey.currentState.validate()) {
                      //       setState(() => loading = true);

                      //       dynamic result =
                      //           await _auth.registerWithEmailAndPassword(
                      //               email, password, phonenumber, fullname);

                      //       if (result == null) {
                      //         setState(() {
                      //           error =
                      //               'check your details and internet connection and try again';
                      //           loading = false;
                      //         });
                      //       }
                      //     }
                      //   },
                      // ),
                      SizedBox(height: 12.0),
                    ],
                  ),
                ),
              ),
            ));
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
