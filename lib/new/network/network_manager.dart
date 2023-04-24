import 'dart:convert';
//import 'package:alice/alice.dart';
import 'package:auth_manager/new/cache/app_cache.dart';
import 'package:auth_manager/new/network/parser.dart';

import 'package:dio/dio.dart';

class NetworkManager {
  //static Alice? alice = Alice(
  //    showNotification: true, showInspectorOnShake: true, darkTheme: false);

  late Dio dio;
  CancelToken? cancelToken;

  Map<String, dynamic> headers = {
    "Accept": "application/json",
    "Content-Type": "application/json"
  };

  NetworkManager({this.cancelToken}) {
    dio = new Dio();
    dio.options = BaseOptions(headers: headers);
    dio.interceptors.add(LogInterceptor(
      requestBody: true,
      request: true,
      requestHeader: true,
      responseBody: true,
      responseHeader: false,
    ));
    //if (alice != null) dio.interceptors.add(alice!.getDioInterceptor());
  }

  void _updateHeaders() {
    if (AppCache.instance.getUserModel() != null) {
      String? token = AppCache.instance.getUserModel()!.data!.token;
      if (token != null) {
        headers['Authorization'] = "Bearer $token";
      }
    }
/*
    var lang = AppCache.instance.getLanguage();
    if (lang != null) {
      headers['Accept-Language'] = lang;
    }*/
  }

  Future<T?> get<T>(String url, {Map<String, dynamic>? params}) async {
    _updateHeaders();
    if (params == null) params = {};
    print(params);

    Response response = await dio.get(url,
        queryParameters: params,
        cancelToken: cancelToken,
        options: Options(headers: headers));
    print(response.statusCode);
    print("*************");
    return parseResponse<T>(response);
  }

  Future<List<T>?> getList<T>(String url,
      {Map<String, dynamic>? params}) async {
    _updateHeaders();
    if (params == null) params = {};

    Response response = await dio.get(url,
        queryParameters: params,
        cancelToken: cancelToken,
        options: Options(headers: headers));
    return parseListResponse<T>(response);
  }

  Future<T?> post<T>(String url, {Map<String, dynamic>? body}) async {
    _updateHeaders();
    if (body == null) body = {};
    print(body);

    var formData = json.encode(body);
    Response response = await dio.post(url,
        cancelToken: cancelToken,
        options: Options(headers: headers),
        data: formData);

    return parseResponse<T>(response);
  }

  Future<Response> put<T>(String url, {Map<String, dynamic>? body}) async {
    _updateHeaders();
    if (body == null) body = {};

    var formData = json.encode(body);
    Response response = await dio.put(url,
        cancelToken: cancelToken,
        options: Options(headers: headers),
        data: formData);
    return response;
  }

  Future<Response> postString(String url, String body) async {
    _updateHeaders();
    print(body);

    Response response = await dio.post(url,
        cancelToken: cancelToken,
        options: Options(headers: headers),
        data: body);

    return response;
  }

  Future<T?> patch<T>(String url, {Map<String, dynamic>? body}) async {
    _updateHeaders();
    if (body == null) body = {};

    Response response = await dio.patch(url,
        queryParameters: body,
        cancelToken: cancelToken,
        options: Options(headers: headers));

    return parseResponse<T>(response);
  }

  Future<T?> delete<T>(String url, {Map<String, dynamic>? params}) async {
    _updateHeaders();
    if (params == null) params = {};
//    print(params);

    Response response = await dio.delete(url,
        queryParameters: params,
        cancelToken: cancelToken,
        options: Options(headers: headers));

    return parseResponse<T>(response);
  }

  Future<T?> uploadFile<T>(
      String url, Map<String, dynamic> multipartFile) async {
    _updateHeaders();
    FormData formData = FormData.fromMap(multipartFile);
    Response response = await dio.post(url,
        cancelToken: cancelToken,
        options: Options(headers: headers),
        data: formData);
    return parseResponse<T>(response);
  }

  T? parseResponse<T>(Response response) {
    print("here status code ${response.statusCode}");

    if (response.statusCode != 200 && response.statusCode != 201) return null;

    var map;
    print("here parse first");

    if (T == null || T == dynamic) {
      print("here parse map $map");

      return response.data;
    } else {
      map = response.data;
      print("here parse map $map");
    }

    return Parser.parse<T>(map);
  }

  List<T>? parseListResponse<T>(Response response) {
    if (response.statusCode != 200) return null;

    var map;
    if (T == null || T == dynamic) {
      return response.data;
    } else {
      map = response.data;
    }

    List<T> list = [];

    (map as List).forEach((m) {
      list.add(Parser.parse<T>(m));
    });

    return list;
  }
}
