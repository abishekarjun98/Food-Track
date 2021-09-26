//@dart=2.9
import 'package:flutter/material.dart';
import 'package:food_track/models/food_list.dart';
import 'package:food_track/models/near_by_store.dart';
import 'package:food_track/models/result_response.dart';
import 'package:food_track/utils.dart';
import 'package:geolocator/geolocator.dart';
import 'package:here_sdk/core.dart';
import 'package:here_sdk/mapview.dart';
import 'api/api_manager.dart';

class FeedsPage extends StatefulWidget {
  @override
  _FeedsPageState createState() => _FeedsPageState();
}

class _FeedsPageState extends State<FeedsPage> {
  Future<ResultResponse<NearByStoreResponse, String>> _response;
  Position position;
  @override
  void initState() {
    super.initState();
    fetch();
  }

  Future<void> fetch() async {
    var pos = await UtilsManager().getPosition();
    if (mounted) {
      setState(() {
        position = pos;
      });
      _response =
          ApiManager().nearByStore(position.latitude, position.longitude);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ResultResponse<NearByStoreResponse, String>>(
      future: _response,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          print(snapshot.data.message);
          var stores = snapshot.data.response as NearByStoreResponse;
          if (snapshot.data.message == "success") {
            return ListView.builder(
              itemCount: stores.respone.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                      side: BorderSide(),
                    ),
                    title: Text(
                      stores.respone.elementAt(index).details.storeName,
                    ),
                    subtitle: Text(
                      stores.respone.elementAt(index).details.phoneNumber,
                    ),
                    trailing: Text(
                      (stores.respone.elementAt(index).distance * 1000)
                              .toInt()
                              .toString() +
                          " M away",
                    ),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FoodList(
                            food: stores.respone[index].details.foodItems,
                            userposition: position,
                            storeposition: Position(
                                latitude: stores.respone[index].details.lat,
                                longitude: stores.respone[index].details.lon,
                                accuracy: null,
                                altitude: null,
                                heading: null,
                                speed: null,
                                speedAccuracy: null,
                                timestamp: null)),
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(child: Text("Network Error"));
          }
        } else
          return Center(child: CircularProgressIndicator.adaptive());
      },
    );
  }
}

class FoodList extends StatefulWidget {
  final List<String> food;
  final Position userposition;
  final Position storeposition;
  const FoodList({Key key, this.food, this.userposition, this.storeposition})
      : super(key: key);
  @override
  _FoodListState createState() => _FoodListState();
}

class _FoodListState extends State<FoodList> {
  Future<ResultResponse<FoodListResponse, String>> _response;
  List<bool> isSelected;

  @override
  void initState() {
    super.initState();
    print(widget.food);
    isSelected =
        List<bool>.filled(widget.food.length + 1, false, growable: false);
    _response = ApiManager().getfoodList(widget.food);
  }

  void selected(int i) {
    setState(() {
      isSelected[i] = !isSelected[i];
    });
  }

  bool isStart() {
    for (bool select in isSelected) {
      if (select) return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('FoodTrack')),
        floatingActionButton: isStart()
            ? FloatingActionButton.extended(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MapPage(
                              userposition: widget.userposition,
                              storeposition: widget.storeposition)));
                },
                label: Text("Place Order"),
              )
            : null,
        body: FutureBuilder<ResultResponse<FoodListResponse, String>>(
            future: _response,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var foods = snapshot.data.response as FoodListResponse;
                if (snapshot.data.message == "success") {
                  return ListView.builder(
                      itemCount: foods.response.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                            onTap: () {
                              selected(index);
                            },
                            child: Card(
                                child: ListTile(
                                    trailing: isSelected[index]
                                        ? Icon(Icons.check,
                                            color: Colors.blue, size: 26)
                                        : null,
                                    title: Container(
                                        height: 250,
                                        child: Column(children: [
                                          Flexible(
                                              flex: 2,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Flexible(
                                                      flex: 3,
                                                      child: Image.network(foods
                                                          .response[index]
                                                          .foods
                                                          .imageUrl)),
                                                  Flexible(
                                                      flex: 2,
                                                      child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Text('Price: ' +
                                                                '₹' +
                                                                foods
                                                                    .response[
                                                                        index]
                                                                    .foods
                                                                    .price),
                                                            SizedBox(width: 10),
                                                            Text('Net Weight: ' +
                                                                foods
                                                                    .response[
                                                                        index]
                                                                    .foods
                                                                    .quantity),
                                                          ]))
                                                ],
                                              )),
                                          Text(
                                              foods.response[index].foods.name),
                                          SizedBox(height: 10),
                                          Flexible(
                                              flex: 1,
                                              child: ListView.builder(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  itemCount: foods
                                                      .response[index]
                                                      .foods
                                                      .nutritions
                                                      .length,
                                                  itemBuilder:
                                                      (context, index2) {
                                                    return Padding(
                                                        padding:
                                                            EdgeInsets.all(10),
                                                        child:
                                                            Column(children: [
                                                          Text(foods
                                                              .response[index]
                                                              .foods
                                                              .nutritions[
                                                                  index2]
                                                              .name),
                                                          Text(foods
                                                              .response[index]
                                                              .foods
                                                              .nutritions[
                                                                  index2]
                                                              .gram),
                                                        ]));
                                                  }))
                                        ])))));
                      });
                } else {
                  return Center(child: Text("Error"));
                }
              } else
                return Center(child: CircularProgressIndicator());
            }));
  }
}

class MapPage extends StatelessWidget {
  final Position userposition;
  final Position storeposition;
  const MapPage({Key key, this.userposition, this.storeposition})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(storeposition);
    print(userposition);
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(body: HereMap(onMapCreated: _onMapCreated)));
  }

  Future<void> _onMapCreated(HereMapController hereMapController) async {
    hereMapController.setWatermarkPosition(WatermarkPlacement.bottomLeft, 0);

    hereMapController.mapScene.addMapArrow(MapArrow(
        GeoPolyline(<GeoCoordinates>[
          GeoCoordinates(userposition.latitude, userposition.longitude),
          GeoCoordinates(userposition.latitude, userposition.longitude)
        ]),
        40,
        Colors.purple));
    hereMapController.mapScene.addMapArrow(MapArrow(
        GeoPolyline(<GeoCoordinates>[
          GeoCoordinates(
              userposition.latitude + 0.0002, storeposition.longitude),
          GeoCoordinates(
              userposition.latitude + 0.0002, storeposition.longitude)
        ]),
        40,
        Colors.deepOrange));
    hereMapController.mapScene.loadSceneForMapScheme(MapScheme.normalDay,
        (MapError error) async {
      if (error != null) {
        print('Map scene not loaded. MapError: ${error.toString()}');
        return;
      }
      const double distanceToEarthInMeters = 3000;
      hereMapController.camera.lookAtPointWithDistance(
          GeoCoordinates(userposition.latitude, userposition.longitude),
          distanceToEarthInMeters);

      hereMapController.mapScene.addMapPolyline(MapPolyline(
          GeoPolyline(<GeoCoordinates>[
            GeoCoordinates(userposition.latitude, userposition.longitude),
            GeoCoordinates(
                userposition.latitude + 0.0002, storeposition.longitude)
          ]),
          10,
          Colors.blue));
    });
  }
}
