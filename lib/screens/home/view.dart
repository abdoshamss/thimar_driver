import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thimar_driver/screens/home/screens/home.dart';
import 'package:thimar_driver/screens/home/screens/my_account.dart';
import 'package:thimar_driver/screens/home/screens/notifications.dart';
import 'package:thimar_driver/screens/home/screens/my_orders.dart';

import '../../gen/assets.gen.dart';
import '../../generated/locale_keys.g.dart';

class HomeNavBarScreen extends StatefulWidget {
  int currentPage;

  HomeNavBarScreen({super.key, this.currentPage = 0});

  @override
  State<HomeNavBarScreen> createState() => _HomeNavBarScreenState();
}

class _HomeNavBarScreenState extends State<HomeNavBarScreen> {
final List<String> _titles = [
    LocaleKeys.home_nav_main_page.tr(),
    LocaleKeys.home_nav_my_orders.tr(),
    LocaleKeys.home_nav_notifications.tr(),
    LocaleKeys.home_nav_my_account.tr(),
  ];
 final List<String> _icons = [
    Assets.icons.home.path,
    Assets.icons.orders.path,
    Assets.icons.notification.path,
    Assets.icons.personHome.path,
  ];
 final List<Widget> _pages = [
    const HomeScreen(),
    const MyOrdersScreen(),
    const NotificationsScreen(),
    const MyAccountScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        body: _pages[widget.currentPage],
        bottomNavigationBar: BottomNavigationBar(
          onTap: (value) {
            widget.currentPage = value;
            setState(() {});
          },
          type: BottomNavigationBarType.fixed,
          unselectedFontSize: 12.sp,
          backgroundColor: Theme.of(context).primaryColor,
          selectedItemColor: Colors.white,
          unselectedItemColor: const Color(0xffAED489),
          currentIndex: widget.currentPage,
          items: List.generate(
              _pages.length,
              (index) => BottomNavigationBarItem(
                  icon: Padding(
                    padding: EdgeInsets.only(bottom: 4.h),
                    child: Image.asset(
                      _icons[index],
                      color: widget.currentPage == index
                          ? Colors.white
                          : const Color(0xffAED489),
                    ),
                  ),
                  label: _titles[index])),
        ),
      ),
    );
  }
}
