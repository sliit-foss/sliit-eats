import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sliit_eats/helpers/constants.dart';
import 'package:sliit_eats/main.dart';
import 'package:sliit_eats/models/general/error_message.dart';
import 'package:sliit_eats/models/general/success_message.dart';
import 'package:sliit_eats/models/order.dart';
import 'package:sliit_eats/models/user.dart';
import 'package:sliit_eats/services/firebase_services/firestore_service.dart';
import 'package:sliit_eats/services/product_service.dart';
import 'package:sliit_eats/services/user_service.dart';

class OrderService {
  static Future<List<Order>>? getOrders({dynamic filters}) async {
    dynamic res = await expireOrders();
    List<dynamic> sorts = [
      {'name': 'created_at', 'descending': true}
    ];
    final responseDocs = await FirestoreService.read('orders', filters != null ? filters : [], sorts: sorts);
    List<Order> orders = [];
    for (dynamic responseDoc in responseDocs) {
      UserModel? user = await UserService.getUserById(responseDoc.data()['user_id']);
      dynamic extraData = {'username': user!.username};
      orders.add(Order.fromDocumentSnapshot(responseDoc, extraData));
    }
    return orders;
  }

  static Future<dynamic>? create(String productId, int quantity) async {
    dynamic res = await ProductService.updateUnitsLeftOfProduct(productId, true, quantity);
    String orderID = UniqueKey().toString();
    Future.delayed(Duration(minutes: Constants.expirationPeriod.toInt()), () => {updateOrderStatus(orderID, productId, false, quantity)});
    if (res is SuccessMessage)
      return await FirestoreService.write(
        'orders',
        {'id': orderID, 'product_id': productId, 'user_id': currentLoggedInUser.userId, 'quantity': quantity, 'status': Constants.orderStatus[1], 'created_at': Timestamp.now()},
        'Order placed successfully',
      );
    else
      return ErrorMessage('Sorry, unable to place this order');
  }

  static Future<dynamic>? updateOrderStatus(String orderId, String productId, bool isComplete, int units) async {
    List<dynamic> filters = [
      {'name': 'id', 'value': orderId}
    ];
    if (isComplete) {
      return await FirestoreService.update('orders', filters, {'status': Constants.orderStatus[2]});
    } else {
      await ProductService.updateUnitsLeftOfProduct(productId, false, units);
      return await FirestoreService.update('orders', filters, {'status': Constants.orderStatus[3]});
    }
  }

  static dynamic expireOrders() async {
    final responses = await FirestoreService.queryTimestampAndStatus('orders', 'created_at', Duration(minutes: Constants.expirationPeriod.toInt()), Constants.orderStatus[1] ?? '');
    dynamic res;
    for (dynamic response in responses) {
      res = await FirestoreService.update('orders', [
        {'name': 'id', 'value': response.data()['id']}
      ], {
        'status': Constants.orderStatus[3]
      });
    }
    return res;
  }
}
