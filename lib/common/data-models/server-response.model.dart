class ServerResponse {
  Object data;
  String msg;
  String status;

  ServerResponse({
    required this.data,
    required this.status,
    required this.msg,
  });
}

class ServerDataArrayResponse {
  List data;
  String msg;
  String status;

  ServerDataArrayResponse(
      {required this.data, required this.status, required this.msg});
}
