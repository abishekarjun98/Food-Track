//@dart=2.9
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_track/api/api_manager.dart';
import 'package:food_track/cache/cache_manager.dart';
import 'package:food_track/models/result_response.dart';
import 'package:food_track/models/searchedfood_response.dart';
import 'package:geolocator/geolocator.dart';
import '../utils.dart';

class MainScreen extends StatefulWidget {
  final String type;
  const MainScreen({Key key, this.type}) : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends State<MainScreen> {
  int _selectedIndex = 0;
  CacheManager _cache;
  var _buttons;
  var _pages;

  Future<ResultResponse<SearchedResponse, String>> _response;
  TextEditingController controller = TextEditingController();
  Position position;

  @override
  void initState() {
    super.initState();
    _buttons = widget.type == "sellers"
        ? UtilsManager.sellerNavButton()
        : UtilsManager.buyerNavButton();
    _pages = widget.type == "sellers"
        ? UtilsManager.sellerNavPage()
        : UtilsManager.buyerNavPage();
    callCache();
    fetch();
  }

  Future<void> fetch() async {
    var pos = await UtilsManager().getPosition();
    setState(() {
      position = pos;
    });
  }

  Future<void> callCache() async {
    _cache = await CacheManager().cache();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _selectedIndex != 1
          ? AppBar(
              title: Text('FoodTrack'),
              actions: <Widget>[
                IconButton(
                  onPressed: () {
                    _cache.removeCache().whenComplete(
                          () => {
                            // Navigator.of(context).popAndPushNamed("/splash"),
                            Navigator.of(context).popAndPushNamed("/auth"),
                          },
                        );
                  },
                  icon: Icon(Icons.logout),
                ),
              ],
            )
          : AppBar(
              title: Platform.isIOS
                  ? CupertinoTextField(
                      controller: controller,
                      onChanged: (val) {},
                      placeholder: 'Search',
                    )
                  : TextField(
                      controller: controller,
                      onChanged: (val) {},
                      decoration: InputDecoration(
                        counterText: '',
                        contentPadding: EdgeInsets.only(left: 24),
                        hintText: 'Search',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
              actions: [
                IconButton(
                  icon: Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                  onPressed: () async {
                    _response = ApiManager().searchFood(
                        controller.text, position.latitude, position.longitude);
                  },
                ),
              ],
            ),
      body: SafeArea(
        child: _pages.elementAt(_selectedIndex),
        // child: IndexedStack(
        //   children: _pages,
        //   index: _selectedIndex,
        // ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: _buttons,
      ),
    );
  }
}
