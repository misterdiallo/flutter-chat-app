class APIResponse<T> {
  final data;
  final bool error;
  final errorMessage;
  APIResponse({this.data, this.error = false, this.errorMessage});
}
