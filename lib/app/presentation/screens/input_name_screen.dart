import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_map/app/presentation/logic/app_cubit.dart';
import 'package:test_map/app/presentation/screens/main_screen.dart';
import 'package:test_map/app/presentation/widget/wide_button.dart';

class InputNameScreen extends StatefulWidget {
  const InputNameScreen({super.key});

  @override
  State<InputNameScreen> createState() => _InputNameScreenState();
}

class _InputNameScreenState extends State<InputNameScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                59.r,
                88.r,
                59.r,
                28.r,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Як до вас звертатися?',
                    style: Theme.of(context).textTheme.headlineMedium,
                    textAlign: TextAlign.center,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20.r),
                    child: const Text(
                      'Будь ласка, укажіть ваше ім\'я для персоналізації сервісу.',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 22.r),
            child: TextField(
              controller: _controller,
              // style: Theme.of(context).textTheme.bodyMedium,
              decoration: const InputDecoration(
                hintText: 'Ваше ім\'я',
                // hintStyle: ,
              ),
            ),
          ),
          const Spacer(
            flex: 1,
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 22.r,
              right: 22.r,
              bottom: 20.r,
            ),
            child: BlocBuilder<AppCubit, AppState>(
              builder: (context, state) {
                return WideButton(
                  child: state.inProcess
                      ? SizedBox(
                          height: 11.r,
                          width: 11.r,
                          child: const CircularProgressIndicator(strokeWidth: 2,),
                        )
                      : Text(
                          'Продовжити',
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge
                              ?.copyWith(color: Colors.white),
                        ),
                  onTap: () {
                    AppCubit cubit = BlocProvider.of<AppCubit>(context);
                    cubit.submit(_controller.text).then(
                      (value) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MainScreen(),
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
