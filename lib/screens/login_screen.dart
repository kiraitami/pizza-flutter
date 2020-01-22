import 'package:flutter/material.dart';
import 'package:flutter_app_virtual_market/models/user_model.dart';
import 'package:flutter_app_virtual_market/screens/register_screen.dart';
import 'package:scoped_model/scoped_model.dart';


class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
        appBar: AppBar(
            title: Text('Sign In'),
            actions: <Widget>[
              FlatButton(
                  child: Text(
                      'Sign Up',
                      style: TextStyle(fontSize: 15.0)),
                  textColor: Colors.white,
                  onPressed: (){
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => RegisterScreen())
                    );
                  }
              )
            ]
        ),

        body: ScopedModelDescendant<User>(
          builder: (context, child, model){

            if (model.isLoading){
              return Center(child: CircularProgressIndicator());
            }

            else
              return Form(
                key: _formKey,
                child: ListView(
                  padding: EdgeInsets.all(32.0),
                  children: <Widget>[

                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                          hintText: 'E-mail',
                          prefixIcon: Icon(Icons.email)
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (text){
                        if (text.isEmpty) return 'Insert your email';
                      },
                    ),

                    SizedBox(height: 16.0),

                    TextFormField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                          hintText: 'Password',
                          prefixIcon: Icon(Icons.lock)
                      ),
                      obscureText: true,
                      validator: (text){
                        if (text.isEmpty) return 'Insert your password';
                      },
                    ),

                    Padding(
                      padding: EdgeInsets.only(top: 8.0),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: FlatButton(
                          onPressed: (){
                            if (_emailController.text.isNotEmpty){
                              model.recoverPassword(_emailController.text);
                              SnackBar(
                                  content: Text('Check your email'),
                                  backgroundColor: Theme.of(context).primaryColor,
                                  duration: Duration(seconds: 2)
                              );
                            }
                            else {
                              SnackBar(
                                  content: Text('We need to know your email to recover your password'),
                                  backgroundColor: Colors.redAccent,
                                  duration: Duration(seconds: 2)
                              );
                            }
                          },
                          child: Text('Forgot password?', textAlign: TextAlign.right),
                          padding: EdgeInsets.zero,
                        ),
                      ),
                    ),

                    SizedBox(height: 16.0),

                    SizedBox(
                        height: 44.0,
                        child: RaisedButton(
                          child: Text('Sign In', style: TextStyle(fontSize: 18.0)),
                          textColor: Colors.white,
                          color: Theme.of(context).primaryColor,
                          onPressed: (){
                            if (_formKey.currentState.validate()){

                            }
                            model.login(
                                email: _emailController.text,
                                password: _passwordController.text,
                                onSuccess: _onSuccess,
                                onFailure: _onFailure);
                          },
                        )
                    )

                  ],
                ),
              );
          },
        )
    );
  }

  void _onSuccess(){
   Navigator.of(context).pop();
  }

  void _onFailure(){
    _scaffoldKey.currentState.showSnackBar(
        SnackBar(
            content: Text('Login failed'),
            backgroundColor: Colors.redAccent,
            duration: Duration(seconds: 2)
        )
    );
  }
}
