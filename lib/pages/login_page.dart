import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>(); 
  final _formKey = GlobalKey<FormState>();
  String  _email, _password;
  bool _obscureText = true;
  bool _isSubmitting = false;

  Widget _showTitle() {
    return Text('Login', style: Theme.of(context).textTheme.headline);
  }

  Widget _showEmailInput() {
    return Padding(
      padding: EdgeInsets.only(top: 20.0),
      child: TextFormField(
        onSaved: (val) => _email=val,
        validator: (val) => !val.contains('@') ? 'Invalid email' : null ,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Email',
          hintText: 'Enter Email',
          icon: Icon(Icons.mail, color: Colors.grey,)
        ),
      ),
    );
  }

  Widget _showPasswordInput() {
    return Padding(
      padding: EdgeInsets.only(top: 20.0),
      child: TextFormField(
        onSaved: (val) => _password=val,
        obscureText: true,
        validator: (val) => val.length < 6 ? 'password too short' : null,
        decoration: InputDecoration(
          suffixIcon: GestureDetector(
            child: Icon(
              _obscureText ? Icons.visibility : Icons.visibility_off
            ),
            onTap: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
          ),
          border: OutlineInputBorder(),
          labelText: 'Password',
          hintText: 'Enter Password, min length 6',
          icon: Icon(Icons.lock, color: Colors.grey,)
        ),
      ),
    );
  }

  Widget _showFormActions() {
    return Padding(
      padding: EdgeInsets.only(top: 20.0),
      child: Column(
        children: [
          _isSubmitting == true? CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Theme.of(context).accentColor),) :RaisedButton(
            child: Text('Submit', style: Theme.of(context).textTheme.body1.copyWith(color: Colors.black)),
            elevation: 8.0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
            color: Theme.of(context).accentColor,
            onPressed: _submit
          ),
          FlatButton(
            onPressed: () => Navigator.pushReplacementNamed(context, '/register'), 
            child: Text('New User? Register')
          )
        ]
      ),
    );
  }

  _submit() {
    final form = _formKey.currentState;

    if(form.validate()){
      form.save();
      _loginUser();
      
    }
  }

  void _loginUser() async {
    setState(() {
      _isSubmitting = false;
    });
    http.Response response = await http.post('http://10.0.2.2:1337/auth/local', 
      body: {
        "identifier": _email,
        "password": _password
      });
    final responseData = json.decode(response.body);
    //print(responseData);
    if (response.statusCode == 200) {
      
      setState(() {
        _isSubmitting = true;
      });  
      _storeUserData(responseData);
      _showSuccessSnack();
      _redirectUser();
    }
    else {
      setState(() {
        _isSubmitting = false;
      });
      //final String errorMsg = responseData['message'][0]['message'];
      _showErrorSnack("errorMsg");
    }
    
    
  }

  void _storeUserData(responseData) async {
    final prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> user = responseData['user'];
    user.putIfAbsent('jwt', () => responseData['jwt']);
    prefs.setString('user', json.encode(user));
  }

  void _redirectUser() {
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, '/');
    });
    
  }

  void _showSuccessSnack() {
    final snackbar = SnackBar(
      content: Text('User successfully logged in!. ', style: TextStyle(color: Colors.green),),
    );

    _scaffoldKey.currentState.showSnackBar(snackbar);
    _formKey.currentState.reset();
  }

  void _showErrorSnack(String errorMsg) {
    final snackbar = SnackBar(
      content: Text(errorMsg , style: TextStyle(color: Colors.red),),
    );

    _scaffoldKey.currentState.showSnackBar(snackbar);
    throw Exception('Error logging user: $errorMsg');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  _showTitle(),
                  _showEmailInput(),
                  _showPasswordInput(),
                  _showFormActions()
                ],
              ),
            ),
          ),
        )
      ),
    );
  }
}