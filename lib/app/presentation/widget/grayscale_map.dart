import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:test_map/app/presentation/widget/app_icon.dart';
import 'package:test_map/app_resources.dart';

class GrayscaleMap extends StatelessWidget {
  const GrayscaleMap({super.key, this.position});

  final LatLng? position;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final position = this.position;

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
              Positioned.fill(
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
                          style: Theme.of(context).textTheme.headlineMedium,
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
                            Geolocator.requestPermission();
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
        : FlutterMap(
            options: MapOptions(
              initialCenter: this.position!,
              initialZoom: 14,
            ),
            children: [
              ColorFiltered(
                colorFilter: const ColorFilter.mode(
                  Color(0xFF757575),
                  BlendMode.color,
                ),
                //    ColorFilter.matrix(<double>[
                // 0.2126,0.7152,0.0722,0,0,
                //   0.2126,0.7152,0.0722,0,0,
                //   0.2126,0.7152,0.0722,0,0,
                //   0,0,0,1,0,
                //   ]),
                child:
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.example.app',
                  tileBuilder: darkModeTileBuilder,
                 ),
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    width: 12.r,
                    height: 12.r,
                    point: this.position!,
                    child: AppIcon.square(
                      AppResources.marker,
                      size: 12.r,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ],
              ),
            ],
          );
  }
}
