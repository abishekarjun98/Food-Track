//@dart=2.9
import 'package:flutter/material.dart';
import 'package:food_track/api/api_manager.dart';
import 'package:food_track/models/food_details.dart';
import 'package:food_track/models/result_response.dart';
import 'package:here_sdk/core.dart';
import 'package:here_sdk/mapview.dart';

void main() {
  SdkContext.init(IsolateOrigin.main);
  runApp(Admin());
}

class Admin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false, home: Scaffold(body: CityPage()));
  }
}

class CityPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CityState();
  }
}

class CityState extends State<CityPage> {
  TextEditingController _lat = TextEditingController();
  TextEditingController _lon = TextEditingController();
  TextEditingController _rad = TextEditingController();
  var lato = 10.0, longo = 78.0, rado = 5000;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            body: SafeArea(
                child: Column(children: [
          Flexible(
              flex: 1,
              child: TextFormField(
                controller: _lat,
                decoration: InputDecoration(hintText: "Lat"),
                keyboardType: TextInputType.number,
              )),
          Flexible(
              flex: 1,
              child: TextFormField(
                controller: _lon,
                decoration: InputDecoration(hintText: "Lon"),
                keyboardType: TextInputType.number,
              )),
          Flexible(
              flex: 1,
              child: TextFormField(
                controller: _rad,
                decoration: InputDecoration(hintText: "Radius"),
                keyboardType: TextInputType.number,
              )),
          ElevatedButton(
              onPressed: () async {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Mapss(
                              lato: double.parse(_lat.text),
                              longo: double.parse(_lon.text),
                              rado: double.parse(_rad.text),
                            )));
              },
              child: Text("Find"))
        ]))));
  }
}

class Mapss extends StatefulWidget {
  final lato;
  final longo;
  final rado;
  const Mapss({Key key, this.lato, this.longo, this.rado}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return MapsState();
  }
}

class MapsState extends State<Mapss> {
  Future<ResultResponse<FoodDetailResponse, String>> _res;
  @override
  void initState() {
    super.initState();
    _res = ApiManager().admin(widget.lato.toString(), widget.longo.toString(),
        widget.rado.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder<ResultResponse<FoodDetailResponse, String>>(
            future: _res,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var res = snapshot.data.response as FoodDetailResponse;
                return Column(children: [
                  Expanded(child: HereMap(onMapCreated: _onMapCreated)),
                  InkWell(
                      child: Card(
                          child: ListTile(
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
                                                child: Image.network(
                                                    res.response.imageUrl)),
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
                                                          res.response.price),
                                                      SizedBox(width: 10),
                                                      Text('Net Weight: ' +
                                                          res.response
                                                              .quantity),
                                                    ]))
                                          ],
                                        )),
                                    Text(res.response.name),
                                    SizedBox(height: 10),
                                    Flexible(
                                        flex: 1,
                                        child: ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemCount:
                                                res.response.nutritions.length,
                                            itemBuilder: (context, index2) {
                                              return Padding(
                                                  padding: EdgeInsets.all(10),
                                                  child: Column(children: [
                                                    Text(res
                                                        .response
                                                        .nutritions[index2]
                                                        .name),
                                                    Text(res
                                                        .response
                                                        .nutritions[index2]
                                                        .gram),
                                                  ]));
                                            }))
                                  ])))))
                ]);
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }));
  }

  Future<void> _onMapCreated(HereMapController hereMapController) async {
    hereMapController.setWatermarkPosition(WatermarkPlacement.bottomLeft, 0);

    hereMapController.mapScene.loadSceneForMapScheme(MapScheme.normalDay,
        (MapError error) async {
      if (error != null) {
        print('Map scene not loaded. MapError: ${error.toString()}');
        return;
      }
      const double distanceToEarthInMeters = 3000;
      hereMapController.camera.lookAtPointWithDistance(
          GeoCoordinates(widget.lato, widget.longo), distanceToEarthInMeters);
      GeoCircle geoCircle =
          GeoCircle(GeoCoordinates(widget.lato, widget.longo), widget.rado);
      GeoPolygon geoPolygon = GeoPolygon.withGeoCircle(geoCircle);
      Color fillColor = Color.fromARGB(160, 0, 144, 138);
      MapPolygon mapPolygon = MapPolygon(geoPolygon, fillColor);
      hereMapController.mapScene.addMapPolygon(mapPolygon);
      LocationIndicator locationIndicator = LocationIndicator();

      Location location = Location.withDefaults(
          GeoCoordinates(widget.lato, widget.longo), DateTime.now());

      locationIndicator.updateLocation(location);

      hereMapController.addLifecycleListener(locationIndicator);
    });
  }
}
