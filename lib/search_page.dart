//@dart=2.9
import 'package:flutter/material.dart';
import 'package:food_track/models/result_response.dart';
import 'package:food_track/models/searchedfood_response.dart';
import 'package:food_track/utils.dart';
import 'package:geolocator/geolocator.dart';

import 'api/api_manager.dart';

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
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.black,
            title: Container(
                margin: EdgeInsets.all(16),
                child: Row(children: [
                  Flexible(
                    flex: 1,
                    child: TextFormField(
                      controller: controller,
                      onChanged: (val) {},
                      cursorColor: Colors.white,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        counterText: '',
                        contentPadding: EdgeInsets.only(left: 24),
                        hintText: 'Search',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.all(10),
                      child: IconButton(
                          icon: Icon(
                            Icons.search,
                            color: Colors.white,
                          ),
                          onPressed: () async {
                            _response = ApiManager().searchFood(controller.text,
                                position.latitude, position.longitude);
                          }))
                ]))),
        body: FutureBuilder<ResultResponse<SearchedResponse, String>>(
            future: _response,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                print(snapshot.data.message);
                var stores = snapshot.data.response as SearchedResponse;
                return ListView.builder(
                    itemCount: stores.response.length,
                    itemBuilder: (context, index) {
                      return Card(
                          child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Row(
                          children: [
                            Flexible(
                                flex: 2,
                                child: Column(
                                  children: [
                                    Text(stores.response
                                        .elementAt(index)
                                        .details
                                        .storeName),
                                    Text(stores.response
                                        .elementAt(index)
                                        .details
                                        .phoneNumber),
                                    Text(stores.response
                                            .elementAt(index)
                                            .distance
                                            .toInt()
                                            .toString() +
                                        " " +
                                        "KM " +
                                        "Away"),
                                  ],
                                ))
                          ],
                        ),
                      ));
                    });
              } else
                return Center(child: CircularProgressIndicator());
            }));
  }
}
