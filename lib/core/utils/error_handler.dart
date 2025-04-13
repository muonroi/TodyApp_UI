import 'package:fluttertoast/fluttertoast.dart';
import '../providers/error_dialog_provider.dart';

void showErrorArrayMessage(
    List<dynamic> errors, ErrorDialogService errorDialogService) {
  if (errors.isNotEmpty) {
    final formattedErrors = errors.expand<Map<String, String>>((err) {
      if (err is Map &&
          err.containsKey('errorValues') &&
          err['errorValues'] is List &&
          (err['errorValues'] as List).isNotEmpty) {
        return (err['errorValues'] as List)
            .map<Map<String, String>>((errorMessage) {
          return {
            'errorCode': err['errorCode'] ?? 'Validation Error',
            'errorMessage': errorMessage.toString(),
          };
        });
      } else {
        return [
          {
            'errorCode': err['errorCode'] ?? 'Unknown Error',
            'errorMessage': err['errorMessage'] ?? 'No details provided.',
          }
        ];
      }
    }).toList();

    errorDialogService.show(formattedErrors);
  } else {
    Fluttertoast.showToast(msg: 'Unknown Error');
  }
}
