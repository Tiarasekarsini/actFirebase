import 'dart:async';

import 'package:actfirebase/model/contact_model.dart';
import 'package:actfirebase/view/edit_contact.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

//menghandle semua koneksi ke firestore
class ContactController {
  final contactCollection = FirebaseFirestore.instance.collection('contacts');

  final StreamController<List<DocumentSnapshot>> streamController =
      StreamController<List<DocumentSnapshot>>.broadcast();

  //list untuk menampung data
  Stream<List<DocumentSnapshot>> get stream => streamController.stream;

  Future<void> addContact(ContactModel ctmodel) async {
    final contact = ctmodel.toMap();

    final DocumentReference docRef = await contactCollection.add(contact);

    final String docId = docRef.id;

    final ContactModel contactModel = ContactModel(
        id: docId,
        name: ctmodel.name,
        phone: ctmodel.phone,
        email: ctmodel.email,
        address: ctmodel.address);

    await docRef.update(contactModel.toMap());
  }

  Future getContact() async {
    final contact = await contactCollection.get();
    streamController.sink.add(contact.docs);
    return contact.docs;
  }

//kode awal
  // Future<void> updateContact(ContactModel ctmodel) async {
  //   var document = contactCollection.doc(ctmodel.id);

  //   final ContactModel contactModel = ContactModel(
  //       id: ctmodel.id,
  //       name: ctmodel.name,
  //       phone: ctmodel.phone,
  //       email: ctmodel.email,
  //       address: ctmodel.address);

  //   await document.update(contactModel.toMap());
  // }

  Future<void> editContact(ContactModel contactModel) async {
    var document = contactCollection.doc(contactModel.id);

    final ContactModel cModel = ContactModel(
        id: contactModel.id,
        name: contactModel.name,
        phone: contactModel.phone,
        email: contactModel.email,
        address: contactModel.address);

    await document.update(cModel.toMap());

    //saat demo dikelas
    // final ContactModel editContactModel = ContactModel(
    //     name: contactModel.name,
    //     email: contactModel.email,
    //     phone: contactModel.phone,
    //     address: contactModel.address,
    //     id: contactModel.id);

    // final DocumentSnapshot documentSnapshot =
    //     await contactCollection.doc(contactModel.id).get();
    // if (!documentSnapshot.exists) {
    //   // print('Contact with ID $doc does not exist');
    //   return;
    // }
    // final editContact = editContactModel.toMap();
    // await contactCollection.doc(contactModel.id).update(editContact);
    // await getContact();
    // print('Updated contact with ID: $docId');
  }

  Future<void> deleteContact(String id) async {
    var document = contactCollection.doc(id);
    var DocumentSnapshot = await document.get();

    if (DocumentSnapshot.exists) {
      await document.delete();
    } else {
      throw Exception('Gagal menghapus data');
    }
  }
}
