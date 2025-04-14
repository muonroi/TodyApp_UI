import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/error_dialog_provider.dart';

class ErrorDialogWidget extends ConsumerStatefulWidget {
  const ErrorDialogWidget({super.key});

  @override
  ConsumerState<ErrorDialogWidget> createState() => _ErrorDialogWidgetState();
}

class _ErrorDialogWidgetState extends ConsumerState<ErrorDialogWidget> {
  bool _isDialogShowing = false;

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue<List<Map<String, String>>>>(
      errorStreamProvider,
      (previous, next) {
        next.whenData((errors) {
          if (!_isDialogShowing && errors.isNotEmpty) {
            _isDialogShowing = true;
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) {
                return AlertDialog(
                  title: const Text("Error List"),
                  content: SingleChildScrollView(
                    child: DataTable(
                      columns: const [
                        DataColumn(label: Text("Error Code")),
                        DataColumn(label: Text("Error Message")),
                      ],
                      rows: errors.map((error) {
                        return DataRow(cells: [
                          DataCell(Text(error['errorCode'] ?? "")),
                          DataCell(Text(error['errorMessage'] ?? "")),
                        ]);
                      }).toList(),
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        _isDialogShowing = false;
                      },
                      child: const Text("Close"),
                    )
                  ],
                );
              },
            );
          }
        });
      },
    );

    return const SizedBox.shrink();
  }
}
