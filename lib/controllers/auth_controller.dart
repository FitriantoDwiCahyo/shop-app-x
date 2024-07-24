import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  TextEditingController email = TextEditingController();

  TextEditingController pass = TextEditingController();

  TextEditingController fullName = TextEditingController();

  Uint8List? image;

  RxBool isLoading = false.obs;

  RxBool isHidden = false.obs;

  Future<String> createNewUser(
      String email, String fullName, String pass, Uint8List? image) async {
    String res = 'Some error occured';
    try {
      isLoading.value = true;
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: pass);

      String downloadUrl = _uploadImageToStorage(image);

      await _firestore.collection('Buyers').doc(userCredential.user!.uid).set({
        'fullName': fullName,
        'profileImage': downloadUrl,
        'email': email,
        'buyerId': userCredential.user!.uid,
      });

      isLoading.value = false;
      return res = 'success';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
      isLoading.value = false;
        return res = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
      isLoading.value = false;
        return res = 'The account already exists for that email.';
      }
    } catch (e) {
      isLoading.value = false;
      return res = e.toString();
    }
    return res;
  }

  Future<Map<String, dynamic>> loginActivity(
      String email, String password) async {
    try {
      isLoading.value = true;
      UserCredential user = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      print('test success');
      isLoading.value = false;
      return {'error': false, 'data': user, 'message': 'Success Login'};
    } on FirebaseAuthException catch (e) {
      isLoading.value = false;
      return {
        'error': true,
        'message': e.code.toString(),
      };
    } catch (e) {
      isLoading.value = false;
      print('test error3');
      return {'error': true, 'message': e.toString()};
    }
  }

  _pickProfileImage(ImageSource source) async {
    final ImagePicker imagePicker = ImagePicker();

    XFile? file = await imagePicker.pickImage(source: source);

    if (file != null) {
      return await file.readAsBytes();
    } else {
      print('No Image Selected or Capture');
    }
  }

  _uploadImageToStorage(Uint8List? image) async {
    Reference ref =
        _storage.ref().child('profileImage').child(_auth.currentUser!.uid);

    UploadTask uploadTask = ref.putData(image!);

    TaskSnapshot taskSnapshot = await uploadTask;

    String download = await taskSnapshot.ref.getDownloadURL();

    return download;
  }

  selecetedGalleryImage() async {
    Uint8List img = await _pickProfileImage(ImageSource.gallery);

    image = img;

    update();
  }

  selecetedCameraImage() async {
    Uint8List img = await _pickProfileImage(ImageSource.camera);

    image = img;

    update();
  }
}
