class DataResponse<T> {
  bool status;
  T? data;
  final String message;

  DataResponse(
      {required this.data, required this.message, required this.status});

  factory DataResponse.success(T items) {
    return DataResponse(data: items, message: "", status: true);
  }
  factory DataResponse.error(String message) {
    return DataResponse(data: null, message: message, status: false);
  }
}
