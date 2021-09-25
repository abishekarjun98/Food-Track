//@dart=2.9
import 'package:flutter/material.dart';
import 'package:food_track/models/result_response.dart';
import 'package:food_track/models/searchedfood_response.dart';
import 'package:food_track/utils.dart';
import 'package:geolocator/geolocator.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  Future<ResultResponse<SearchedResponse, String>> _response;
  TextEditingController controller = TextEditingController();

  Position position;

  @override
  void initState() {
    super.initState();
    fetch();
  }

  Future<void> fetch() async {
    var pos = await UtilsManager().getPosition();
    setState(() {
      position = pos;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ResultResponse<SearchedResponse, String>>(
      future: _response,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          print(snapshot.data.message);
          var stores = snapshot.data.response as SearchedResponse;
          return ListView.builder(
            itemCount: stores.response.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  title:
                      Text(stores.response.elementAt(index).details.storeName),
                  subtitle: Text(
                      stores.response.elementAt(index).details.phoneNumber),
                  trailing: Text(stores.response
                          .elementAt(index)
                          .distance
                          .toInt()
                          .toString() +
                      " " +
                      "KM " +
                      "Away"),
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
