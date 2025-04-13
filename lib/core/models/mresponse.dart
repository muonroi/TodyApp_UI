class MResponse<T> {
  final T result;
  final String id;
  final DateTime utcTime;
  final List<String> errorMessages;
  final bool isOK;

  MResponse({
    required this.result,
    required this.id,
    required this.utcTime,
    required this.errorMessages,
    required this.isOK,
  });

  factory MResponse.fromJson(
      Map<String, dynamic> json, T Function(dynamic data) fromJson) {
    if (json['result'] == null) {
      throw Exception("Invalid response structure from API");
    }
    return MResponse(
      result: fromJson(json['result']),
      id: json['id'] ?? '',
      utcTime: DateTime.parse(json['utcTime'].toString()),
      errorMessages: List<String>.from(json['errorMessages'] ?? []),
      isOK: json['isOK'] ?? false,
    );
  }
}

class PagingInfo {
  final int currentPage;
  final int pageCount;
  final int pageSize;
  final int rowCount;
  final int firstRowOnPage;
  final int lastRowOnPage;

  PagingInfo({
    required this.currentPage,
    required this.pageCount,
    required this.pageSize,
    required this.rowCount,
    required this.firstRowOnPage,
    required this.lastRowOnPage,
  });

  factory PagingInfo.fromJson(Map<String, dynamic> json) {
    return PagingInfo(
      currentPage: json['currentPage'] ?? 0,
      pageCount: json['pageCount'] ?? 0,
      pageSize: json['pageSize'] ?? 0,
      rowCount: json['rowCount'] ?? 0,
      firstRowOnPage: json['firstRowOnPage'] ?? 0,
      lastRowOnPage: json['lastRowOnPage'] ?? 0,
    );
  }
}

class MPagingResponse<T> {
  final List<T> result;
  final PagingInfo pagingInfo;
  final MResponse<dynamic> responseInfo;

  MPagingResponse({
    required this.result,
    required this.pagingInfo,
    required this.responseInfo,
  });

  factory MPagingResponse.fromJson(
      Map<String, dynamic> json, T Function(dynamic data) fromJson) {
    final resultData = json['result'];
    if (resultData == null || resultData['items'] == null) {
      throw Exception("Invalid response structure from API");
    }
    final items =
        (resultData['items'] as List).map((item) => fromJson(item)).toList();
    final pagingInfo = PagingInfo.fromJson({
      'currentPage': resultData['currentPage'],
      'pageCount': resultData['pageCount'],
      'pageSize': resultData['pageSize'],
      'rowCount': resultData['rowCount'],
      'firstRowOnPage': resultData['firstRowOnPage'],
      'lastRowOnPage': resultData['lastRowOnPage'],
    });
    final responseInfo = MResponse(
      result: null,
      id: json['id'] ?? '',
      utcTime: DateTime.parse(json['utcTime'].toString()),
      errorMessages: List<String>.from(json['errorMessages'] ?? []),
      isOK: json['isOK'] ?? false,
    );
    return MPagingResponse<T>(
      result: items,
      pagingInfo: pagingInfo,
      responseInfo: responseInfo,
    );
  }
}
