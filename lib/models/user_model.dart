import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:scoped_model/scoped_model.dart';

class User extends Model {

  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser firebaseUser;

  Map<String, dynamic> userData = Map();

  bool isLoading = false;
  
  static User of(BuildContext context) => ScopedModel.of<User>(context);


  @override
  void addListener(VoidCallback listener) {
    super.addListener(listener);
    _loadCurrentUser();
  }

  bool isLoggedIn(){
    return firebaseUser != null;
  }


  void register({@required Map<String, dynamic> userData, @required String password,
    @required VoidCallback onSuccess, @required VoidCallback onFailure}) async {

    isLoading = true;
    notifyListeners();

    _auth.createUserWithEmailAndPassword(
        email: userData['email'],
        password: password
    ).then((user) async{
      firebaseUser = user;

      await _saveUserData(userData);

      onSuccess();
      isLoading = false;
      notifyListeners();

    }).catchError((error){
      print(error);
      onFailure();
      isLoading = false;
      notifyListeners();
    });

  }

  void login({@required String email, @required String password,
    @required VoidCallback onSuccess, @required VoidCallback onFailure}) async {

    isLoading = true;
    notifyListeners();

    _auth.signInWithEmailAndPassword(email: email, password: password).then(
        (user) async {
          firebaseUser = user;
          await _loadCurrentUser();
          onSuccess();
          isLoading = false;
          notifyListeners();

        })
        .catchError( (e){
          print(e);
          onFailure();
          isLoading = false;
          notifyListeners();
    });

  }

  void signOut() async {
    await _auth.signOut();
    userData = Map();
    firebaseUser = null;
    notifyListeners();
  }

  void recoverPassword(String email){
    _auth.sendPasswordResetEmail(email: email);
  }

  Future<Null> _saveUserData(Map<String, dynamic> userData) async {
    this.userData = userData;
    Firestore.instance.collection('users').document(firebaseUser.uid).setData(await userData);
  }

  Future<Null> _loadCurrentUser() async {
    if (firebaseUser == null){
      firebaseUser = await _auth.currentUser();
    }
    else {
      if (userData['name'] == null){
        DocumentSnapshot doc = await Firestore.instance.collection('users').document(firebaseUser.uid).get();
        this.userData = doc.data;
      }
    }
    notifyListeners();
  }


}