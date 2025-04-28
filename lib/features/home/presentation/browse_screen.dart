import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tudy/features/home/presentation/providers/locale_provider.dart';
import 'package:tudy/l10n/app_localizations.dart';

class BrowseScreen extends ConsumerWidget {
  const BrowseScreen({super.key});

  void _showLanguagePicker(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final currentLocale = ref.read(localeProvider);

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text(l10n.language),
          content: SingleChildScrollView(
            child: ListBody(
              children: AppLocalizations.supportedLocales.map((locale) {
                String languageName;
                switch (locale.languageCode) {
                  case 'en':
                    languageName = 'English';
                    break;
                  case 'vi':
                    languageName = 'Tiếng Việt';
                    break;

                  default:
                    languageName = locale.languageCode;
                }

                return RadioListTile<Locale>(
                  title: Text(languageName),
                  value: locale,
                  groupValue: currentLocale,
                  onChanged: (Locale? newValue) {
                    if (newValue != null) {
                      ref.read(localeProvider.notifier).setLocale(newValue);
                      Navigator.of(dialogContext).pop();
                    }
                  },
                );
              }).toList(),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(l10n.cancel),
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _confirmDeleteAccount(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text(l10n.deleteAccount),
          content: Text(l10n.deleteAccountConfirmation),
          actions: <Widget>[
            TextButton(
              child: Text(l10n.cancel),
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                  foregroundColor: Theme.of(context).colorScheme.error),
              onPressed: () {
                Navigator.of(dialogContext).pop();

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content: Text(l10n.deleteAccountRequestSentPlaceholder)),
                );
              },
              child: Text(l10n.delete),
            ),
          ],
        );
      },
    );
  }

  void _confirmLogout(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text(l10n.logout),
          content: Text(l10n.logoutConfirmation),
          actions: <Widget>[
            TextButton(
              child: Text(l10n.cancel),
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                  foregroundColor: Theme.of(context).colorScheme.error),
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
              child: Text(l10n.logout),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);

    final currentLocale = ref.watch(localeProvider);

    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      children: [
        ListTile(
          leading: const Icon(Icons.language),
          title: Text(l10n.language),
          subtitle: Text(currentLocale.languageCode),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          onTap: () => _showLanguagePicker(context, ref),
        ),
        const Divider(),
        ListTile(
          leading: Icon(Icons.person_remove,
              color: Theme.of(context).colorScheme.error),
          title: Text(l10n.deleteAccount,
              style: TextStyle(color: Theme.of(context).colorScheme.error)),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          onTap: () => _confirmDeleteAccount(context, ref),
        ),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.logout),
          title: Text(l10n.logout),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          onTap: () => _confirmLogout(context, ref),
        ),
        const Divider(),
      ],
    );
  }
}
