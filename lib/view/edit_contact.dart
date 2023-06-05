import 'package:actfirebase/controller/contact_controller.dart';
import 'package:actfirebase/model/contact_model.dart';
import 'package:actfirebase/view/contact.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class EditContact extends StatefulWidget {
  const EditContact(
      {super.key,
      this.namaAsal,
      this.id,
      this.phoneAsal,
      this.emailAsal,
      this.addressAsal});
  final String? id;
  final String? namaAsal;
  final String? phoneAsal;
  final String? emailAsal;
  final String? addressAsal;

  @override
  State<EditContact> createState() => _EditContactState();
}

class _EditContactState extends State<EditContact> {
  final contactController = ContactController();

  String? namaBaru;
  String? phoneBaru;
  String? emailBaru;
  String? addressBaru;

  // void updateContact(ContactModel ctmodel) async {
  //   await contactController.editContact(ctmodel);
  // }

  @override
  Widget build(BuildContext context) {
    var formkey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Contact'),
      ),
      body: Form(
        key: formkey,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            TextFormField(
              decoration:
                  const InputDecoration(hintText: 'Nama', labelText: 'Nama'),
              onChanged: (value) {
                namaBaru = value;
              },
              initialValue: widget.namaAsal,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Nama harus diisi!';
                }
                return null;
              },
            ),
            TextFormField(
              decoration:
                  const InputDecoration(hintText: 'Phone', labelText: 'Phone'),
              onChanged: (value) {
                phoneBaru = value;
              },
              initialValue: widget.phoneAsal,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Phone harus diisi!';
                }
                return null;
              },
            ),
            TextFormField(
              decoration:
                  const InputDecoration(hintText: 'Email', labelText: 'Email'),
              onChanged: (value) {
                emailBaru = value;
              },
              initialValue: widget.emailAsal,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Email harus diisi!';
                }
                return null;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                  hintText: 'Address', labelText: 'Address'),
              onChanged: (value) {
                addressBaru = value;
              },
              initialValue: widget.addressAsal,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Address harus diisi!';
                }
                return null;
              },
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                if (formkey.currentState!.validate()) {
                  formkey.currentState!.save();
                  ContactModel cm = ContactModel(
                      id: widget.id,
                      name: namaBaru!.toString(),
                      phone: phoneBaru!.toString(),
                      email: emailBaru!.toString(),
                      address: addressBaru!.toString());
                  contactController.editContact(cm);
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Contact Changed')));

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Contact(),
                    ),
                  );
                }
                //print(cm);
              },
              child: const Text('Edit Contact'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: ((context) => const Contact())));

                var snackBar =
                    const SnackBar(content: Text('Batal melakukan perubahan'));
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
              child: const Text('Batalkan'),
            ),
          ],
        ),
      ),
    );
  }
}
