import 'package:dio_http/data/repositories/api_repository.dart';
import 'package:dio_http/data/repositories/errors/api_exception.dart';
import 'package:dio_http/models/post_model.dart';

class PostController {
  final ApiRepository apiRepository;

  PostController(this.apiRepository);

//caso de algum erro ao carregar o post , mostrar ao usuario
  String? _errorLoadingPost;

//get do erro loading post
  String? get getErrorLoadingPost => _errorLoadingPost;

//mostrar o circular progress indicator
  bool isLoading = true;

//post que vamos carregar
  PostModel? _loadedPost;

  PostModel? get getLoadedPost => _loadedPost;

  Future<void> onLoadPost(int postId) async {
    isLoading = true;
    _errorLoadingPost = null;

    try{
      final post = await apiRepository.getPost(postId);
      _loadedPost = post;
    } on ApiException catch(apiException){
      _errorLoadingPost = apiException.messege;
    }catch(error){
      _errorLoadingPost = "Erro ao carregar o post";
    }
    isLoading = false;
  }
}
