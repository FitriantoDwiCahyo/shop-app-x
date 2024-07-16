import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> createNewUser(String email, String fullName, String pass) async {
    try {
      UserCredential userCredential =  await _auth.createUserWithEmailAndPassword(email: email, password: pass);
    
      await _firestore.collection('Buyers').doc(userCredential.user!.uid).set({
          'fullName': fullName,
          'email' : email,
          'buyerId': userCredential.user!.uid,       
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }
}
