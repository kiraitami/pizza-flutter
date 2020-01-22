import 'package:flutter/material.dart';
import 'package:flutter_app_virtual_market/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _addressController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text('Register'),
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
                      controller: _nameController,
                      decoration: InputDecoration(
                          hintText: 'Name',
                          prefixIcon: Icon(Icons.person)
                      ),
                      validator: (text){
                        if (text.isEmpty) return 'Insert your name';
                      },
                    ),

                    SizedBox(height: 16.0),

                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                          hintText: 'E-mail',
                          prefixIcon: Icon(Icons.email)
                      ),
                      keyboardType: TextInputType.emailAddress,
                      autocorrect: false,
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

                    SizedBox(height: 16.0),

                    TextFormField(
                      controller: _addressController,
                      decoration: InputDecoration(
                          hintText: 'Address',
                          prefixIcon: Icon(Icons.location_on)
                      ),
                      validator: (text){
                        if (text.isEmpty) return 'Insert your address';
                      },
                    ),

                    SizedBox(height: 32.0),

                    SizedBox(
                        height: 44.0,
                        child: RaisedButton(
                          child: Text('Sign Up', style: TextStyle(fontSize: 18.0)),
                          textColor: Colors.white,
                          color: Theme.of(context).primaryColor,
                          onPressed: (){
                            if (_formKey.currentState.validate()){

                              Map<String, dynamic> userData = {
                                'name': _nameController.text,
                                'email': _emailController.text,
                                'address': _addressController.text
                              };

                              model.register(
                                  userData: userData,
                                  password: _passwordController.text,
                                  onSuccess: _onSuccess,
                                  onFailure: _onFailure
                              );
                            }
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
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text('User registered successfully'),
        backgroundColor: Theme.of(context).primaryColor,
        duration: Duration(seconds: 2)
      )
    );
    Future.delayed(Duration(seconds: 2)).then((t){
      Navigator.of(context).pop();
    });
  }

  void _onFailure(){
    _scaffoldKey.currentState.showSnackBar(
        SnackBar(
            content: Text('User register failed'),
            backgroundColor: Colors.redAccent,
            duration: Duration(seconds: 2)
        )
    );
  }
}