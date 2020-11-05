import 'package:Model/services/authen_service.dart';
import 'package:Model/utilities/constants.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _key = GlobalKey<FormState>();

  final AuthenService _auth = AuthenService();

  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF73AEF5),
              Color(0xFF61A4F1),
              Color(0xFF478DE0),
              Color(0xFF398AE5),
            ],
            stops: [0.1, 0.4, 0.7, 0.9],
          ),
        ),
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 40.0),
            child: Column(
              key: _key,
              children: <Widget>[
                SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                Text(
                  'Sign Up',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                _buildNameTF(),
                SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                _buildEmailTF(),
                SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                _buildPasswordTF(),
                SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                _buildSignupBtn(),
                _buildLoginBtn(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNameTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Name',
          style: kLabelStyle,
        ),
        SizedBox(height: 8.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextFormField(
            controller: _nameController,
            validator: (value) {
              if (value.isEmpty) {
                return 'Name cannot be empty';
              } else {
                return null;
              }
            },
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
              color: Colors.white,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.email,
                color: Colors.white,
              ),
              hintText: 'Enter your Name',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEmailTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Email',
          style: kLabelStyle,
        ),
        SizedBox(height: 8.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextFormField(
            controller: _emailController,
            validator: (value) {
              if (value.isEmpty) {
                return 'Email cannot be empty';
              } else {
                return null;
              }
            },
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
              color: Colors.white,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.email,
                color: Colors.white,
              ),
              hintText: 'Enter your Email',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Password',
          style: kLabelStyle,
        ),
        SizedBox(height: 8.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextFormField(
            obscureText: true,
            controller: _passwordController,
            validator: (value) {
              if (value.isEmpty) {
                return 'Password cannot be empty';
              } else {
                return null;
              }
            },
            style: TextStyle(
              color: Colors.white,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.lock,
                color: Colors.white,
              ),
              hintText: 'Enter your Password',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSignupBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15.0),
      width: 170.0,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () {
          if (_key.currentState.validate()) {
            buildUser();
          }
          Navigator.pop(context);
        },
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.white,
        child: Text(
          'Sign Up',
          style: TextStyle(
            color: Color(0xFF527DAA),
            letterSpacing: 1.3,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildLoginBtn() {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Do have an Account?  ',
              style: TextStyle(
                color: Colors.white,
                fontSize: 17.0,
                fontWeight: FontWeight.w400,
                fontFamily: 'Ubuntu',
              ),
            ),
            TextSpan(
              text: 'Sign In',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'Ubuntu',
              ),
            ),
          ],
        ),
      ),
    );
  }

  void buildUser() async {
    dynamic result = await _auth.createUser(
        _nameController.text, _emailController.text, _passwordController.text);
    if (result == null) {
      print('Email is not valid');
    } else {
      print(result.toString());
      Navigator.pop(context);
    }
  }
}
