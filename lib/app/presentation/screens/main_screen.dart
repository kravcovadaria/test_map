import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_map/app/presentation/widget/app_icon.dart';
import 'package:test_map/app_resources.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: AppIcon.square(
              AppResources.telephone,
              size: 20.r,
              color: themeData.appBarTheme.iconTheme?.color,
            ),
            onPressed: () {},
          ),
        ],
        centerTitle: true,
        title: const Text('logo'),
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
            height: 200,
          )
        ],
      ),
    );
  }
}

// class MainScreenView extends StatefulWidget {
//   const MainScreenView({super.key});
//
//   @override
//   State<StatefulWidget> createState() => MainScreenViewState();
// }
//
// class MainScreenViewState extends State<MainScreenView> {
//   late TextEditingController textController = TextEditingController();
//
//   @override
//   void dispose() {
//     textController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Home screen'),
//       ),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Padding(
//             padding: EdgeInsets.all(14.r),
//             child: const Text('Set valid API base URL in order to continue'),
//           ),
//           Padding(
//             padding: EdgeInsets.symmetric(horizontal: 14.r),
//             child: Row(
//               children: [
//                 Padding(
//                   padding: EdgeInsets.only(right: 17.r),
//                   child: const Icon(
//                     Icons.compare_arrows,
//                     color: Color(0xFF898989),
//                   ),
//                 ),
//                 Flexible(
//                   child: BlocBuilder<MainScreenCubit, MainScreenState>(
//                     builder: (context, state) {
//                       return TextField(
//                         controller: textController,
//                         decoration: InputDecoration(
//                             hintText: 'Enter Url',
//                             errorText: state.validator.isValid
//                                 ? null
//                                 : state.validator.error?.errorMessage ?? ''),
//                       );
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           const Spacer(),
//           Padding(
//             padding: EdgeInsets.all(9.r),
//             child: SubmitActionButton(
//               caption: 'Start counting process',
//               onTap: () async {
//                 MainScreenCubit cubit =
//                     BlocProvider.of<MainScreenCubit>(context);
//                 if (await cubit.submit(textController.text)) {
//                   if (context.mounted) {
//                     AutoRouter.of(context).push(const ProcessRoute());
//                   }
//                 }
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
