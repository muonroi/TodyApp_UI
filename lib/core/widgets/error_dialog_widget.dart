import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:tudy/l10n/app_localizations.dart';
import 'package:tudy/config/router.dart';
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
    ref.listen<AsyncValue<ErrorInfo>>(errorStateNotifierProvider,
        (previous, next) {
      if (next.hasError || next.isLoading) {
        return;
      }

      final errors = next.value ?? [];

      if (!_isDialogShowing && errors.isNotEmpty) {
        _isDialogShowing = true;

        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (!mounted) {
            _isDialogShowing = false;
            return;
          }

          final navigatorContext = rootNavigatorKey.currentContext;

          if (navigatorContext != null) {
            showDialog<void>(
              context: navigatorContext,
              barrierDismissible: false,
              builder: (dialogContext) {
                final l10n = AppLocalizations.of(dialogContext);
                final theme = Theme.of(dialogContext);
                final colorScheme = theme.colorScheme;
                final textTheme = theme.textTheme;

                return AlertDialog(
                  icon: Icon(Icons.error_outline_rounded,
                      color: colorScheme.error, size: 32),
                  title: Text(l10n.errorDialogTitle),
                  content: SizedBox(
                    width: double.maxFinite,
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                          maxHeight:
                              MediaQuery.of(dialogContext).size.height * 0.5),
                      child: ListView.separated(
                        shrinkWrap: true,
                        itemCount: errors.length,
                        separatorBuilder: (context, index) => Divider(
                          height: 16,
                          thickness: 1,
                          color:
                              theme.dividerTheme.color?.withValues(alpha: 0.5),
                        ),
                        itemBuilder: (context, index) {
                          final error = errors[index];
                          final errorCode =
                              error['errorCode'] ?? l10n.notAvailable;
                          final errorMessage = error['errorMessage'] ??
                              l10n.generalErrorOccurred;

                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (errorCode != l10n.notAvailable)
                                  Text(
                                    errorMessage,
                                    style: textTheme.bodyMedium?.copyWith(),
                                  ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  actionsPadding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(dialogContext).pop();
                      },
                      child: Text(l10n.closeButton),
                    ),
                  ],
                );
              },
            ).then((_) {
              if (mounted) {
                _isDialogShowing = false;

                ref.read(errorStateNotifierProvider.notifier).clearErrors();

                setState(() {});
              }
            });
          } else {
            if (mounted) {
              setState(() {
                _isDialogShowing = false;
              });
            }
          }
        });
      } else if (_isDialogShowing && errors.isEmpty) {}
    }, onError: (error, stack) {});

    return const SizedBox.shrink();
  }
}
