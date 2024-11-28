import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:realestate/common/data-models/error-response.model.dart';
import 'package:realestate/common/data-models/server-response.model.dart';
import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';

abstract class BaseService {
  final http.Client client = http.Client();
  final Logger logger = Logger('BaseService');

  Future<ServerResponse> requestWrapper(
    Future<http.Response> Function() requestFunc,
    String logMessage,
  ) async {
    try {
      final response = await requestFunc().timeout(const Duration(seconds: 10));
      final data = jsonDecode(response.body);
      print(logMessage);
      print(data);
      return ServerResponse(
        data: data['data'] ?? data,
        msg: data['message'],
        status: data['status'],
      );
    } on SocketException catch (e) {
      logger.severe('$logMessage: No internet connection', e);
      print(e);
      throw ErrorResponse("No internet connection");
    } on HttpException catch (e) {
      logger.severe('$logMessage: Service not currently available', e);
      print(e);
      throw ErrorResponse("Service not currently available");
    } on TimeoutException catch (e) {
      logger.severe('$logMessage: Poor internet connection or timeout', e);
      print(e);
      throw ErrorResponse("Poor internet connection");
    } catch (e) {
      logger.severe('$logMessage: Something went wrong', e);
      print(e);
      throw ErrorResponse("Something went wrong. Try again");
    }
  }

  Map<String, String> getHeaders(String? token, {String? contentType}) {
    return {
      'Content-Type': contentType ?? 'application/json',
      if (token != null) 'Authorization': "Bearer $token",
    };
  }
}
