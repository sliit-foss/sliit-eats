import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enhanced_http/enhanced_http.dart';
import 'package:flutter/material.dart';
import 'package:sliit_eats/helpers/constants.dart';
import 'package:sliit_eats/main.dart';
import 'package:sliit_eats/models/general/error_message.dart';
import 'package:sliit_eats/models/general/success_message.dart';
import 'package:sliit_eats/models/order.dart';
import 'package:sliit_eats/models/product.dart';
import 'package:sliit_eats/models/user.dart';
import 'package:sliit_eats/services/firebase_services/firestore_service.dart';
import 'package:sliit_eats/services/product_service.dart';
import 'package:sliit_eats/services/user_service.dart';

class OrderService {
  static Future<List<Order>>? getOrders({dynamic filters}) async {
    await expireOrders();
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

  static Future<dynamic>? create(Product product, int quantity) async {
    String orderID = UniqueKey().toString();
    final res = await FirestoreService.write(
      'orders',
      {'id': orderID, 'product_id': product.id, 'user_id': currentLoggedInUser.userId, 'quantity': quantity, 'status': Constants.orderStatus[1], 'created_at': Timestamp.now()},
      'Order placed successfully',
    );
    print(res);
    if (res is SuccessMessage) {
      Future.delayed(Duration(minutes: Constants.expirationPeriod.toInt()), () => {updateOrderStatus(orderID, product.id, false, quantity)});
      await ProductService.updateUnitsLeftOfProduct(product.id, true, quantity);
      List<UserModel>? canteenUsers = await UserService.getCanteenUsers(product.canteen);
      List<String?> deviceTokens = canteenUsers!.map((e) => e.fcmToken).toList();
      EnhancedHttp.post(
          path: '/send-notification',
          successStatusCode: 200,
          payload: {"title": "Order Placed", "body": "Order placed for product ${product.name} by customer ${currentLoggedInUser.username} ( Quantity x $quantity )", "device_tokens": deviceTokens});
      return res;
    }
    return ErrorMessage('Sorry, unable to place this order');
  }

  static Future<dynamic>? updateOrderStatus(String orderId, String productId, bool isComplete, int units, {orderUserId, orderProductId}) async {
    List<dynamic> filters = [
      {'name': 'id', 'value': orderId}
    ];
    if (isComplete) {
      final res = await FirestoreService.update('orders', filters, {'status': Constants.orderStatus[2]});
      if (res is SuccessMessage) {
        UserModel? orderUser = await UserService.getUserById(orderUserId);
        Product? orderProduct = await ProductService.getProductById(orderProductId);
        EnhancedHttp.post(path: '/send-notification', successStatusCode: 200, payload: {
          "title": "Order Complete",
          "body": "Your order for product ${orderProduct!.name} has been completed.",
          "device_tokens": [orderUser!.fcmToken]
        });
      }
      return res;
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
      await ProductService.updateUnitsLeftOfProduct(response.data()['product_id'], false, response.data()['quantity']);
    }
    return res;
  }
}
