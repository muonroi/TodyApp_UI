import 'package:flutter/material.dart';
import 'package:tudy/features/home/data/enums/priority_level.dart';
import 'package:tudy/l10n/app_localizations.dart';

class PriorityInfo {
  final Color color;
  final String Function(AppLocalizations l10n) getLabel;
  final IconData icon;

  const PriorityInfo({
    required this.color,
    required this.getLabel,
    this.icon = Icons.flag,
  });
}

final Map<PriorityLevel, PriorityInfo> priorityInfoMap = {
  PriorityLevel.p1: PriorityInfo(
    color: Colors.red,
    getLabel: (l10n) => l10n.priority1,
  ),
  PriorityLevel.p2: PriorityInfo(
    color: Colors.orange,
    getLabel: (l10n) => l10n.priority2,
  ),
  PriorityLevel.p3: PriorityInfo(
    color: Colors.blue,
    getLabel: (l10n) => l10n.priority3,
  ),
  PriorityLevel.p4: PriorityInfo(
    color: Colors.grey,
    getLabel: (l10n) => l10n.priority4,
  ),
};

const PriorityLevel defaultPriority = PriorityLevel.p4;
