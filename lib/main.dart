import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'pointer_interceptor sample App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late MapController controller;
  @override
  void initState() {
    super.initState();
    controller = MapController.withPosition(
        initPosition: GeoPoint(
            latitude: 35.6895014,
            longitude: 139.6917337)); //コントローラーのポジションを東京都庁にして初期化。
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: OSMFlutter(
        controller: controller,
        osmOption: OSMOption(
          zoomOption: const ZoomOption(initZoom: 14), //地図の初期ズームレベルを設定する
          staticPoints: [
            StaticPositionGeoPoint(
              '0', //マーカーのID
              const MarkerIcon(
                icon: Icon(
                  Icons.location_on,
                  color: Colors.red,
                ), //マーカーのアイコン
              ),
              [
                GeoPoint(latitude: 35.6895, longitude: 139.6917), //東京都庁の緯度経度
              ], //マーカーを表示するGeoPointのリスト
            ),
            StaticPositionGeoPoint(
              '1', //マーカーのID
              const MarkerIcon(
                icon: Icon(
                  Icons.location_on,
                  color: Colors.blue,
                ), //マーカーのアイコン
              ),
              [
                GeoPoint(latitude: 35.6905, longitude: 139.6995), //新宿駅の緯度経度
              ], //マーカーを表示するGeoPointのリスト
            ),
          ],
        ),
        onGeoPointClicked: (GeoPoint geoPoint) {
          showDialog(
            context: context,
            builder: (_) {
              return PointerInterceptor(
                child: AlertDialog(
                  content:
                      Text("緯度:${geoPoint.latitude}　経度:${geoPoint.longitude}"),
                  actions: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text("閉じる"),
                    )
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
