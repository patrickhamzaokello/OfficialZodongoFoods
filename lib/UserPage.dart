import 'package:flutter/material.dart';
import 'package:flutterloginui/services/auth.dart';

class UserPage extends StatefulWidget {
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final String _fullName = "Zodongo Foods";
  final AuthService _auth = AuthService();

  final String _status = "Mobile Food Ordering App";

  final String _bio =
      "\"Hello, Zodongo Foods is a the leading Mobile Restaurant that serves the Entire Community Digitally Using a Mobile App where Customers can Place Orders and get Quick Service in Real Time with Good Customer Care Services\"";

  Widget _buildCoverImage(Size screenSize) {
    return Container(
      height: screenSize.height / 2.6,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/plate4.png'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildProfileImage() {
    return Center(
      child: Container(
        width: 140.0,
        height: 140.0,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/profileimage.jpg'),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(80.0),
          border: Border.all(
            color: Colors.green,
            width: 10.0,
          ),
        ),
      ),
    );
  }

  Widget _buildFullName() {
    TextStyle _nameTextStyle = TextStyle(
      fontFamily: 'Roboto',
      color: Colors.black,
      fontSize: 28.0,
      fontWeight: FontWeight.w700,
    );

    return Text(
      _fullName,
      style: _nameTextStyle,
    );
  }

  Widget _buildStatus(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 6.0),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Text(
        _status,
        style: TextStyle(
          fontFamily: 'Spectral',
          color: Colors.black,
          fontSize: 20.0,
          fontWeight: FontWeight.w300,
        ),
      ),
    );
  }

  Widget _buildBio(BuildContext context) {
    TextStyle bioTextStyle = TextStyle(
      fontFamily: 'Spectral',
      fontWeight: FontWeight.w400, //try changing weight to w500 if not thin
      fontStyle: FontStyle.italic,
      color: Color(0xFF799497),
      fontSize: 16.0,
    );

    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      padding: EdgeInsets.all(8.0),
      child: Text(
        _bio,
        textAlign: TextAlign.center,
        style: bioTextStyle,
      ),
    );
  }

  Widget _buildSeparator(Size screenSize) {
    return Container(
      width: screenSize.width / 1.6,
      height: 2.0,
      color: Colors.black54,
      margin: EdgeInsets.only(top: 4.0),
    );
  }

  Widget _buildGetInTouch(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      padding: EdgeInsets.only(top: 8.0),
      child: Text(
        "Get in Touch with Zodongo Foods,",
        style: TextStyle(fontFamily: 'Roboto', fontSize: 16.0),
      ),
    );
  }

  Widget _buildPhoneno(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      padding: EdgeInsets.only(top: 8.0),
      child: Text(
        "+256 787 250 196",
        style: TextStyle(fontFamily: 'Roboto', fontSize: 16.0),
      ),
    );
  }

  Widget _buildButtons() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: InkWell(
              onTap: () async {
                await _auth.signOut();
              },
              child: Container(
                height: 40.0,
                decoration: BoxDecoration(
                  color: Colors.green,
                ),
                child: Center(
                  child: Text(
                    "LOG OUT",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF5AC035),
        elevation: 0.0,
        title: Text('Exit Zodongo Foods'),
      ),
      body: Stack(
        children: <Widget>[
          _buildCoverImage(screenSize),
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(height: screenSize.height / 6.4),
                  _buildProfileImage(),
                  _buildFullName(),
                  _buildStatus(context),
                  // _buildBio(context),
                  _buildSeparator(screenSize),
                  SizedBox(height: 10.0),
                  _buildGetInTouch(context),
                  _buildPhoneno(context),
                  SizedBox(height: 8.0),
                  _buildButtons(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
