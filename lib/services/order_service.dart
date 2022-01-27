import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sliit_eats/helpers/constants.dart';
import 'package:sliit_eats/models/order.dart';
import 'package:sliit_eats/models/user.dart';
import 'package:sliit_eats/services/firebase_services/firestore_service.dart';
import 'package:sliit_eats/services/user_service.dart';
import 'auth_service.dart';

class OrderService {
  static Future<List<Order>>? getOrders({dynamic filters}) async {
    List<dynamic> sorts = [
      {'name': 'created_at', 'descending': true}
    ];
    final responseDocs = await FirestoreService.read(
        'orders', filters != null ? filters : [],
        sorts: sorts);
    List<Order> orders = [];
    for (dynamic responseDoc in responseDocs) {
      UserModel? user =
          await UserService.getUserById(responseDoc.data()['user_id']);
      dynamic extraData = {'username': user!.username};
      orders.add(Order.fromDocumentSnapshot(responseDoc, extraData));
    }
    return orders;
  }

  static Future<dynamic>? create(String productId, int quantity) async {
    UserModel? currentUser = await AuthService.getCurrentUserDetails();
    return await FirestoreService.write(
      'orders',
      {
        'id': UniqueKey().toString(),
        'product_id': productId,
        'user_id': currentUser!.userId,
        'status': Constants.orderStatus[1],
        'created_at': Timestamp.now()
      },
      'Order placed successfully',
    );
  }
}
