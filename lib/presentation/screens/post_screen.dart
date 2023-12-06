import 'package:dio/dio.dart';
import 'package:dio_http/data/repositories/implementations/dio_api_repository.dart';
import 'package:dio_http/data/repositories/implementations/http_api_repository.dart';
import 'package:dio_http/presentation/controllers/post_controller.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

// ignore: constant_identifier_names
const POST_ID_TO_LOAD = 4;

class PostScreen extends StatefulWidget {
  const PostScreen({Key? key}) : super(key: key);

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  late PostController _postCtrl;
  @override
  void initState() {
   // _postCtrl = PostController(DioApiRepository(dio: Dio())); //aqui esta chamando o dio

      _postCtrl = PostController(HttpApiRepository(client: Client())); // aqui esta chamando http

    WidgetsBinding.instance?.addPostFrameCallback((_) async {
      await _postCtrl.onLoadPost(POST_ID_TO_LOAD);
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Consumo de api com dio"),
      ),
      body: _postCtrl.isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : _postCtrl.getErrorLoadingPost == null
              ? Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text(
                        _postCtrl.getLoadedPost?.title ?? "",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        _postCtrl.getLoadedPost?.body ?? "",
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                )
              : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _postCtrl.getErrorLoadingPost!,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                          color: Colors.redAccent,
                        ),
                      ),
                      const SizedBox(height: 12),
                      ElevatedButton(
                        onPressed: () async {
                          await _postCtrl.onLoadPost(POST_ID_TO_LOAD);
                          setState(() {});
                        },
                        child: const Text("Tentar Novamente"),
                      ),
                    ],
                  ),
                ),
    );
  }
}
