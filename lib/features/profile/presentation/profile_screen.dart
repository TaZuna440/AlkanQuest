import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/notification_providers.dart';
import '../../../core/providers/repository_providers.dart';
import '../../../core/services/export_service.dart';
import '../../../core/services/notification_service.dart';
import '../../../core/theme/color_palette.dart';
import '../../../core/theme/system_window_frame.dart';
import '../../../core/theme/typography.dart';
import '../../../core/utils/validators.dart';
import '../../../core/widgets/system_button.dart';
import '../../../core/widgets/system_confirm_dialog.dart';
import '../../../core/widgets/system_notice_dialog.dart';
import '../../../data/database/app_database.dart';
import '../../../domain/services/xp_service.dart';
import '../../../l10n/app_strings.dart';
import '../../../l10n/l10n_providers.dart';
import '../../../l10n/system_voice.dart';
import '../../challenges/providers/challenge_providers.dart';

/// Phase 11 — Profile & settings: display name, language (EN/FIL),
/// system voice toggle, notification toggle + reminder time, rounding
/// rules, privacy note, about, and CSV export.
class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(profileProvider).value;
    final locale = ref.watch(localeProvider);
    String t(String key) => AppStrings.of(key, locale);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: SystemWindowFrame(
            title: t(AppStrings.profileTitle),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _PlayerCard(profile: profile),
                const SizedBox(height: 20),
                _SectionTitle('SETTINGS'),
                const SizedBox(height: 8),
                _LanguageRow(profile: profile),
                const SizedBox(height: 8),
                _SystemVoiceRow(profile: profile),
                const SizedBox(height: 8),
                _NotificationsRow(profile: profile),
                const SizedBox(height: 8),
                _ReminderTimeRow(profile: profile),
                const SizedBox(height: 20),
                _SectionTitle('ROUNDING RULES'),
                const SizedBox(height: 8),
                const _InfoBox(
                  lines: [
                    'Suggested per-period amounts round UP:',
                    '• DAILY — nearest ₱10',
                    '• WEEKLY — nearest ₱50',
                    '• MONTHLY — nearest ₱100',
                  ],
                ),
                const SizedBox(height: 20),
                _SectionTitle('PRIVACY NOTE'),
                const SizedBox(height: 8),
                const _InfoBox(
                  lines: [
                    'All your data stays on this device.',
                    'No account, no cloud sync, no tracking.',
                    'Export a CSV anytime to take your history with you.',
                  ],
                ),
                const SizedBox(height: 20),
                _SectionTitle('EXPORT DATA'),
                const SizedBox(height: 8),
                _ExportButtons(),
                const SizedBox(height: 20),
                _SectionTitle('ABOUT'),
                const SizedBox(height: 8),
                const _InfoBox(
                  lines: [
                    'IPON SYSTEM v1.0.0',
                    'Level up your savings.',
                    '',
                    'A gamified savings habit app — not a bank,',
                    'not a wallet, not financial advice.',
                    'Built by the AlkanQuest team as a school final project.',
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String text;
  const _SectionTitle(this.text);

  @override
  Widget build(BuildContext context) =>
      Text('\u25C6 $text', style: IponTypography.label);
}

class _InfoBox extends StatelessWidget {
  final List<String> lines;
  const _InfoBox({required this.lines});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        border: Border.all(
          color: IponColors.frameInner.withValues(alpha: 0.4),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final l in lines)
            Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Text(
                l.isEmpty ? ' ' : l,
                style: IponTypography.body.copyWith(fontSize: 14),
              ),
            ),
        ],
      ),
    );
  }
}

class _PlayerCard extends ConsumerWidget {
  final UserProfile? profile;
  const _PlayerCard({required this.profile});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final name = profile?.displayName ?? 'HUNTER';
    final level = profile?.level ?? 1;
    final rank = profile?.rank ?? 'E';
    final title = XpService.rankFor(profile?.totalXp ?? 0).title;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: IponColors.frameOuter, width: 2),
        boxShadow: [
          BoxShadow(
            color: IponColors.frameOuter.withValues(alpha: 0.3),
            blurRadius: 12,
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: IponColors.gold, width: 2),
            ),
            child: Center(
              child: Text(
                name.isEmpty ? '?' : name[0].toUpperCase(),
                style:
                    IponTypography.windowTitle.copyWith(color: IponColors.gold),
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: IponTypography.header),
                const SizedBox(height: 4),
                Text(
                  'LV $level · RANK $rank — ${title.toUpperCase()}',
                  style: IponTypography.label
                      .copyWith(fontSize: 11, color: IponColors.gold),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () => _editName(context, ref, name),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                border: Border.all(color: IponColors.frameOuter),
              ),
              child: const Text('EDIT', style: IponTypography.label),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _editName(
      BuildContext context, WidgetRef ref, String current) async {
    final newName = await showDialog<String>(
      context: context,
      builder: (_) => _EditNameDialog(initialName: current),
    );
    if (newName != null && newName.isNotEmpty && context.mounted) {
      await ref.read(profileRepositoryProvider).updateDisplayName(newName);
    }
  }
}

/// Edit-display-name dialog. Owns its [TextEditingController] and disposes
/// it in [State.dispose]. Disposing the controller from the caller right
/// after `showDialog` returns crashed the app: the dialog route is still
/// animating out at that point, so its text field was still mounted
/// (framework assertion: _dependents.isEmpty is not true).
class _EditNameDialog extends StatefulWidget {
  final String initialName;
  const _EditNameDialog({required this.initialName});

  @override
  State<_EditNameDialog> createState() => _EditNameDialogState();
}

class _EditNameDialogState extends State<_EditNameDialog> {
  late final TextEditingController _controller;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialName);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onSave() {
    if (_formKey.currentState!.validate()) {
      Navigator.of(context).pop(_controller.text.trim());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(24),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: IponColors.bgIndigo,
          border: Border.all(color: IponColors.frameOuter, width: 2),
        ),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text('DISPLAY NAME',
                  style: IponTypography.windowTitle,
                  textAlign: TextAlign.center),
              const SizedBox(height: 16),
              TextFormField(
                controller: _controller,
                style: IponTypography.value,
                maxLength: 24,
                cursorColor: IponColors.frameOuter,
                validator: IponValidators.validateDisplayName,
                decoration: InputDecoration(
                  counterStyle: IponTypography.label
                      .copyWith(fontSize: 10, color: IponColors.textDim),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: IponColors.frameInner.withValues(alpha: 0.5),
                    ),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: IponColors.frameOuter),
                  ),
                  errorBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: IponColors.danger),
                  ),
                  focusedErrorBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: IponColors.danger),
                  ),
                  errorStyle:
                      IponTypography.label.copyWith(color: IponColors.danger),
                ),
              ),
              const SizedBox(height: 12),
              SystemButton(label: 'SAVE', onPressed: _onSave),
              const SizedBox(height: 8),
              SystemButton(
                label: 'CANCEL',
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SettingsRow extends StatelessWidget {
  final String label;
  final String? hint;
  final Widget control;
  const _SettingsRow({
    required this.label,
    required this.control,
    this.hint,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        border: Border.all(
          color: IponColors.frameInner.withValues(alpha: 0.4),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label,
                    style: IponTypography.header.copyWith(fontSize: 14)),
                if (hint != null) ...[
                  const SizedBox(height: 2),
                  Text(hint!,
                      style: IponTypography.label
                          .copyWith(fontSize: 10, color: IponColors.textDim)),
                ],
              ],
            ),
          ),
          control,
        ],
      ),
    );
  }
}

class _LanguageRow extends ConsumerWidget {
  final UserProfile? profile;
  const _LanguageRow({required this.profile});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = profile?.locale ?? 'en';
    return _SettingsRow(
      label: 'LANGUAGE / WIKA',
      hint: 'Key screens switch between English and Filipino.',
      control: Row(
        children: [
          _LangChip(
            label: 'EN',
            selected: locale == 'en',
            onTap: () => ref.read(profileRepositoryProvider).updateLocale('en'),
          ),
          const SizedBox(width: 8),
          _LangChip(
            label: 'FIL',
            selected: locale == 'fil',
            onTap: () =>
                ref.read(profileRepositoryProvider).updateLocale('fil'),
          ),
        ],
      ),
    );
  }
}

class _LangChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;
  const _LangChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          border: Border.all(
            color: selected
                ? IponColors.frameOuter
                : IponColors.frameInner.withValues(alpha: 0.4),
            width: selected ? 2 : 1,
          ),
        ),
        child: Text(
          label,
          style: IponTypography.label.copyWith(
            color: selected ? IponColors.textPrimary : IponColors.textDim,
          ),
        ),
      ),
    );
  }
}

class _SystemVoiceRow extends ConsumerWidget {
  final UserProfile? profile;
  const _SystemVoiceRow({required this.profile});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final enabled = profile?.systemVoiceEnabled ?? true;
    return _SettingsRow(
      label: 'SYSTEM VOICE',
      hint: enabled
          ? 'Dramatic Solo Leveling flavor.'
          : 'Plain wording, no drama.',
      control: Switch(
        value: enabled,
        activeThumbColor: IponColors.frameOuter,
        onChanged: (v) =>
            ref.read(profileRepositoryProvider).updateSystemVoice(v),
      ),
    );
  }
}

class _NotificationsRow extends ConsumerWidget {
  final UserProfile? profile;
  const _NotificationsRow({required this.profile});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final enabled = profile?.notificationsEnabled ?? false;
    return _SettingsRow(
      label: 'DAILY REMINDERS',
      hint: 'A System nudge to log your check-in.',
      control: Switch(
        value: enabled,
        activeThumbColor: IponColors.frameOuter,
        onChanged: (v) => _toggle(context, ref, v),
      ),
    );
  }

  Future<void> _toggle(BuildContext context, WidgetRef ref, bool on) async {
    final repo = ref.read(profileRepositoryProvider);
    final notifs = ref.read(notificationServiceProvider);
    final profile = await repo.getOrCreate();

    if (!on) {
      await repo.updateNotificationsEnabled(false);
      await notifs.cancelDailyReminder();
      return;
    }

    // Soft gate: after two declines, point at system settings instead.
    if (profile.notificationDeclineCount >= 2) {
      if (!context.mounted) return;
      await SystemNoticeDialog.show(
        context,
        title: 'REMINDERS BLOCKED',
        lines: const [
          'NOTIFICATIONS WERE DECLINED TWICE.',
          'ENABLE THEM IN SYSTEM SETTINGS TO USE REMINDERS.',
        ],
        accent: IponColors.warning,
      );
      return;
    }

    if (!context.mounted) return;
    final wantIt = await SystemConfirmDialog.show(
      context,
      title: 'DAILY REMINDERS',
      message:
          'The System will nudge you once a day to log your check-in. Enable reminders?',
      confirmLabel: 'ENABLE',
      accent: IponColors.frameOuter,
    );
    if (!wantIt || !context.mounted) return;

    final granted = await notifs.requestPermission();
    if (granted) {
      await repo.updateNotificationsEnabled(true);
      final p = await repo.getOrCreate();
      await notifs.scheduleDailyReminder(
        NotificationService.parseReminderTime(p.dailyReminderTime),
        body: SystemVoice.reminderBody(
          dramatic: p.systemVoiceEnabled,
          locale: p.locale,
        ),
      );
    } else {
      await repo.recordNotificationDecline();
      if (!context.mounted) return;
      await SystemNoticeDialog.show(
        context,
        title: 'PERMISSION DENIED',
        lines: const [
          'THE SYSTEM CANNOT REACH YOU.',
          'YOU CAN ENABLE REMINDERS LATER IN SETTINGS.',
        ],
        accent: IponColors.warning,
      );
    }
  }
}

class _ReminderTimeRow extends ConsumerWidget {
  final UserProfile? profile;
  const _ReminderTimeRow({required this.profile});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hhmm = profile?.dailyReminderTime ?? '20:00';
    final time = NotificationService.parseReminderTime(hhmm);
    final label =
        '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
    return _SettingsRow(
      label: 'REMINDER TIME',
      hint: 'When the daily nudge arrives.',
      control: InkWell(
        onTap: () => _pick(context, ref, time),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            border: Border.all(color: IponColors.frameOuter),
          ),
          child:
              Text(label, style: IponTypography.value.copyWith(fontSize: 14)),
        ),
      ),
    );
  }

  Future<void> _pick(
      BuildContext context, WidgetRef ref, TimeOfDay current) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: current,
      helpText: 'REMINDER TIME',
      builder: (context, child) => Theme(
        data: ThemeData.dark().copyWith(
          colorScheme: const ColorScheme.dark(
            primary: IponColors.frameOuter,
            onPrimary: IponColors.textPrimary,
            surface: IponColors.bgIndigo,
            onSurface: IponColors.textPrimary,
          ),
          dialogTheme:
              const DialogThemeData(backgroundColor: IponColors.bgIndigo),
        ),
        child: child!,
      ),
    );
    if (picked == null || !context.mounted) return;
    final repo = ref.read(profileRepositoryProvider);
    await repo
        .updateReminderTime(NotificationService.formatReminderTime(picked));
    final profile = await repo.getOrCreate();
    if (profile.notificationsEnabled) {
      await ref.read(notificationServiceProvider).scheduleDailyReminder(
            picked,
            body: SystemVoice.reminderBody(
              dramatic: profile.systemVoiceEnabled,
              locale: profile.locale,
            ),
          );
    }
  }
}

class _ExportButtons extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SystemButton(
          label: 'EXPORT QUESTS (CSV)',
          onPressed: () => _exportQuests(context, ref),
        ),
        const SizedBox(height: 8),
        SystemButton(
          label: 'EXPORT CHECK-INS (CSV)',
          onPressed: () => _exportCheckins(context, ref),
        ),
      ],
    );
  }

  Future<void> _exportQuests(BuildContext context, WidgetRef ref) async {
    final repo = ref.read(challengeRepositoryProvider);
    final all = [
      ...await repo.watchAll().first,
    ];
    if (!context.mounted) return;
    if (all.isEmpty) {
      await SystemNoticeDialog.show(
        context,
        title: 'NOTHING TO EXPORT',
        lines: const ['NO QUESTS YET.'],
        accent: IponColors.warning,
      );
      return;
    }
    await ExportService.exportQuestsCsv(all);
  }

  Future<void> _exportCheckins(BuildContext context, WidgetRef ref) async {
    final savingsRepo = ref.read(savingsRepositoryProvider);
    final challengeRepo = ref.read(challengeRepositoryProvider);
    final records = await savingsRepo.getAll();
    if (!context.mounted) return;
    if (records.isEmpty) {
      await SystemNoticeDialog.show(
        context,
        title: 'NOTHING TO EXPORT',
        lines: const ['NO CHECK-INS YET.'],
        accent: IponColors.warning,
      );
      return;
    }
    final quests = await challengeRepo.watchAll().first;
    final names = {for (final q in quests) q.id: q.name};
    if (!context.mounted) return;
    await ExportService.exportCheckinsCsv(records, names);
  }
}
