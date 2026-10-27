/// Key UI strings in English and Filipino (Phase 11).
///
/// "At minimum key strings": bottom-nav labels, screen titles, main headers,
/// and primary buttons are localized. Everything else stays in the
/// System-voice English of the theme.
class AppStrings {
  AppStrings._();

  static const supported = ['en', 'fil'];

  static String of(String key, String locale) =>
      _localized[locale]?[key] ?? _localized['en']![key] ?? key;

  // Key constants (so call sites don't hand-type raw strings).
  static const navDashboard = 'nav_dashboard';
  static const navStatus = 'nav_status';
  static const navQuests = 'nav_quests';
  static const navProfile = 'nav_profile';

  static const statusTitle = 'status_title';
  static const achievementsTitle = 'achievements_title';
  static const profileTitle = 'profile_title';
  static const dashboardActiveQuests = 'dashboard_active_quests';
  static const dashboardNoQuests = 'dashboard_no_quests';
  static const dashboardNoQuestsBody = 'dashboard_no_quests_body';
  static const newQuest = 'new_quest';
  static const createQuest = 'create_quest';
  static const logSavings = 'log_savings';
  static const selectQuest = 'select_quest';
  static const iSavedIt = 'i_saved_it';
  static const suggested = 'suggested';
  static const remaining = 'remaining';
  static const totalSaved = 'total_saved';
  static const dailyStreak = 'daily_streak';
  static const questsCleared = 'quests_cleared';
  static const welcomeBack = 'welcome_back';
  static const checkinTitle = 'checkin_title';
  static const confirmSavings = 'confirm_savings';
  static const cancel = 'cancel';
  static const confirm = 'confirm';
  static const close = 'close';
  static const save = 'save';
  static const questDetail = 'quest_detail';
  static const checkinHistory = 'checkin_history';
  static const editQuest = 'edit_quest';
  static const cancelQuest = 'cancel_quest';
  static const deleteQuest = 'delete_quest';
  static const editQuestTitle = 'edit_quest_title';
  static const saveChanges = 'save_changes';
  static const lifetimeStats = 'lifetime_stats';
  static const xpTimeline = 'xp_timeline';

  static const _localized = <String, Map<String, String>>{
    'en': {
      navDashboard: 'DASHBOARD',
      navStatus: 'STATUS',
      navQuests: 'QUESTS',
      navProfile: 'PROFILE',
      statusTitle: 'STATUS',
      achievementsTitle: 'ACHIEVEMENTS',
      profileTitle: 'PROFILE',
      dashboardActiveQuests: '◆ ACTIVE QUESTS',
      dashboardNoQuests: 'NO ACTIVE QUESTS',
      dashboardNoQuestsBody:
          'Accept your first quest to begin your Ipon journey.',
      newQuest: '+ NEW QUEST',
      createQuest: '+ CREATE QUEST',
      logSavings: "LOG TODAY'S SAVINGS",
      selectQuest: 'SELECT A QUEST',
      iSavedIt: '+ I SAVED IT',
      suggested: 'SUGGESTED',
      remaining: 'REMAINING',
      totalSaved: 'TOTAL SAVED',
      dailyStreak: 'DAILY STREAK',
      questsCleared: 'QUESTS CLEARED',
      welcomeBack: 'WELCOME BACK',
      checkinTitle: 'SAVINGS CHECK-IN',
      confirmSavings: 'CONFIRM SAVINGS',
      cancel: 'CANCEL',
      confirm: 'CONFIRM',
      close: 'CLOSE',
      save: 'SAVE',
      questDetail: 'QUEST DETAIL',
      checkinHistory: '◆ CHECK-IN HISTORY',
      editQuest: 'EDIT QUEST',
      cancelQuest: 'CANCEL QUEST',
      deleteQuest: 'DELETE QUEST',
      editQuestTitle: 'EDIT QUEST',
      saveChanges: 'SAVE CHANGES',
      lifetimeStats: '◆ LIFETIME STATS',
      xpTimeline: '◆ XP TIMELINE',
    },
    'fil': {
      navDashboard: 'DASHBOARD',
      navStatus: 'STATUS',
      navQuests: 'MGA QUEST',
      navProfile: 'PROFILE',
      statusTitle: 'STATUS',
      achievementsTitle: 'MGA ACHIEVEMENT',
      profileTitle: 'PROFILE',
      dashboardActiveQuests: '◆ MGA AKTIBONG QUEST',
      dashboardNoQuests: 'WALANG AKTIBONG QUEST',
      dashboardNoQuestsBody:
          'Tanggapin ang iyong unang quest para simulan ang iyong pag-iipon.',
      newQuest: '+ BAGONG QUEST',
      createQuest: '+ GUMAWA NG QUEST',
      logSavings: 'I-LOG ANG IPON NGAYON',
      selectQuest: 'PUMILI NG QUEST',
      iSavedIt: '+ NAG-IPON AKO',
      suggested: 'MUNGKAHI',
      remaining: 'NATITIRA',
      totalSaved: 'KABUUANG NAIPON',
      dailyStreak: 'ARAWANG STREAK',
      questsCleared: 'NA-CLEAR NA QUEST',
      welcomeBack: 'MALIGAYANG PAGBABALIK',
      checkinTitle: 'PAG-IPON CHECK-IN',
      confirmSavings: 'KUMPIRMAHIN ANG IPON',
      cancel: 'KANSELAHIN',
      confirm: 'KUMPIRMAHIN',
      close: 'ISARA',
      save: 'I-SAVE',
      questDetail: 'DETALYE NG QUEST',
      checkinHistory: '◆ KASAYSAYAN NG CHECK-IN',
      editQuest: 'I-EDIT ANG QUEST',
      cancelQuest: 'KANSELAHIN ANG QUEST',
      deleteQuest: 'BURAHIN ANG QUEST',
      editQuestTitle: 'I-EDIT ANG QUEST',
      saveChanges: 'I-SAVE ANG MGA PAGBABAGO',
      lifetimeStats: '◆ MGA STATS SA BUONG PANAHON',
      xpTimeline: '◆ TIMELINE NG XP',
    },
  };
}
