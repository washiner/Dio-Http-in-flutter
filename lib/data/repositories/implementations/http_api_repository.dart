import 'dart:developer';

import 'package:dio_http/data/repositories/api_repository.dart';
import 'package:dio_http/data/repositories/errors/api_exception.dart';
import 'package:dio_http/models/post_model.dart';
import 'package:http/http.dart';

class HttpApiRepository implements ApiRepository {
  final Client _client;

  HttpApiRepository({required Client client}) : _client = client;
  @override
  Future<PostModel?> getPost(int postId) async {
    try {
      final url = "$API_URL/posts/$postId";
      final response = await _client.get(Uri.parse(url));
      // await Future.delayed(Duration(seconds: 5)); // -> simulando o acesso externo que leva uns segundos

      //throw ApiException(messege: "Servidor fora do ar"); //-> simula um erro de conectar a api

      if (response.statusCode == 200) {
        return PostModel.fromJson(response.body);
      } else {
        throw ApiException(messege: "Erro ao carregar post");
      }
    } catch (error, stacktrace) {
      log("erro ao fazer get do post", error: error, stackTrace: stacktrace);
      throw ApiException(messege: "Erro ao carregarpost");
    }
  }
}
