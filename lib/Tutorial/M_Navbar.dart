import 'package:flutter/material.dart';
import 'package:webmyapp/Tutorial/client_feedScreen.dart';
import 'package:webmyapp/Tutorial/animated_navbar.dart';
import 'package:webmyapp/Tutorial/my_account.dart';
import 'package:webmyapp/Tutorial/my_investment.dart';

class m_navbar extends StatefulWidget {
  const m_navbar({super.key});

  @override
  State<m_navbar> createState() => _m_navbarState();
}

class _m_navbarState extends State<m_navbar> {
  int _selectedIndex = 0;

  // List of screens to display
  static List<Widget> _screens = [
    const client_feedScreen(),
    my_investment(),
    const my_account(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: animated_navbar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}