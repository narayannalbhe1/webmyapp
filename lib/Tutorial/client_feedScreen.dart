import 'dart:developer';
import 'dart:ui';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';
import 'package:webmyapp/Tutorial/GlobalTourKey.dart';

class client_feedScreen extends StatefulWidget {
  const client_feedScreen({super.key});

  @override
  State<client_feedScreen> createState() => _client_feedScreenState();
}

class _client_feedScreenState extends State<client_feedScreen> {

  late TutorialCoachMark tutorialCoachMark;
  bool showingTutorial = false;
  List<TargetFocus> targets = [];

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(milliseconds: 500), () {
        if (mounted && !showingTutorial) {
          _createTutorial();
        }
      });
    });
  }

  @override
  void dispose() {
    if (showingTutorial) {
      tutorialCoachMark.finish();
    }
    showingTutorial = false;
    targets.clear();
    _scrollController.dispose();
    super.dispose();
  }

  void _createTutorial() {
    targets = [];
    int stepIndex = 0;

    final possibleTargets = [
      {
        'key': appBarKey,
        'identify': 'App Bar',
        'description':
            'This is the app bar with the title and navigation options.',
        'align': ContentAlign.bottom,
      },
      {
        'key': welcomeTextKey,
        'identify': 'Welcome Message',
        'description': 'This text welcomes you to the app.',
        'align': ContentAlign.bottom,
      },
      {
        'key': actionButtonKey,
        'identify': 'Action Button',
        'description': 'Click this button to perform an action.',
        'align': ContentAlign.top,
      },
      {
        'key': cardKey,
        'identify': 'Info Card',
        'description': 'This card displays important information.',
        'align': ContentAlign.bottom,
      },
    ];

    for (var target in possibleTargets) {
      final key = target['key'] as GlobalKey;
      if (key.currentContext != null) {
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

    tutorialCoachMark = TutorialCoachMark(
      targets: targets,
      colorShadow: Colors.black.withOpacity(0.4),
      imageFilter: ui.ImageFilter.blur(sigmaX: 8, sigmaY: 8), // Apply blur
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
        setState(() {
          showingTutorial = false;
        });
        log("Tutorial completed");
      },
      onSkip: () {
        tutorialCoachMark.finish();
        setState(() {
          showingTutorial = false;
        });
        log("Tutorial skipped");
        return true;
      },
      onClickTarget: (target) async {
        if (target.keyTarget?.currentContext != null) {
          await Scrollable.ensureVisible(
            target.keyTarget!.currentContext!,
            duration: const Duration(milliseconds: 400),
            curve: Curves.linear,
            alignment: 0.5,
          );
        }
      },
    );

    setState(() {
      showingTutorial = true;
    });
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
      borderSide: BorderSide(color: Colors.grey, width: 0.9),
      radius: 10,
      color: Colors.transparent, // Set transparent so we can simulate blur
      contents: [
        TargetContent(
          align: ContentAlign.bottom,

          builder: (context, controller) {
            return ClipRect(
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.6), // Darkened blur
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
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium?.copyWith(color: Colors.white),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        key: appBarKey,
        title: const Text("Static Tutorial Coach Demo"),
        backgroundColor: Colors.blue.shade700,
        elevation: 2,
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w600,
          fontFamily: 'Roboto',
        ),
      ),
      body: Stack(
        children: [
          if (showingTutorial) // Only apply blur when tutorial is active
            Container(
              color: Colors.black.withOpacity(0.2), // Optional tint
            ),
          SingleChildScrollView(
            controller: _scrollController,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.blue.shade700, size: 28),
                      const SizedBox(width: 8),
                      Text(
                        key: welcomeTextKey,
                        "Welcome to the App!",
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Colors.blue.shade900,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Discover amazing features below!",
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(height: 24),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    transform: Matrix4.identity()..scale(1.0),
                    child: ElevatedButton(
                      key: actionButtonKey,
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              "Action Button Clicked!",
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(color: Colors.white),
                            ),
                            backgroundColor: Colors.blue.shade700,
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue.shade600,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 16,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 5,
                        shadowColor: Colors.blue.shade200,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.touch_app, size: 20),
                          const SizedBox(width: 8),
                          Text(
                            "Perform Action",
                            style: Theme.of(
                              context,
                            ).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  InfoCardWidget(
                    key: cardKey,
                    title: "Info Card",
                    description: "This card contains important information about your app.",
                  ),

                  const SizedBox(height: 24),
                  Divider(color: Colors.blue.shade100, thickness: 1),
                  const SizedBox(height: 24),
                  Text(
                    "Explore More Content",
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      "Some more content to ensure scrolling works... Scroll down to explore additional features and information.",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ),
                  const SizedBox(height: 300),
                  Text(
                    "End of content",
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
          ),

        ],
      ),
    );
  }
}



class InfoCardWidget extends StatelessWidget {
  final String title;
  final String description;
  final Color iconColor;
  final Color textColor;
  final double fontSize;
  final Duration animationDuration;
  final double scale;

  const InfoCardWidget({
    Key? key,
    required this.title,
    required this.description,
    this.iconColor = Colors.blue,
    this.textColor = Colors.black,
    this.fontSize = 18,
    this.animationDuration = const Duration(milliseconds: 200),
    this.scale = 1.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: animationDuration,
      transform: Matrix4.identity()..scale(scale),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.info_outline,
                  color: Colors.blue,
                  size: 24,
                ),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: fontSize,
                    color: Colors.red,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              description,
              style: TextStyle(
                color: Colors.grey.shade800,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
