import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addUserInformation(Map<String, dynamic> userInfoMap, String userId) async {
    await _firestore.collection("users").doc(userId).set(userInfoMap);
  }

  Future ContactDetails(Map<String, dynamic> usercontactMap, String id) async {
    return await FirebaseFirestore.instance
        .collection("UserContact")
        .doc(id)
        .set(usercontactMap); //how to create document
  }
//GEETING DATA TO ADMIN PANEL

  Future<List<Map<String, dynamic>>> fetchContactDetails() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection("UserContact")
          .get();
      
      // Convert QuerySnapshot to List<Map<String, dynamic>>
      return querySnapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
    } catch (e) {
      print('Error fetching contact details: $e');
      return [];
    }
  }


  Future addEmployeeDetails(
      Map<String, dynamic> employeeInfoMap, String id) async {
    return await FirebaseFirestore.instance
        .collection("Profile")
        .doc(id)
        .set(employeeInfoMap);
  }
  // In summary, doc is used to specify the document you want to interact with.
  // In this case, it identifies the document by the (id) you provide. Once you have a reference to this document,
  // you can use various methods to manipulate it, such as set, which writes data to the document.

  Future<Stream<QuerySnapshot>> getEmployeeDetails() async {
    return FirebaseFirestore.instance.collection("Profile").snapshots();
  }

  Future updateEmployeeDetails(
      String id, Map<String, dynamic> updateInfo) async {
    return await FirebaseFirestore.instance
        .collection("Profile")
        .doc(id)
        .update(updateInfo);
  }

  Future deleteEmployeeDetails(String id) async {
    return await FirebaseFirestore.instance
        .collection("Profile")
        .doc(id)
        .delete();
  }

  Future<Stream<QuerySnapshot>> getcategories() async {
    return FirebaseFirestore.instance
        .collection("Categories")
        .snapshots();
  }

  Future addUserbooking(Map<String, dynamic> bookingInfoMap) async {
    return await FirebaseFirestore.instance
        .collection("booking")
        .add(bookingInfoMap);
  }

  Future<Stream<QuerySnapshot>> getBookings() async {
    return FirebaseFirestore.instance.collection("booking").snapshots();
  }

  // Future<Stream<QuerySnapshot>> getcategories() async {
  //   return await FirebaseFirestore.instance
  //       .collection("categories")
  //       .snapshots();
  // }

  Future deletebooking(String id) async {
    return await FirebaseFirestore.instance
        .collection("booking")
        .doc(id)
        .delete();
  }

  Future deletecategories(String id) async {
    return await FirebaseFirestore.instance
        .collection("categories")
        .doc(id)
        .delete();
  }

  Future<Stream<QuerySnapshot>> fetchitems() async {
    return FirebaseFirestore.instance
        .collection("baby_show_items")
        .snapshots();
  }

  Future<Stream<QuerySnapshot>> fetchcategory() async {
    return FirebaseFirestore.instance
        .collection("categories")
        .snapshots();
  }
}
