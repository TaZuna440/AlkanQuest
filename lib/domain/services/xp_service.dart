/// XP, level, and rank rules.
///
/// Source of truth: README Section A3 (XP philosophy) and A4 (leveling & ranks).
/// XP rewards *consistency*, not amount, and is global (per user, not per quest).
class XpService {
  XpService._();

  /// XP for the first qualifying check-in of the day, per quest (A3).
  static const int checkinXp = 50;

  /// XP granted every time a quest is completed (A3).
  static const int completionXp = 500;

  /// Rank bands, Solo Leveling style (A4). Ordered low to high.
  static const List<RankBand> ranks = [
    RankBand(rank: 'E', minXp: 0, maxXp: 499, title: 'Ipon Beginner'),
    RankBand(rank: 'D', minXp: 500, maxXp: 1499, title: 'Consistent Saver'),
    RankBand(rank: 'C', minXp: 1500, maxXp: 3999, title: 'Challenge Hunter'),
    RankBand(rank: 'B', minXp: 4000, maxXp: 9999, title: 'Savings Warrior'),
    RankBand(rank: 'A', minXp: 10000, maxXp: 24999, title: 'Ipon Master'),
    RankBand(rank: 'S', minXp: 25000, maxXp: -1, title: 'Legendary Saver'),
  ];

  /// Rank band for a total XP value.
  static RankBand rankFor(int totalXp) {
    final xp = totalXp < 0 ? 0 : totalXp;
    for (final band in ranks) {
      if (band.maxXp < 0 || xp <= band.maxXp) return band;
    }
    return ranks.last;
  }

  /// Level: 1 + one level per 1,000 lifetime XP. (Team decision; spec is silent.)
  static int levelFor(int totalXp) => 1 + (totalXp < 0 ? 0 : totalXp) ~/ 1000;

  /// XP earned inside the current rank band, and the band's total size.
  /// [bandSize] is -1 for rank S (uncapped).
  static ({int intoBand, int bandSize}) rankProgress(int totalXp) {
    final band = rankFor(totalXp);
    if (band.maxXp < 0) return (intoBand: totalXp - band.minXp, bandSize: -1);
    return (
      intoBand: totalXp - band.minXp,
      bandSize: band.maxXp - band.minXp + 1,
    );
  }

  /// XP still needed to reach the next rank, or null at rank S.
  static int? xpToNextRank(int totalXp) {
    final band = rankFor(totalXp);
    if (band.maxXp < 0) return null;
    final idx = ranks.indexOf(band);
    if (idx >= ranks.length - 1) return null;
    return ranks[idx + 1].minXp - totalXp;
  }
}

/// One Solo Leveling-style rank band. [maxXp] of -1 means uncapped (rank S).
class RankBand {
  final String rank;
  final int minXp;
  final int maxXp;
  final String title;

  const RankBand({
    required this.rank,
    required this.minXp,
    required this.maxXp,
    required this.title,
  });
}
