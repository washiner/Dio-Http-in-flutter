import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:dio_http/data/repositories/api_repository.dart';
import 'package:dio_http/data/repositories/errors/api_exception.dart';
import 'package:dio_http/models/post_model.dart';

class DioApiRepository implements ApiRepository{
  final Dio _dio;

  DioApiRepository({required Dio dio}) : _dio = dio;
  @override
  Future<PostModel?> getPost(int postId) async {
    try{
      final url = "$API_URL/posts/$postId";

      //await Future.delayed(Duration(seconds: 5)); // -> simulando o acesso externo que leva uns segundos
      final response = await _dio.get(url);

      //throw ApiException(messege: "Servidor fora do ar"); //-> simula um erro de conectar a api


      return PostModel.fromMap(response.data);

    }on DioException catch(dioError){
      throw ApiException(messege: dioError.message ?? "Erro ao carregar API");

    }catch(error, stacktrace){
      log("Erro ao fazer get do post", error: error, stackTrace: stacktrace);

      throw ApiException(messege: "Erro ao carregar post");
    }
  }
  
}