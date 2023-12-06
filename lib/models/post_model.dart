import 'dart:convert';

class PostModel {
  final int id;
  final String title;
  final String body;

  PostModel({required this.id, required this.title, required this.body});

  factory PostModel.fromMap(Map<String, dynamic> map) { //dio ja transforma o json para um map faz o decode por baixo dos panos
    return PostModel(
      id: map["id"],
      title: map["title"],
      body: map["body"],
    );
  }

  factory PostModel.fromJson(String source) => PostModel.fromMap( // aqui e o http mais simples porem precisa do json.decode
        json.decode(source),
      );
}

