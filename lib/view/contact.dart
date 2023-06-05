import 'package:actfirebase/controller/contact_controller.dart';
import 'package:actfirebase/model/contact_model.dart';
import 'package:actfirebase/view/add_contact.dart';
import 'package:actfirebase/view/edit_contact.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class Contact extends StatefulWidget {
  const Contact({super.key});

  @override
  State<Contact> createState() => _ContactState();
}

class _ContactState extends State<Contact> {
  var cc = ContactController();

  @override
  void initState() {
    cc.getContact();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(padding: const EdgeInsets.only(top: 10)),
          Text(
            'Contact List',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          //meampung dari controller
          Expanded(
              child: StreamBuilder<List<DocumentSnapshot>>(
            stream: cc.stream,
            builder: (context, snapshot) {
              // if (snapshot.hasError) {
              //   return Center(
              //     child: Text('error: ${snapshot.error}'),
              //   );
              // }
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              //variabel untuk menampung datanya
              final List<DocumentSnapshot> data =
                  snapshot.data!; // data dari stream
              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: InkWell(
                        onLongPress: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const EditContact(),
                            ),
                          );
                        },
                        child: Card(
                          elevation: 10,
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.yellow,
                              child: Text(
                                data[index]['name']
                                    .substring(0, 1)
                                    .toUpperCase(),
                                style: const TextStyle(
                                    color: Colors.pinkAccent,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            title: Text(data[index]['name']),
                            subtitle: Text(data[index]['phone']),
                            trailing: IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text('Hapus Data'),
                                        content: Text(
                                            'Apakah anda yakin ingin menghapus data ini?'),
                                        actions: [
                                          TextButton(
                                            child: Text('No'),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                          TextButton(
                                            child: Text('Yes'),
                                            onPressed: () async {
                                              Navigator.pop(context);
                                              cc
                                                  .deleteContact(data[index].id)
                                                  .then((value) {
                                                setState(() {
                                                  cc.getContact();
                                                });
                                              });
                                              var snackBar = const SnackBar(
                                                  content: Text(
                                                      'Data Telah Terhapus'));
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(snackBar);
                                            },
                                          )
                                        ],
                                      );
                                    });
                              },
                            ),
                          ),
                        ),
                      ));
                },
              );
            },
          ))
        ],
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddContact()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
