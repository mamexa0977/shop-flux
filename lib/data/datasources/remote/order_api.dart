// import 'package:dio/dio.dart';
// import '../../../core/constants/api_endpoints.dart';
// import '../../models/order_request.dart';
// import '../../models/order_response.dart';

// class OrderApi {
//   final Dio _dio;
//   OrderApi(this._dio);

//   // Create order (already exists)
//   Future<OrderResponse> createOrder(OrderRequest request) async {
//     final response = await _dio.post(ApiEndpoints.orders, data: request.toJson());
//     return OrderResponse.fromJson(response.data['data']);
//   }

//   // Get all my orders
//   Future<List<OrderResponse>> getMyOrders() async {
//     final response = await _dio.get(ApiEndpoints.orders);
//     final List<dynamic> ordersJson = response.data['data']['orders'];
//     return ordersJson.map((json) => OrderResponse.fromJson(json)).toList();
//   }

//   // Get single order by ID
//   Future<OrderResponse> getOrderById(int orderId) async {
//     final response = await _dio.get('${ApiEndpoints.orders}/$orderId');
//     return OrderResponse.fromJson(response.data['data']['order']);
//   }

//   // Cancel order (only if status is pending)
//   Future<OrderResponse> cancelOrder(int orderId) async {
//     final response = await _dio.patch('${ApiEndpoints.orders}/$orderId/cancel');
//     return OrderResponse.fromJson(response.data['data']['order']);
//   }

//   // Request return (only if status is delivered)
//   Future<Map<String, dynamic>> requestReturn(int orderId, String reason) async {
//     final response = await _dio.post('${ApiEndpoints.orders}/$orderId/return', data: {'reason': reason});
//     return response.data['data'];
//   }

//   // Download invoice (returns PDF URL or file data)
//   Future<String> getInvoiceUrl(int orderId) async {
//     final response = await _dio.get('${ApiEndpoints.orders}/$orderId/invoice');
//     // Assuming backend returns a URL or file path; adjust as needed
//     return response.data['data']['invoiceUrl'] ?? '';
//   }
// }
import 'package:dio/dio.dart';
import '../../../core/constants/api_endpoints.dart';
import '../../models/order_request.dart';
import '../../models/order.dart';
import '../../models/order_response.dart';
import '../../models/payment_init.dart';

class OrderApi {
  final Dio _dio;
  OrderApi(this._dio);

  // Create order – returns OrderResponse (may contain payment data)
  Future<OrderResponse> createOrder(OrderRequest request) async {
    final response = await _dio.post(ApiEndpoints.orders, data: request.toJson());
    final data = response.data['data'];
    return OrderResponse(
      order: Order.fromJson(data['order']),
      payment: data['checkoutUrl'] != null
          ? PaymentInit(checkoutUrl: data['checkoutUrl'])
          : null,
    );
  }


  // Get all my orders – returns List<Order>
  Future<List<Order>> getMyOrders() async {
    final response = await _dio.get(ApiEndpoints.orders);
    final List<dynamic> ordersJson = response.data['data']['orders'];
    return ordersJson.map((json) => Order.fromJson(json)).toList();
  }

  // Get single order by ID – returns Order
  Future<Order> getOrderById(int orderId) async {
    final response = await _dio.get('${ApiEndpoints.orders}/$orderId');
    return Order.fromJson(response.data['data']['order']);
  }

  // Cancel order
  Future<Order> cancelOrder(int orderId) async {
    final response = await _dio.patch('${ApiEndpoints.orders}/$orderId/cancel');
    return Order.fromJson(response.data['data']['order']);
  }

  // Request return
Future<Map<String, dynamic>> requestReturn(int orderId, String reason, List<int> itemIds) async {
  final response = await _dio.post(
    '${ApiEndpoints.orders}/$orderId/return',
    data: {'reason': reason, 'itemIds': itemIds},
  );
  return response.data['data'];
}

  // Get invoice URL
  Future<String> getInvoiceUrl(int orderId) async {
    final response = await _dio.get('${ApiEndpoints.orders}/$orderId/invoice');
    return response.data['data']['invoiceUrl'] ?? '';
  }
}