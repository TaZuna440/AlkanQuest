import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/color_palette.dart';
import '../../../core/theme/typography.dart';
import '../../../l10n/app_strings.dart';
import '../../../l10n/l10n_providers.dart';
import '../../achievements/presentation/achievements_screen.dart';
import '../../profile/presentation/profile_screen.dart';
import '../../status/presentation/status_screen.dart';
import 'dashboard_tab.dart';

/// Post-onboarding root: bottom navigation across the four main areas.
///
/// Tabs for phases not yet built show a "SYSTEM STANDBY" placeholder until
/// their phase lands; each phase replaces its placeholder with the real
/// screen (no navigation rewrite needed).
class MainShell extends ConsumerStatefulWidget {
  const MainShell({super.key});

  @override
  ConsumerState<MainShell> createState() => _MainShellState();
}

class _MainShellState extends ConsumerState<MainShell> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    final locale = ref.watch(localeProvider);
    final tabs = [
      _Tab(
        label: AppStrings.of(AppStrings.navDashboard, locale),
        icon: Icons.dashboard_outlined,
        activeIcon: Icons.dashboard,
      ),
      _Tab(
        label: AppStrings.of(AppStrings.navStatus, locale),
        icon: Icons.insights_outlined,
        activeIcon: Icons.insights,
      ),
      _Tab(
        label: AppStrings.of(AppStrings.navQuests, locale),
        icon: Icons.emoji_events_outlined,
        activeIcon: Icons.emoji_events,
      ),
      _Tab(
        label: AppStrings.of(AppStrings.navProfile, locale),
        icon: Icons.person_outline,
        activeIcon: Icons.person,
      ),
    ];
    return Scaffold(
      backgroundColor: IponColors.bgVoid,
      body: IndexedStack(
        index: _index,
        children: const [
          DashboardTab(),
          StatusScreen(),
          AchievementsScreen(),
          ProfileScreen(),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: IponColors.bgIndigo,
          border: Border(
            top: BorderSide(color: IponColors.frameOuter.withValues(alpha: 0.6)),
          ),
        ),
        child: BottomNavigationBar(
          currentIndex: _index,
          onTap: (i) => setState(() => _index = i),
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.transparent,
          elevation: 0,
          selectedItemColor: IponColors.frameOuter,
          unselectedItemColor: IponColors.textDim,
          selectedLabelStyle: IponTypography.label.copyWith(fontSize: 10),
          unselectedLabelStyle: IponTypography.label.copyWith(fontSize: 10),
          items: [
            for (final t in tabs)
              BottomNavigationBarItem(
                icon: Icon(t.icon),
                activeIcon: Icon(t.activeIcon),
                label: t.label,
              ),
          ],
        ),
      ),
    );
  }
}

class _Tab {
  final String label;
  final IconData icon;
  final IconData activeIcon;

  const _Tab({
    required this.label,
    required this.icon,
    required this.activeIcon,
  });
}
