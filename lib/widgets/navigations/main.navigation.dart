import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tie_time_front/pages/account.page.dart';
import 'package:tie_time_front/pages/analyse.page.dart';
import 'package:tie_time_front/pages/main.page.dart';
import 'package:tie_time_front/pages/configuration.page.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const MainPage(),
    const AnalysePage(),
    const ConfigurationPage(),
    const AccountPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/icons/home.svg',
                colorFilter:
                    ColorFilter.mode(Color(0xFFBFBEBE), BlendMode.srcIn),
                width: 40,
                height: 40),
            activeIcon: SvgPicture.asset('assets/icons/home.svg',
                colorFilter:
                    ColorFilter.mode(Color(0xFF2E7984), BlendMode.srcIn),
                width: 40,
                height: 40),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/icons/analyse.svg',
                colorFilter:
                    ColorFilter.mode(Color(0xFFBFBEBE), BlendMode.srcIn),
                width: 40,
                height: 40),
            activeIcon: SvgPicture.asset('assets/icons/analyse.svg',
                colorFilter:
                    ColorFilter.mode(Color(0xFF2E7984), BlendMode.srcIn),
                width: 40,
                height: 40),
            label: 'Analyse',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/icons/configuration.svg',
                colorFilter:
                    ColorFilter.mode(Color(0xFFBFBEBE), BlendMode.srcIn),
                width: 40,
                height: 40),
            activeIcon: SvgPicture.asset('assets/icons/configuration.svg',
                colorFilter:
                    ColorFilter.mode(Color(0xFF2E7984), BlendMode.srcIn),
                width: 40,
                height: 40),
            label: 'Configuration',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/icons/account.svg',
                colorFilter:
                    ColorFilter.mode(Color(0xFFBFBEBE), BlendMode.srcIn),
                width: 40,
                height: 40),
            activeIcon: SvgPicture.asset('assets/icons/account.svg',
                colorFilter:
                    ColorFilter.mode(Color(0xFF2E7984), BlendMode.srcIn),
                width: 40,
                height: 40),
            label: 'Account',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
