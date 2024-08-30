import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:movie_app/src/feature/auth/widgets/user_id.dart';

Future handleFirstLogIn() async {
  try {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('user_id', isEqualTo: userId)
        .get();

    if (querySnapshot.size == 1) {
      final docRef = querySnapshot.docs.first.reference;
      await docRef.set({'first_login': false}, SetOptions(merge: true));
    } else {
      // Handle cases where no document or multiple documents found
      print('Error: User document not found or multiple found');
    }
  } catch (e) {
    print('Error updating user document: $e');
  }
}
