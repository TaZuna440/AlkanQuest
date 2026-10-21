import 'package:flutter_test/flutter_test.dart';
import 'package:ipon_system/domain/services/xp_service.dart';

void main() {
  group('rankFor', () {
    test('rank bands match spec A4 thresholds', () {
      expect(XpService.rankFor(0).rank, 'E');
      expect(XpService.rankFor(499).rank, 'E');
      expect(XpService.rankFor(500).rank, 'D');
      expect(XpService.rankFor(1499).rank, 'D');
      expect(XpService.rankFor(1500).rank, 'C');
      expect(XpService.rankFor(3999).rank, 'C');
      expect(XpService.rankFor(4000).rank, 'B');
      expect(XpService.rankFor(9999).rank, 'B');
      expect(XpService.rankFor(10000).rank, 'A');
      expect(XpService.rankFor(24999).rank, 'A');
      expect(XpService.rankFor(25000).rank, 'S');
      expect(XpService.rankFor(999999).rank, 'S');
    });

    test('rank titles are Solo Leveling flavored', () {
      expect(XpService.rankFor(0).title, 'Ipon Beginner');
      expect(XpService.rankFor(25000).title, 'Legendary Saver');
    });
  });

  group('levelFor', () {
    test('level 1 below 1000 XP, +1 per 1000 XP', () {
      expect(XpService.levelFor(0), 1);
      expect(XpService.levelFor(999), 1);
      expect(XpService.levelFor(1000), 2);
      expect(XpService.levelFor(2500), 3);
    });
  });

  group('rankProgress / xpToNextRank', () {
    test('progress inside band', () {
      final p = XpService.rankProgress(320);
      expect(p.intoBand, 320);
      expect(p.bandSize, 500);
      expect(XpService.xpToNextRank(320), 180);
    });

    test('rank S is uncapped', () {
      final p = XpService.rankProgress(30000);
      expect(p.bandSize, -1);
      expect(XpService.xpToNextRank(30000), isNull);
    });
  });

  test('XP constants match spec A3', () {
    expect(XpService.checkinXp, 50);
    expect(XpService.completionXp, 500);
  });
}
