class ResponseModel
{
  bool status;
  String? message;
  Map<String, dynamic>? data;

  ResponseModel({
    required this.status,
    required this.data,
    required this.message,
  });
  factory ResponseModel.fromJson(Map<String, dynamic> jsonData)
  {
    return ResponseModel(
      status: jsonData['status'],
      data: jsonData['data'],
      message: jsonData['message'],
    );
  }
}
