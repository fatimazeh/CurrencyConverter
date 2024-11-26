import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationListPage extends StatefulWidget {
  static const String id = "NotificationListPage";
  const NotificationListPage({Key? key}) : super(key: key);

  @override
  _NotificationListPageState createState() => _NotificationListPageState();
}

class _NotificationListPageState extends State<NotificationListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications', style: GoogleFonts.libreCaslonText()),
        backgroundColor: Color(0xFF597CFF), // Dark Blue
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFf4ebe6), // Light Pink
              Color(0xFFf0d2d0), // Pink
              Color(0xFF95a7b1), // Light Blue
         Color(0xFF001F3D), // Dark Blue
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('notifications').orderBy('timestamp', descending: true).snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return Center(child: Text('No notifications available', style: GoogleFonts.libreCaslonText()));
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
      color: isRead ? Color(0xFFE1DED7) : Colors.white, // Light Brown for read, white for unread
      child: ListTile(
        leading: Icon(
          Icons.notifications,
          color: isRead ? Colors.grey : Color(0xFF001F3D),// Dark Blue for unread, grey for read
        ),
        title: Text(
          title,
          style: GoogleFonts.libreCaslonText(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          message,
          style: GoogleFonts.libreCaslonText(),
        ),
        trailing: Text(
          "${timestamp.day}/${timestamp.month}/${timestamp.year}",
          style: GoogleFonts.libreCaslonText(
            color:Color(0xFF001F3D),
          ),
        ),
      ),
    );
  }
}
