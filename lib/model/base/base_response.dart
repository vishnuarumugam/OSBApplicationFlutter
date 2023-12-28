class BaseResponse{
  int? statusCode;
  String? message;

  BaseResponse(
    {
      required this.statusCode,
      required this.message
    }
  );
}