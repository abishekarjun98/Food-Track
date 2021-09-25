//@dart=2.9
import 'package:flutter/material.dart';
import 'package:food_track/models/result_response.dart';
import 'package:food_track/models/searchedfood_response.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  Future<ResultResponse<SearchedResponse, String>> _response;
  TextEditingController controller = TextEditingController();

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
          return Center(child: CircularProgressIndicator.adaptive());
      },
    );
  }
}
