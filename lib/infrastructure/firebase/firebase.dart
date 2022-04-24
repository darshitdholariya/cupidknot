import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseRepo {
  Future<String> addUser({id, name, contact, email}) async {
    return FirebaseFirestore.instance.collection(id).add({
      'full_name': name,
      'contactNumber': contact,
      'email': email
    }).then((value) {
      return 'data add Successfully';
    }).catchError((error) {
      return "Failed to add user";
    });
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getContact(id) {
    return FirebaseFirestore.instance.collection(id).snapshots();
  }

  Future<void> deleteContact(id, index) async {
    final data = await FirebaseFirestore.instance
        .collection(id)
        .get()
        .then((value) => value.docs[index].id.toString());
    return await FirebaseFirestore.instance.collection(id).doc(data).delete();
  }
}
