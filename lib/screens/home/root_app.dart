import 'package:flutter/material.dart';
import 'package:sikucing/screens/favoritescreen.dart';
import 'package:sikucing/screens/homescreen.dart';
import 'package:sikucing/screens/openaiscreen.dart';
import 'package:sikucing/theme/color.dart';
import 'package:sikucing/utils/constant.dart';
import 'package:sikucing/widgets/bottombar_item.dart';

class RootApp extends StatefulWidget {
  const RootApp({Key? key}) : super(key: key);

  @override
  _RootAppState createState() => _RootAppState();
}

class _RootAppState extends State<RootApp> with TickerProviderStateMixin {
  int _activeTab = 0;
  final List barItems = [
    {
      "icon": "assets/home/home-border.svg",
      "active_icon": "assets/home/home.svg",
      "page": HomeScreen(),
    },
    {
      "icon": "assets/home/heart-border.svg",
      "active_icon": "assets/home/heart.svg",
      "page": FavoriteScreen(),
    },
    {
      "icon": "assets/home/pet-border.svg",
      "active_icon": "assets/home/pet.svg",
      "page": AboutCatsPage(),
    },
  ];

//====== set animation=====
  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: ANIMATED_BODY_MS),
    vsync: this,
  );
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.fastOutSlowIn,
  );

  @override
  void initState() {
    super.initState();
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.stop();
    _controller.dispose();
    super.dispose();
  }

  _buildAnimatedPage(page) {
    return FadeTransition(child: page, opacity: _animation);
  }

  void onPageChanged(int index) {
    _controller.reset();
    setState(() {
      _activeTab = index;
    });
    _controller.forward();
  }

//====== end set animation=====

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.appBgColor,
      body: _buildPage(),
      floatingActionButton: _buildBottomBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _buildPage() {
    return IndexedStack(
      index: _activeTab,
      children: List.generate(
        barItems.length,
        (index) => _buildAnimatedPage(barItems[index]["page"]),
      ),
    );
  }

  Widget _buildBottomBar() {
    return Container(
      height: 55,
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 25, vertical: 0),
      decoration: BoxDecoration(
        color: AppColor.bottomBarColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColor.shadowColor.withOpacity(0.1),
            blurRadius: 1,
            spreadRadius: 1,
            offset: Offset(0, 1),
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: List.generate(
          barItems.length,
          (index) => BottomBarItem(
            _activeTab == index
                ? barItems[index]["active_icon"]
                : barItems[index]["icon"],
            isActive: _activeTab == index,
            activeColor: AppColor.primary,
            onTap: () => onPageChanged(index),
          ),
        ),
      ),
    );
  }
}
