import 'package:dio/dio.dart';

class DioInstance {
  DioInstance._();
  static final DioInstance shared = DioInstance._();

  factory DioInstance() {
    return shared;
  }

  final Dio _dioInstance = Dio();

  Dio get dioInstance => _dioInstance;

  Future<Response> exec(String endpoint, Map<String, dynamic> queryParameters, Map<String, dynamic> data, String method, Function(int sent, int total) onSendProgress) async {
    Map<String, dynamic> headers = {
      "Content-Type": "application/json; charset=utf-8",
    };

    return await _dioInstance.request(
      endpoint,
      queryParameters: queryParameters,
      data: data,
      options: Options(
        method: method,
        headers: headers,
      ),
      onSendProgress: onSendProgress,
    );
  }

  Future<Response> fetchAllPokemon() async {
    return await exec(
      "https://pokeapi.co/api/v1/pokemon",
      {
        "limit": 100000,
        "offset": 0,
      },
      {},
      "GET",
      (sent, total) {},
    );
  }

  Future<Response> fetchSinglePokemon(String pokemon) async {
    return await exec(
      "https://pokeapi.co/api/v1/pokemon/$pokemon",
      {},
      {},
      "GET",
      (sent, total) {},
    );
  }
}