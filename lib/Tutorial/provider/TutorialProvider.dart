import 'dart:developer';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';
import 'package:webmyapp/Tutorial/GlobalTourKey.dart';

class TutorialProvider with ChangeNotifier {
  bool _hasShownTutorial = false;
  bool get hasShownTutorial => _hasShownTutorial;

  void showTutorial(
      BuildContext context,
      List<GlobalKey> keys, {
        ScrollController? scrollController,
      }) {
    if (_hasShownTutorial) return;

    final possibleTargets = [

      {
        'key': keys.contains(appBarKey) ? appBarKey : null,
        'identify': 'App Bar',
        'description': 'This is the app bar with the title and navigation options.',
        'align': ContentAlign.bottom,
      },
      {
        'key': keys.contains(welcomeTextKey) ? welcomeTextKey : null,
        'identify': 'Welcome Message',
        'description': 'This text welcomes you to the app.',
        'align': ContentAlign.bottom,
      },
      {
        'key': keys.contains(actionButtonKey) ? actionButtonKey : null,
        'identify': 'Action Button',
        'description': 'Click this button to perform an action.',
        'align': ContentAlign.top,
      },
      {
        'key': keys.contains(cardKey) ? cardKey : null,
        'identify': 'Info Card',
        'description': 'This card displays important information.',
        'align': ContentAlign.bottom,
      },
      {
        'key': keys.contains(postInvestKey) ? postInvestKey : null,
        'identify': 'Investments Tab',
        'description': 'Tap here to view your investments.',
        'align': ContentAlign.bottom,
      },
      {
        'key': keys.contains(investmentKey) ? investmentKey : null,
        'identify': 'Investment Values',
        'description': 'View your total investment and returns here.',
        'align': ContentAlign.bottom,
      },
      {
        'key': keys.contains(portfolioInsighKey) ? portfolioInsighKey : null,
        'identify': 'Portfolio Insights',
        'description': 'Explore insights about your portfolio performance.',
        'align': ContentAlign.bottom,
      },
      {
        'key': keys.contains(portfolioCardKey) ? portfolioCardKey : null,
        'identify': 'Portfolio',
        'description': 'See your individual portfolio items.',
        'align': ContentAlign.bottom,
      },
      {
        'key': keys.contains(accountKey) ? accountKey : null,
        'identify': 'Account Tab',
        'description': 'Tap here to view your account details.',
        'align': ContentAlign.bottom,
      },
      {
        'key': keys.contains(userInfoKey) ? userInfoKey : null,
        'identify': 'Account Details',
        'description': 'View your account information here.',
        'align': ContentAlign.bottom,
      },
      {
        'key': keys.contains(settingsKey) ? settingsKey : null,
        'identify': 'Settings',
        'description': 'Access your settings here.',
        'align': ContentAlign.bottom,
      },
    ];

    final targets = <TargetFocus>[];
    int stepIndex = 0;

    for (var target in possibleTargets) {
      final key = target['key'] as GlobalKey?;
      if (key != null && key.currentContext != null) {
        targets.add(
          _buildTarget(
            key,
            target['identify'] as String,
            target['description'] as String,
            target['align'] as ContentAlign,
            stepIndex++,
          ),
        );
      }
    }

    log("Targets added: ${targets.length}");
    if (targets.isEmpty) {
      log("No valid targets for tutorial");
      return;
    }

    final tutorialCoachMark = TutorialCoachMark(
      targets: targets,
      colorShadow: Colors.black.withOpacity(0.4),
      imageFilter: ui.ImageFilter.blur(sigmaX: 8, sigmaY: 8),
      textSkip: 'SKIP',
      paddingFocus: 10,
      textStyleSkip: const TextStyle(
        color: Colors.blue,
        fontWeight: FontWeight.bold,
        fontSize: 16,
        fontFamily: 'Roboto',
      ),
      opacityShadow: 0.8,
      onFinish: () {
        _hasShownTutorial = true;
        notifyListeners();
        log("Tutorial completed");
      },
      onSkip: () {
        _hasShownTutorial = true;
        notifyListeners();
        log("Tutorial skipped");
        return true;
      },
      onClickTarget: (target) async {
        if (target.keyTarget?.currentContext != null && scrollController != null) {
          await Scrollable.ensureVisible(
            target.keyTarget!.currentContext!,
            duration: const Duration(milliseconds: 400),
            curve: Curves.linear,
            alignment: 0.5,
          );
        }
      },
    );

    _hasShownTutorial = true;
    notifyListeners();
    tutorialCoachMark.show(context: context);
  }

  TargetFocus _buildTarget(
      GlobalKey key,
      String identify,
      String description,
      ContentAlign align,
      int stepIndex,
      ) {
    return TargetFocus(
      identify: identify,
      keyTarget: key,
      alignSkip: Alignment.topRight,
      enableOverlayTab: false,
      shape: ShapeLightFocus.Circle,
      borderSide: const BorderSide(color: Colors.grey, width: 0.9),
      radius: 10,
      color: Colors.transparent,
      contents: [
        TargetContent(
          align: align,
          builder: (context, controller) {
            return ClipRect(
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      identify,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      description,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: Colors.white),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        if (stepIndex > 0)
                          ElevatedButton(
                            onPressed: () {
                              controller.previous();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              side: const BorderSide(color: Colors.white),
                            ),
                            child: const Text(
                              'Prev',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        const SizedBox(width: 10),
                        ElevatedButton(
                          onPressed: () {
                            controller.next();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                          ),
                          child: const Text(
                            'Next',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  void resetTutorial() {
    _hasShownTutorial = false;
    notifyListeners();
  }
}