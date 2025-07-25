import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:safe_guinee/models/probleme.dart';

class ProblemeService {
  final _firestore = FirebaseFirestore.instance;

  late final CollectionReference<Probleme> _problemeRef;

  ProblemeService() {
    _problemeRef = _firestore
        .collection("probleme")
        .withConverter<Probleme>(
          fromFirestore: (snapshots, _) => Probleme.fromJson(snapshots.data()!),
          toFirestore: (probleme, _) => probleme.toJson(),
        );
  }

  Stream<QuerySnapshot<Probleme>> getAllProblemes() {
    return _problemeRef.snapshots();
  }
}
