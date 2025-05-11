import 'package:firebase_auth/firebase_auth.dart';

abstract class Failure {
  final String? errMessage;

  const Failure({this.errMessage});
}

class FirebaseFailure extends Failure {
  FirebaseFailure({super.errMessage});

  factory FirebaseFailure.fromFirebaseException(Exception exception) {
    if (exception is FirebaseAuthException) {
      return FirebaseFailure.fromAuthException(exception);
    } else if (exception is FirebaseException) {
      return FirebaseFailure.fromFirestoreException(exception);
    } else {
      return FirebaseFailure(
        errMessage: 'An unknown Firebase error occurred: ${exception.toString()}',
      );
    }
  }

  factory FirebaseFailure.fromAuthException(FirebaseAuthException exception) {
    switch (exception.code) {
      case 'invalid-email':
        return FirebaseFailure(errMessage: 'The email address is not valid.');
      case 'user-disabled':
        return FirebaseFailure(errMessage: 'The user account has been disabled.');
      case 'user-not-found':
        return FirebaseFailure(errMessage: 'No user found with this email.');
      case 'wrong-password':
        return FirebaseFailure(errMessage: 'Incorrect password.');
      case 'email-already-in-use':
        return FirebaseFailure(errMessage: 'The email is already in use.');
      case 'weak-password':
        return FirebaseFailure(errMessage: 'The password is too weak.');
      case 'operation-not-allowed':
        return FirebaseFailure(errMessage: 'This operation is not allowed.');
      case 'invalid-credential':
        return FirebaseFailure(
          errMessage: 'The provided credentials are invalid or expired. Please try again.',
        );
      case 'account-exists-with-different-credential':
        return FirebaseFailure(
          errMessage: 'An account already exists with the same email but different sign-in method.',
        );
      default:
        return FirebaseFailure(
          errMessage: 'Auth error (${exception.code}): ${exception.message}',
        );
    }
  }

  factory FirebaseFailure.fromFirestoreException(FirebaseException exception) {
    switch (exception.code) {
      case 'permission-denied':
        return FirebaseFailure(errMessage: 'Permission denied to access Firestore.');
      case 'not-found':
        return FirebaseFailure(errMessage: 'Document not found in Firestore.');
      case 'aborted':
        return FirebaseFailure(errMessage: 'Firestore operation was aborted.');
      case 'already-exists':
        return FirebaseFailure(errMessage: 'Document already exists in Firestore.');
      case 'resource-exhausted':
        return FirebaseFailure(errMessage: 'Firestore resource limit exceeded.');
      case 'unavailable':
        return FirebaseFailure(errMessage: 'Firestore service is currently unavailable.');
      case 'deadline-exceeded':
        return FirebaseFailure(errMessage: 'Firestore operation timed out.');
      case 'cancelled':
        return FirebaseFailure(errMessage: 'Firestore request was cancelled.');
      default:
        return FirebaseFailure(
          errMessage: 'Firestore error (${exception.code}): ${exception.message}',
        );
    }
  }
}
