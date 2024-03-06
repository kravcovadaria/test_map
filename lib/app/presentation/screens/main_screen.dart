import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:test_map/app/presentation/logic/app_cubit.dart';
import 'package:test_map/app/presentation/widget/app_icon.dart';
import 'package:test_map/app/presentation/widget/bottom_bar_button.dart';
import 'package:test_map/app/presentation/widget/grayscale_map.dart';
import 'package:test_map/app/presentation/widget/wide_button.dart';
import 'package:test_map/app_resources.dart';

class _ZeroSize extends StatelessWidget implements PreferredSizeWidget {
  const _ZeroSize();

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }

  @override
  Size get preferredSize => Size.zero;
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<StatefulWidget> createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    super.initState();

    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      _calculatePosition();
    });

    Geolocator.getServiceStatusStream().listen((ServiceStatus status) {
      _calculatePosition();
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text('logo'),
        bottom: const _ZeroSize(),
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 1,
            color: themeData.appBarTheme.backgroundColor!,
          ),
        ),
        actions: [
          IconButton(
            icon: AppIcon.square(
              AppResources.telephone,
              size: 20.r,
              color: themeData.appBarTheme.iconTheme?.color,
            ),
            onPressed: () {},
          ),
          SizedBox(width: 11.r),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.r),
        child: NavigationBar(
          onDestinationSelected: (int index) {
            // перемикати сторінку
          },
          selectedIndex: 1, // поки нема інших сторінок
          backgroundColor: themeData.scaffoldBackgroundColor,
          surfaceTintColor: Colors.transparent,
          destinations: [
            BottomBarButton(
              icon: AppResources.clipboard,
              caption: 'Заявки',
              onTap: () {},
            ),
            BottomBarButton(
              icon: AppResources.home,
              caption: 'Головна',
              onTap: () {},
              selected: true, // поки нема інших сторінок
            ),
            BottomBarButton(
              icon: AppResources.user,
              caption: 'Особисті дані',
              onTap: () {},
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: themeData.primaryColor,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40.r),
                bottomRight: Radius.circular(40.r),
              ),
            ),
            padding: EdgeInsets.symmetric(
              vertical: 20.r,
              horizontal: 22.r,
            ),
            child: Stack(
              children: [
                Image.asset(
                  AppResources.logoPng,
                  fit: BoxFit.fill,
                  width: 331.r,
                ),
                Positioned.fill(
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: 25.r,
                      top: 25.r,
                      right: 109.r,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Привіт,',
                          style: themeData.textTheme.headlineSmall,
                        ),
                        BlocBuilder<AppCubit, AppState>(
                          builder: (context, state) => Text(
                            state.name,
                            style: themeData.textTheme.headlineLarge,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 20.r, bottom: 10.r),
                          child: Text(
                            'Додавання авто',
                            style: themeData.textTheme.titleSmall,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 26.r),
                          child: Text(
                            'Завантажте дані про ваше авто для кращого використання сервісу.',
                            style: themeData.textTheme.titleLarge,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Text(
                            'Додати авто >',
                            style: themeData.textTheme.titleMedium,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SingleChildScrollView(
            padding: EdgeInsets.only(
              left: 22.r,
              top: 25.r,
              right: 22.r,
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 304.r,
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(
                      Radius.circular(55.r),
                    ),
                    child: BlocBuilder<AppCubit, AppState>(
                      builder: (context, state) => GrayscaleMap(
                          position: state.position,
                          afterPermissionGranted: _calculatePosition),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 25.r),
                  child: WideButton(
                    onTap: () {},
                    child: Text(
                      'Викликати майстра',
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge
                          ?.copyWith(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _calculatePosition() {
    AppCubit cubit = BlocProvider.of<AppCubit>(context);
    cubit.calculatePosition();
  }
}
