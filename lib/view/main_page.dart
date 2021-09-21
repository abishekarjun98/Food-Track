import 'package:flutter/material.dart';
import 'package:food_track/cache/cache_manager.dart';

class Main extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<Main> {
  int _selectedIndex = 0;
  PageController _pageController = PageController(initialPage: 0);
  CacheManager _cache = CacheManager().cache();

  void _onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onItemTapped(int selectedIndex) {
    _pageController.animateToPage(selectedIndex,
        duration: Duration(milliseconds: 250), curve: Curves.decelerate);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            appBar: AppBar(
                title: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      InkWell(
                          onLongPress: () => print("clicked"),
                          child: Text('FoodTrack')),
                    ]),
                brightness: Brightness.dark,
                backgroundColor: Colors.black,
                actions: <Widget>[
                  InkWell(
                      onTap: () {
                        _cache.clearCred().whenComplete(() =>
                            {Navigator.of(context).popAndPushNamed("/splash")});
                      },
                      child: Padding(
                        padding: EdgeInsets.only(right: 24.0),
                        child: Icon(
                          Icons.logout,
                          color: Colors.redAccent[400],
                          size: 26.0,
                          semanticLabel: "Logout",
                        ),
                      )),
                ]),
            body: Builder(
                builder: (context) => PageView(
                      controller: _pageController,
                      children: [],
                      onPageChanged: _onPageChanged,
                      physics: NeverScrollableScrollPhysics(),
                    )),
            bottomNavigationBar: Builder(
                builder: (context) => Container(
                      decoration: BoxDecoration(color: Colors.black),
                      child: BottomNavigationBar(
                        type: BottomNavigationBarType.fixed,
                        currentIndex: _selectedIndex,
                        showUnselectedLabels: false,
                        selectedItemColor: Theme.of(context).primaryColor,
                        unselectedItemColor: Colors.white70,
                        backgroundColor: Colors.black,
                        onTap: _onItemTapped,
                        items: [
                          BottomNavigationBarItem(
                              icon: Icon(
                                Icons.home,
                              ),
                              label: "Home"),
                          BottomNavigationBarItem(
                              icon: Icon(
                                Icons.inventory,
                              ),
                              label: "Events"),
                          BottomNavigationBarItem(
                              icon: Icon(Icons.account_circle),
                              label: "Profile"),
                        ],
                      ),
                    ))));
  }
}
