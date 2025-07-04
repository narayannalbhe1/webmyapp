import 'package:flutter/material.dart';
import 'package:webmyapp/Tutorial/GlobalTourKey.dart';

class animated_navbar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const animated_navbar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      backgroundColor: Colors.white,
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.grey,
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(
          icon: Container(
            padding: const EdgeInsets.all(8.0),
            child: const Icon(Icons.feed),
          ),
          label: 'Feed',
        ),
        BottomNavigationBarItem(
          icon: Container(
            key: postInvestKey,
            padding: const EdgeInsets.all(8.0),
            child: const Icon(Icons.account_balance_wallet),
          ),
          label: 'Investments',
        ),
        BottomNavigationBarItem(
          icon: Container(
            key: accountKey,
            padding: const EdgeInsets.all(8.0),
            child: const Icon(Icons.account_circle),
          ),
          label: 'Account',
        ),
      ],
      selectedLabelStyle: const TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 12,
      ),
      unselectedLabelStyle: const TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 12,
      ),
    );
  }
}