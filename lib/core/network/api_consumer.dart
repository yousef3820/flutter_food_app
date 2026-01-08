abstract class ApiConsumer {
  Future<dynamic>get(
    String path,
    {
      Object? data,
      Map<String,dynamic>?queryParametes
    }
  );

  Future<dynamic>delete(
    String path,
    {
      Object? data,
      Map<String,dynamic>?queryParametes
    }
  );

  Future<dynamic>post(
    String path,
    {
      Object? data,
      Map<String,dynamic>?queryParametes
    }
  );

  Future<dynamic>patch(
    String path,
    {
      Object? data,
      Map<String,dynamic>?queryParametes
    }
  );
}