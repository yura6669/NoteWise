import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notewise/core/models/user.dart';

class UserRepository implements IUserRepository {
  @override
  Future<UserModel?> getUserWithCache() async {
    UserModel? userModel;
    final box = await _getBox();
    for (final user in box.values) {
      userModel = UserModel.fromMap(jsonDecode(user));
    }
    return userModel;
  }

  @override
  Future<void> addUser({
    required String id,
    required String fullName,
    required String email,
    required String password,
  }) async {
    final CollectionReference collectionUsers =
        FirebaseFirestore.instance.collection('users');
    DocumentReference documentReference = collectionUsers.doc(id);

    final UserModel user = UserModel(
      id: id,
      email: email,
      name: fullName,
    );
    await documentReference.set(user.toMap());
  }

  @override
  Future<UserModel?> getUser(String email) async {
    final CollectionReference collection =
        FirebaseFirestore.instance.collection('users');
    final data = await collection.get();
    final mapped = data.docs.map((e) {
      final map = e.data() as Map<String, dynamic>?;
      if (map != null) {
        return UserModel.fromMap(map);
      }
    });
    UserModel? model;
    final result = mapped.toList();
    if (result.isNotEmpty) {
      for (var user in result) {
        if (user!.email == email) {
          model = user;
        }
      }
    }
    return model;
  }

  @override
  Future<void> saveUserToCache(UserModel user) async {
    final box = await _getBox();
    final map = user.toMap();
    final json = jsonEncode(map);
    return box.put(_institutionBox, json);
  }

  Future<void> deleteInstitutionWithCash() async {
    var box = await _getBox();
    await box.delete(_institutionBox);
  }

  Future<Box> _getBox() async {
    if (Hive.isBoxOpen(_institutionBox)) {
      return Hive.box(_institutionBox);
    } else {
      return await Hive.openBox(_institutionBox);
    }
  }

  static const String _institutionBox = 'user';
}

abstract class IUserRepository {
  Future<UserModel?> getUserWithCache();

  Future<void> addUser({
    required String id,
    required String fullName,
    required String email,
    required String password,
  });

  Future<UserModel?> getUser(String email);

  Future<void> saveUserToCache(UserModel user);
}
