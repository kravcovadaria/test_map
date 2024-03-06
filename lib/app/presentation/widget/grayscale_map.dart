import 'dart:async';

import 'dart:ui' as ui;
import 'package:flutter/services.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:test_map/app/presentation/widget/app_icon.dart';
import 'package:test_map/app_resources.dart';

class GrayscaleMap extends StatefulWidget {
  const GrayscaleMap({
    super.key,
    this.position,
    this.afterPermissionGranted,
    this.isLoading = false,
  });

  final LatLng? position;
  final VoidCallback? afterPermissionGranted;
  final bool isLoading;

  @override
  State<StatefulWidget> createState() => GrayscaleMapState();
}

class GrayscaleMapState extends State<GrayscaleMap> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  late BitmapDescriptor bitmapDescriptor;
  Set<Marker> markers = {};

  @override
  void didUpdateWidget(covariant GrayscaleMap oldWidget) {
    super.didUpdateWidget(oldWidget);
    if ((oldWidget.position == null) != (widget.position == null)) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final position = widget.position;

    return position == null
        ? Stack(
            children: [
              SizedBox(
                width: double.infinity,
                child: Image.asset(
                  AppResources.defaultMap,
                  centerSlice: Rect.largest,
                ),
              ),
              const Positioned.fill(
                child: ColoredBox(
                  color: Color.fromRGBO(0, 0, 0, 0.7),
                ),
              ),
              widget.isLoading
                  ? Positioned.fill(
                      child: Center(
                          child: SizedBox(
                        height: 20.r,
                        width: 20.r,
                        child: const CircularProgressIndicator(
                          strokeWidth: 2,
                        ),
                      )),
                    )
                  : Positioned.fill(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 25.r,
                          // vertical: 50.r,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: const Color(0xFF383838),
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(17.r),
                                ),
                              ),
                              alignment: Alignment.center,
                              height: 65.r,
                              width: 65.r,
                              child: AppIcon.square(
                                AppResources.noWifi,
                                color: themeData.primaryColor,
                                size: 30.r,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 20.r),
                              child: Text(
                                'Відсутній зв\'язок',
                                style:
                                    Theme.of(context).textTheme.headlineMedium,
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 20.r),
                              child: Text(
                                'Відсутність доступу до геолокації. Переконайтеся, що у додатку увімкнено геолокацію та перевірте з\'єднання з Інтернетом.',
                                textAlign: TextAlign.center,
                                style: themeData.textTheme.bodyMedium
                                    ?.copyWith(letterSpacing: 0.1),
                              ),
                            ),
                            GestureDetector(
                                onTap: () {
                                  Geolocator.requestPermission().then((result) {
                                    widget.afterPermissionGranted?.call();
                                  });
                                },
                                child: Text(
                                  'Налаштування геолокації >',
                                  style: themeData.textTheme.labelMedium,
                                )),
                          ],
                        ),
                      ),
                    ),
            ],
          )
        : GoogleMap(
            mapType: MapType.normal,
            padding: EdgeInsets.only(bottom: 55.r / 4, left: 55.r / 4),
            initialCameraPosition: CameraPosition(target: position, zoom: 15),
            onMapCreated: (GoogleMapController controller) async {
              await _initMarkers();
              controller.setMapStyle(
                  '[{"featureType": "landscape","stylers": [{ "color": "#323432" }]},'
                  '{"featureType": "water","stylers": [{ "color": "#191a1a" }]},'
                  '{"featureType": "landscape.natural","stylers": [{ "color": "#323432" }]},'
                  '{"featureType": "road","elementType": "geometry","stylers": [{ "color": "#454545" }]},'
                  '{"featureType": "poi","elementType": "labels","stylers": [{ "visibility": "off" }]},'
                  '{"featureType": "poi","elementType": "geometry","stylers": [{ "color": "323432" }]},'
                  '{"featureType": "administrative","elementType": "labels.text.fill","stylers": [{ "color": "#8c8b8b" }]},'
                  '{"featureType": "administrative","elementType": "labels.text.stroke","stylers": [{ "color": "#2B2C2B" }]},'
                  '{"featureType": "road","elementType": "labels.text.fill","stylers": [{ "color": "#8c8b8b" }]},'
                  '{"featureType": "all","elementType": "labels.text.stroke","stylers": [{ "color": "#2B2C2B" }]}]');
              _controller.complete(controller);
              setState(() {});
            },
            markers: markers,
            zoomControlsEnabled: false,
          );
  }

  Future<void> _initMarkers() async {
    final position = widget.position;
    if (position == null) {
      return;
    }

    // воркераунд, щоб іконку не робило занадто маленькою
    double screenRatio = MediaQuery.of(context).devicePixelRatio;
    bitmapDescriptor = await _getBitmapDescriptorFromAssetBytes(
        'assets/images/marker.png', (12 * screenRatio).r.toInt());
    markers.add(
      Marker(
        markerId: MarkerId('$position'),
        position: position,
        icon: bitmapDescriptor,
      ),
    );
  }

  Future<Uint8List?> _getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))
        ?.buffer
        .asUint8List();
  }

  Future<BitmapDescriptor> _getBitmapDescriptorFromAssetBytes(
      String path, int width) async {
    final Uint8List? imageData = await _getBytesFromAsset(path, width);
    return BitmapDescriptor.fromBytes(imageData!);
  }
}
