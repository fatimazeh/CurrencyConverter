import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationListPage extends StatefulWidget {
  static const String id = "NotificationListPage";
    final VoidCallback onPageOpened; // Callback to reset notification count
   const NotificationListPage({Key? key, required this.onPageOpened}) : super(key: key);
  @override
  _NotificationListPageState createState() => _NotificationListPageState();
}

class _NotificationListPageState extends State<NotificationListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications', style: GoogleFonts.libreCaslonText(color: Colors.white)), // Light Pink
        backgroundColor:const Color(0xFF597CFF),
         leading: const BackButton(
          color: Colors.white, // White color for the back button
        ), // Dark Blue
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.white, // Light Pink
              Colors.white, // Pink
              Colors.white, // Light Blue
                        Color(0xFF597CFF), // Dark Blue
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('notifications').orderBy('timestamp', descending: true).snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator(color:Colors.white,)); // Dark Blue
            }

            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}', style: GoogleFonts.libreCaslonText(color: Color(0xFFF4EBE6)))); // Light Pink
            }

            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return Center(child: Text('No notifications available', style: GoogleFonts.libreCaslonText(color: Color(0xFFF4EBE6)))); // Light Pink
            }

            return ListView(
              padding: const EdgeInsets.all(8.0),
              children: snapshot.data!.docs.map((doc) {
                final data = doc.data() as Map<String, dynamic>;
                return NotificationTile(
                  title: data['title'],
                  message: data['message'],
                  timestamp: (data['timestamp'] as Timestamp).toDate(),
                  isRead: data['isRead'] ?? false,
                );
              }).toList(),
            );
          },
        ),
      ),
    );
  }
}

class NotificationTile extends StatelessWidget {
  final String title;
  final String message;
  final DateTime timestamp;
  final bool isRead;

  const NotificationTile({
    required this.title,
    required this.message,
    required this.timestamp,
    required this.isRead,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 5,
      color: isRead ? Colors.white : Color(0xFF597CFF), // Light Brown for read, Pink for unread
      child: ListTile(
        leading: Icon(
          Icons.notifications,
          color: isRead ? Colors.white : Color(0xFF597CFF), // Dark Blue for unread, grey for read
        ),
        title: Text(
          title,
          style: GoogleFonts.libreCaslonText(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color:Colors.white, // Dark Blue
          ),
        ),
        subtitle: Text(
          message,
          style: GoogleFonts.libreCaslonText(color:Colors.white,), // Dark Blue
        ),
        trailing: Text(
          "${timestamp.day}/${timestamp.month}/${timestamp.year}",
          style: GoogleFonts.libreCaslonText(
            color: Colors.white, // Dark Blue
          ),
        ),
      ),
    );
  }
}
