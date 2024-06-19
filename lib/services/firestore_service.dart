import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_rpg/models/app_user.dart';
import 'package:flutter_rpg/services/fireauth_service.dart';

abstract class FirestoreModel {
  Map<String, dynamic> toFirestore();
}

abstract class FirestoreService<T extends FirestoreModel> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late CollectionReference _collectionRef;
  final T Function(Map<String, dynamic>, String id) fromFirestore;

  String path = "";

  FirestoreService(this.fromFirestore) {
    FireAuthService.authStateChanges().listen((AppUser? user) {
      if (user != null) {
        _collectionRef = _firestore.collection(path).doc(user.uid).collection('data');
      }
    });
  }


  Future<List<T>> getDocumentsOnce() async {
    if (await _checkAndRefreshLogin()) {
      QuerySnapshot querySnapshot = await _collectionRef.get();
      return querySnapshot.docs.map((doc) =>  fromFirestore(doc.data() as Map<String, dynamic>, doc.id)).toList();
    } else {
      throw Exception('Login failed');
    }
  }

  Future<void> addDocument(T model) async {
    if (await _checkAndRefreshLogin()) {
      await _collectionRef.add(model.toFirestore());
    } else {
      throw Exception('Login failed');
    }
  }

  Future<void> updateDocument(String docId, T model) async {
    if (await _checkAndRefreshLogin()) {
      await _collectionRef.doc(docId).update(model.toFirestore());
    } else {
      throw Exception('Login failed');
    }
  }

  Future<void> deleteDocument(String docId) async {
    if (await _checkAndRefreshLogin()) {
      await _collectionRef.doc(docId).delete();
    } else {
      throw Exception('Login failed');
    }
  }

  Future<bool> _checkAndRefreshLogin() async {
    AppUser? user = await FireAuthService.getCurrentUser();
    user ??= await FireAuthService.signInWithSavedCredentials();
    if (user != null) {
      _collectionRef = _firestore.collection(path).doc(user.uid).collection('data');
      return true;
    } else {
      return false;
    }
  }

  
}

