//@dart=2.9
import 'package:flutter/material.dart';
import 'package:food_track/models/near_by_store.dart';
import 'package:food_track/models/result_response.dart';
import 'package:food_track/utils.dart';
import 'package:geolocator/geolocator.dart';

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
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        } else
          return Center(child: CircularProgressIndicator.adaptive());
      },
    );
  }
}

class FoodList extends StatefulWidget {
  final List<String> food;

  const FoodList({Key key, this.food}) : super(key: key);
  @override
  _FoodListState createState() => _FoodListState();
}

class _FoodListState extends State<FoodList> {
  Future<ResultResponse<dynamic, String>> _response;

  @override
  void initState() {
    super.initState();
    _response = ApiManager().getfoodList(["123456"]);
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
