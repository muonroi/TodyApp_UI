import 'package:flutter/foundation.dart';

class MResponse<T> {
  final T? result;
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
    return MResponse(
      result: json['result'] != null ? fromJson(json['result']) : null,
      id: json['id'] ?? '',
      utcTime: DateTime.parse(json['utcTime'].toString()),
      errorMessages: json['errorMessages'] != null
          ? (json['errorMessages'] as List)
              .map((item) => item['errorMessage'] as String)
              .toList()
          : [],
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

    // Kiểm tra kỹ hơn resultData và items
    if (resultData == null ||
        resultData is! Map ||
        resultData['items'] == null ||
        resultData['items'] is! List) {
      debugPrint(
          "MPagingResponse.fromJson Error: Invalid resultData or items structure.");
      debugPrint(
          "resultData type: ${resultData?.runtimeType}, items type: ${resultData?['items']?.runtimeType}");
      debugPrint("Full JSON result part: $resultData");
      throw Exception(
          "Invalid response structure from API (result or items missing/invalid)");
    }

    final List itemsSource = resultData['items'] as List;
    final List<T> items = []; // Tạo list trống để chứa kết quả parse

    // Dùng for loop để dễ dàng bắt lỗi từng item
    for (int i = 0; i < itemsSource.length; i++) {
      final itemData = itemsSource[i]; // Lấy dữ liệu thô của item thứ i
      try {
        // Cố gắng parse item này
        final parsedItem = fromJson(itemData);
        items.add(parsedItem); // Thêm vào list kết quả nếu thành công
      } catch (e, stackTrace) {
        // Nếu có lỗi xảy ra khi parse item thứ i
        debugPrint("-----------------------------------------------------");
        debugPrint(
            "MPagingResponse.fromJson Error: Failed to parse item at index $i.");
        debugPrint("Item Data: $itemData"); // In ra dữ liệu của item gây lỗi
        debugPrint("Error Type: ${e.runtimeType}");
        debugPrint("Error Message: $e");
        debugPrint("Stack Trace: $stackTrace");
        debugPrint("-----------------------------------------------------");

        // QUAN TRỌNG: Quyết định cách xử lý lỗi ở đây:
        // 1. Ném lỗi ra ngoài (hành vi mặc định, dừng parse):
        throw Exception(
            "Failed to parse item at index $i. Check debug console for details. Error: $e");
        // 2. Bỏ qua item lỗi và tiếp tục parse các item khác (có thể làm mất dữ liệu):
        // continue;
        // 3. Thêm một giá trị mặc định hoặc null vào list (nếu logic cho phép):
        // items.add(null); // Chỉ hoạt động nếu List<T> là List<T?>
      }
    }

    // Parse PagingInfo và ResponseInfo (giữ nguyên như cũ)
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
      errorMessages: json['errorMessages'] != null
          ? (json['errorMessages'] as List)
              .map((item) => item['errorMessage'] as String)
              .toList()
          : [],
      isOK: json['isOK'] ?? false,
    );

    return MPagingResponse<T>(
      result: items, // Trả về danh sách các item đã parse thành công
      pagingInfo: pagingInfo,
      responseInfo: responseInfo,
    );
  }
}
