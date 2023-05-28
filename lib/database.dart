import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:mechanics/models/customer.dart';
import 'package:mechanics/models/part.dart';

class Database {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<List<Customer>?> getCustomers() async {
    try {
      var doc = await _firestore.collection('customers').get();

      List<Customer> customers = [];
      for (var element in doc.docs) {
        customers.add(Customer.fromMap(element.data()));
      }
      return customers;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  Future<List<PartChange>?> getParts() async {
    try {
      var doc = await _firestore.collection('parts').get();

      List<PartChange> parts = [];
      for (var element in doc.docs) {
        parts.add(PartChange.fromMap(element.data()));
      }
      return parts;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  Future<void> addCustomerPartChange(
      Customer customer, PartChange partChange) async {
    try {
      await _firestore
          .collection("customers")
          .where("name", isEqualTo: customer.name)
          .get()
          .then((value) async {
        List<PartChange> updatedPartChanges = customer.partChanges;
        updatedPartChanges.add(partChange);
        await value.docs.first.reference.update({
          "partChanges": updatedPartChanges.map((x) => x.toMap()).toList()
        }).then((value) {
          log("DONE");
        });
      });
    } catch (e) {
      log("ERROR :::: $e");
      debugPrint(e.toString());
      // rethrow;
    }
  }

  Future<void> addCustomer(Customer customer) async {
    try {
      await _firestore.collection("customers").add(customer.toMap());
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<void> addPart(PartChange part) async {
    try {
      await _firestore.collection("parts").add(part.toMap());
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }
}
