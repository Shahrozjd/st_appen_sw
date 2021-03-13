import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:st_appen/components/constants.dart';
import 'package:st_appen/screens/addpage.dart';
import 'package:st_appen/screens/homepage.dart';
import 'package:st_appen/screens/reportpage.dart';

_PersistentBottomBarState mypresistentbottombarstate;

class PersistentBottomBar extends StatefulWidget {
  @override
  _PersistentBottomBarState createState() {
    mypresistentbottombarstate = _PersistentBottomBarState();
    return mypresistentbottombarstate;
  }
}

class _PersistentBottomBarState extends State<PersistentBottomBar> {
  PersistentTabController _controller;
  int productcount = 0;


  @override
  void initState() {
    super.initState();
  }

  List<Widget> _buildScreens() {
    return [
      addpage(),
      homepage(),
      reportpage(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(FontAwesomeIcons.plusCircle),
        title: ("Lägg till"),
        activeColor: mainaccent,
        inactiveColor: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(FontAwesomeIcons.chartBar),
        title: ("Diagram"),
        activeColor: mainaccent,
        inactiveColor: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        onPressed: () {
          pushNewScreen(
            context,
            screen: reportpage(),
            withNavBar: true, // OPTIONAL VALUE. True by default.
          );
        },
        icon: Icon(Icons.list_alt),
        title: ("Rapportera"),
        activeColor: mainaccent,
        inactiveColor: CupertinoColors.systemGrey,
      ),
    ];
  }

  Future<bool> _onWillPop() async {
    Navigator.pop(context);
    // return Navigator.pushReplacement(
    //     context, MaterialPageRoute(builder: (context) => mainpage()));
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      onWillPop: _onWillPop,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      // This needs to be true if you want to move up the screen when keyboard appears.
      stateManagement: true,
      hideNavigationBarWhenKeyboardShows: true,
      // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument.
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),

      itemAnimationProperties: ItemAnimationProperties(
        // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: ScreenTransitionAnimation(
        // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle: NavBarStyle.style3, // Cho
    );
  }
}
