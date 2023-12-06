class ApiException implements Exception{
  final String messege;

  ApiException({required this.messege});
}