/// The System's voice: dramatic Solo Leveling flavor vs plain wording,
/// in English or Filipino (Phase 11 settings: system voice toggle + locale).
///
/// [dramatic] comes from `UserProfile.systemVoiceEnabled`,
/// [locale] from `UserProfile.locale` ('en' | 'fil').
class SystemVoice {
  SystemVoice._();

  static String checkinTitle(
          {required bool dramatic, required String locale}) =>
      _pick(
        dramatic: dramatic,
        locale: locale,
        enDramatic: '[ CHECK-IN RECORDED ]',
        enPlain: 'Check-in recorded',
        filDramatic: '[ NAITALA ANG CHECK-IN ]',
        filPlain: 'Naitala ang check-in',
      );

  static String questCompleteTitle(
          {required bool dramatic, required String locale}) =>
      _pick(
        dramatic: dramatic,
        locale: locale,
        enDramatic: '[ QUEST COMPLETE ]',
        enPlain: 'Quest complete',
        filDramatic: '[ NATAPOS ANG QUEST ]',
        filPlain: 'Natapos ang quest',
      );

  static String questCancelTitle(
          {required bool dramatic, required String locale}) =>
      _pick(
        dramatic: dramatic,
        locale: locale,
        enDramatic: '[ QUEST CANCELLED ]',
        enPlain: 'Cancel quest',
        filDramatic: '[ KINANSELA ANG QUEST ]',
        filPlain: 'Kanselahin ang quest',
      );

  static String firstCheckinLine(
          {required bool dramatic, required String locale}) =>
      _pick(
        dramatic: dramatic,
        locale: locale,
        enDramatic: '+50 XP — FIRST CHECK-IN TODAY',
        enPlain: '+50 XP — first check-in today',
        filDramatic: '+50 XP — UNANG CHECK-IN NGAYONG ARAW',
        filPlain: '+50 XP — unang check-in ngayong araw',
      );

  static String noXpLine({required bool dramatic, required String locale}) =>
      _pick(
        dramatic: dramatic,
        locale: locale,
        enDramatic: 'NO XP — ALREADY CHECKED IN TODAY',
        enPlain: 'No XP — already checked in today',
        filDramatic: 'WALANG XP — NAKAPAG-CHECK-IN NA NGAYONG ARAW',
        filPlain: 'Walang XP — nakapag-check-in ka na ngayong araw',
      );

  static String levelUpLine(int n,
          {required bool dramatic, required String locale}) =>
      _pick(
        dramatic: dramatic,
        locale: locale,
        enDramatic: '\u25C6 LEVEL UP! NOW LV $n',
        enPlain: 'Level up! You are now level $n',
        filDramatic: '\u25C6 LEVEL UP! LV $n NA!',
        filPlain: 'Level up! Level $n ka na',
      );

  static String rankUpLine(String rank, String title,
          {required bool dramatic, required String locale}) =>
      _pick(
        dramatic: dramatic,
        locale: locale,
        enDramatic: '\u25C6 RANK UP! RANK $rank — $title',
        enPlain: 'Rank up! You are now rank $rank ($title)',
        filDramatic: '\u25C6 RANK UP! RANK $rank — $title',
        filPlain: 'Rank up! Rank $rank ka na ($title)',
      );

  static String achievementTitle(
          {required bool dramatic, required String locale}) =>
      _pick(
        dramatic: dramatic,
        locale: locale,
        enDramatic: '[ ACHIEVEMENT UNLOCKED ]',
        enPlain: 'Achievement unlocked',
        filDramatic: '[ NAKA-UNLOCK NG ACHIEVEMENT ]',
        filPlain: 'Naka-unlock ng achievement',
      );

  static String reminderBody(
          {required bool dramatic, required String locale}) =>
      _pick(
        dramatic: dramatic,
        locale: locale,
        enDramatic:
            'Your quests await, Hunter. Log today\u2019s check-in.',
        enPlain: 'Time to log your daily savings check-in.',
        filDramatic:
            'Naghihintay ang iyong mga quest, Hunter. I-log ang check-in mo ngayong araw.',
        filPlain: 'Oras na para i-log ang iyong pang-araw-araw na ipon.',
      );

  static String milestoneBody(double m, String questName,
          {required bool dramatic, required String locale}) =>
      _pick(
        dramatic: dramatic,
        locale: locale,
        enDramatic: _enMilestoneDramatic(m, questName),
        enPlain: _enMilestonePlain(m, questName),
        filDramatic: _filMilestoneDramatic(m, questName),
        filPlain: _filMilestonePlain(m, questName),
      );

  // ------------------------------------------------------------- internals

  static String _pick({
    required bool dramatic,
    required String locale,
    required String enDramatic,
    required String enPlain,
    required String filDramatic,
    required String filPlain,
  }) {
    if (locale == 'fil') return dramatic ? filDramatic : filPlain;
    return dramatic ? enDramatic : enPlain;
  }

  static String _enMilestoneDramatic(double m, String q) {
    final pct = (m * 100).round();
    if (m >= 1.0) return '"$q" cleared! The System acknowledges your discipline.';
    if (m >= 0.9) return '"$q" is $pct% complete. One final push, Hunter.';
    return '"$q" reached $pct%. Keep the streak alive.';
  }

  static String _enMilestonePlain(double m, String q) {
    final pct = (m * 100).round();
    if (m >= 1.0) return '"$q" is complete. Well done.';
    return '"$q" is $pct% complete.';
  }

  static String _filMilestoneDramatic(double m, String q) {
    final pct = (m * 100).round();
    if (m >= 1.0) {
      return 'Na-clear ang "$q"! Kinikilala ng System ang iyong disiplina.';
    }
    if (m >= 0.9) return '$pct% na ang "$q". Isang tulak pa, Hunter.';
    return 'Umabot na sa $pct% ang "$q". Ituloy ang streak.';
  }

  static String _filMilestonePlain(double m, String q) {
    final pct = (m * 100).round();
    if (m >= 1.0) return 'Tapos na ang "$q". Mahusay!';
    return 'Ang "$q" ay $pct% na.';
  }
}
