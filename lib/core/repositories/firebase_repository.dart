import 'package:firebase_auth/firebase_auth.dart';

class FirebaseRepository extends IFirebaseRepository {
  @override
  Future<UserCredential> register({
    required String email,
    required String password,
  }) async {
    return await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  @override
  Future<void> restorePassword({required String email}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    await auth.sendPasswordResetEmail(email: email);
  }

  @override
  Future<UserCredential> signIn({
    required String email,
    required String password,
  }) async {
    return await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  @override
  Future<void> signOut() {
    throw UnimplementedError();
  }

  @override
  Future<void> updateEmail({required String newEmail}) {
    throw UnimplementedError();
  }

  @override
  Future<void> updatePassword({
    required String email,
    required String oldPassword,
    required String newPassword,
  }) {
    throw UnimplementedError();
  }
}

abstract class IFirebaseRepository {
  Future<UserCredential> signIn({
    required String email,
    required String password,
  });

  Future<UserCredential> register({
    required String email,
    required String password,
  });

  Future<void> restorePassword({required String email});

  Future<void> updateEmail({required String newEmail});

  Future<void> updatePassword({
    required String email,
    required String oldPassword,
    required String newPassword,
  });

  Future<void> signOut();
}
