import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';

class ContactListPage extends StatelessWidget {
  static const String id = "ContactListPage";

  const ContactListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Contact Submissions',
          style: GoogleFonts.libreCaslonText(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF597CFF), // Dark Blue background color
      ),
      body: Container(
        color: Colors.white, // White background color
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('UserContact').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  'Something went wrong',
                  style: GoogleFonts.libreCaslonText(color: Colors.black),
                ),
              );
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            final data = snapshot.data!.docs;

            if (data.isEmpty) {
              return Center(
                child: Text(
                  'No contact submissions found',
                  style: GoogleFonts.libreCaslonText(color: Colors.black),
                ),
              );
            }

            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                final contact = data[index].data() as Map<String, dynamic>;
                final docId = data[index].id;

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: ListTile(
                      title: Text(
                        contact['Name'] ?? 'No Name',
                        style: GoogleFonts.libreCaslonText(color: Colors.black, fontSize: 18.0),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 5.0),
                          Text(
                            'Email: ${contact['Email'] ?? 'No Email'}',
                            style: GoogleFonts.libreCaslonText(color: Colors.black),
                          ),
                          const SizedBox(height: 5.0),
                          Text(
                            'Message: ${contact['Message'] ?? 'No Message'}',
                            style: GoogleFonts.libreCaslonText(color: Colors.black),
                          ),
                        ],
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () async {
                          await FirebaseFirestore.instance
                              .collection('UserContact')
                              .doc(docId)
                              .delete()
                              .then((_) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Contact submission deleted',
                                  style: GoogleFonts.libreCaslonText(color: Colors.black),
                                ),
                                backgroundColor: const Color(0xFF597CFF), // Dark Blue background color
                              ),
                            );
                          }).catchError((error) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Failed to delete submission: $error',
                                  style: GoogleFonts.libreCaslonText(color: Colors.black),
                                ),
                                backgroundColor: Colors.red,
                              ),
                            );
                          });
                        },
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
