import 'package:cloud_firestore/cloud_firestore.dart';

class CloudFirestoreHelper {
  CloudFirestoreHelper._();

  static final CloudFirestoreHelper cloudFirestoreHelper =
      CloudFirestoreHelper._();

  //static final
  static final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  late CollectionReference authorRef;
  late CollectionReference countersRef;

  //todo: connectWithStudentsCollection

  void connectWithAuthorsCollection() {
    authorRef = firebaseFirestore.collection("authors");
  }

  void connectWithCountersCollection() {
    countersRef = firebaseFirestore.collection("counters");
  }

//todo:insertRecord
  Future<void> insertRecord({required Map<String, dynamic> data}) async {
    connectWithAuthorsCollection();
    connectWithCountersCollection();
    DocumentSnapshot documentSnapshot =
        await countersRef.doc('author-counter').get();
    Map<String, dynamic> counterData =
        documentSnapshot.data() as Map<String, dynamic>;
    int counter = counterData['counter']; //0
    await authorRef.doc('${++counter}').set(data);
    await countersRef.doc('author-counter').update({'counter': counter});
  }

  Stream<QuerySnapshot<Object?>> selectRecord() {
    connectWithAuthorsCollection();

    return authorRef.snapshots();
  }

//todo: updateRecord

  Future<void> updateRecord(
      {required String id, required Map<String, dynamic> updateData}) async {
    connectWithAuthorsCollection();

    await authorRef.doc(id).update(updateData);
  }

//todo: deleteRecord
  Future<void> deleteRecord({required String id}) async {
    connectWithAuthorsCollection();

    await authorRef.doc(id).delete();
  }
}
