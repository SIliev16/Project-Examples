
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class AuthService extends ChangeNotifier{

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore =FirebaseFirestore.instance;
  



  Future<UserCredential> signInWithEmailPassword(String email, password) async{
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      _firestore.collection('users').doc(userCredential.user!.uid).set({
        'uid': userCredential.user!.uid,
        'email': email,
      },
          SetOptions(merge: true));
      return userCredential;
    } on FirebaseException catch (e){
      throw Exception(e.code);

    }
  }
  Future<void> signOut()async{
    return await FirebaseAuth.instance.signOut();

  }
  Future<UserCredential> signUpWithEmailPassword(String email,password) async{

    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password
      );
      _firestore.collection('users').doc(userCredential.user!.uid).set({
        'uid': userCredential.user!.uid,
        'email': email,
      },
      SetOptions(merge: true));

      return userCredential;
    } on FirebaseException catch (e){
      throw Exception(e.code);

    }
  }
}