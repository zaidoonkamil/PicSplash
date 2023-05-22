import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:unsplash/utils/constant_colore.dart';
import 'package:unsplash/utils/my_state.dart';
import 'package:provider/provider.dart';

import '../main.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    Key? key,
    required this.pageController,
  }) : super(key: key);

  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    final pageState = Provider.of<PageState>(context);
    return GNav(
        tabBorderRadius: 20,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        gap: 4,
        activeColor: Colors.black,
        iconSize: 20,
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
        duration: Duration(milliseconds: 400),
        tabBackgroundColor: primaryColor!,
        tabActiveBorder: Border.all(
            color: Theme.of(context).scaffoldBackgroundColor,
            width: 1),
        color :  Theme.of(context).backgroundColor,
        onTabChange: (index) {
          pageState.changePage(index);
          pageController.jumpToPage(index);
        },
        selectedIndex: pageState.currentPage,
        tabs:  [
          GButton(
            textColor:  Theme.of(context).backgroundColor,
            textStyle: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),
            text: 'Home',
            icon: LineIcons.home,
          ),
          GButton(
            textColor:  Theme.of(context).backgroundColor,
            textStyle: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),
            icon: LineIcons.search,
            text: 'Search',
          ),
          GButton(
            textColor:  Theme.of(context).backgroundColor,
            textStyle: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),
            text: 'explore',
            icon: LineIcons.compass,
          ),
          GButton(
            textColor:  Theme.of(context).backgroundColor,
            textStyle: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),
            text: 'favorite',
            icon: LineIcons.heart,
          ),
        ]);
  }
}
