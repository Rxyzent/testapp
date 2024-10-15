import 'dart:isolate';
import 'dart:ui';

import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testapp/common/base/base_page.dart';
import 'package:testapp/common/extensions/text_extensions.dart';
import 'package:testapp/common/extensions/theme_extensions.dart';
import 'package:testapp/common/widgets/base_app_bar.dart';
import 'package:testapp/common/widgets/common_button.dart';
import 'package:testapp/presentation/home/cubit/home_cubit.dart';
import 'package:testapp/presentation/home/cubit/home_state.dart';
import 'package:testapp/presentation/main/backgroundService/background_service.dart';

@RoutePage()
class HomePage extends BasePage<HomeCubit, HomeBuildable, HomeListenable> {
  HomePage({super.key});

  late ReceivePort mainReceivePort;

  @override
  void init(BuildContext context) async {
    super.init(context);
    await initializeService();
    await initializePermissions();

    mainReceivePort = ReceivePort();
    final isRegisterSuccessful = IsolateNameServer.registerPortWithName(
        mainReceivePort.sendPort, 'main_thread_port');
    mainReceivePort.listen((message) {
      print('message :$message');
      context.read<HomeCubit>().updateUserData(message);
    });

    if(isRegisterSuccessful){
      FlutterBackgroundService().invoke(
        'lifecycle',
        {'resumed': true},
      );
    }
  }

  @override
  void dispose() {
    mainReceivePort.close();
    IsolateNameServer.removePortNameMapping('main_thread_port');
    super.dispose();
  }

  @override
  Widget builder(BuildContext context, HomeBuildable state) {
    int hours = 0;
    int minutes = 0;
    int seconds = 0;
    String distance = '0.0';
    if (state.user != null) {
      hours = state.user!.inactiveDuration! ~/ 3600;
      minutes = (state.user!.inactiveDuration! % 3600) ~/ 60;
      seconds = state.user!.inactiveDuration! % 60;
      distance = (state.user!.distance! / 1000).toStringAsFixed(1);
    }
    return SafeArea(
      child: Scaffold(
        backgroundColor: context.colors.onPrimary,
        appBar: const BaseAppBar(
          title: 'Home',
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  'Distance:'.w(500).s(16).c(context.colors.color2),
                  const SizedBox(width: 4),
                  _TextBox(value: distance, unit: 'km'),
                ],
              ),
              const SizedBox(height: 16),
              CommonButton.elevated(
                loading: state.loading,
                text: state.isServiceRunning ? 'Stop' : 'Start',
                backgroundColor: context.colors.color2,
                onPressed: () {
                  state.isServiceRunning ? stopService() : startService();
                  context.read<HomeCubit>().checkServiceStatus();
                },
              ),
              const SizedBox(height: 32),
              Row(
                children: [
                  'Time:'.w(500).s(16).c(context.colors.color2),
                  const SizedBox(width: 4),
                  _TextBox(value: '$hours', unit: 'hour'),
                  const SizedBox(width: 8),
                  _TextBox(value: '$minutes', unit: 'minut'),
                  const SizedBox(width: 8),
                  _TextBox(value: '$seconds', unit: 'sekond'),
                ],
              ),
              const SizedBox(height: 16),
              CommonButton.elevated(
                enabled: state.isServiceRunning,
                text: state.user!.isTimerRunning! ? 'Continue' : 'Wait',
                backgroundColor: context.colors.color2,
                onPressed: () {
                  state.user!.isTimerRunning! ? stopTimer() : startTimer();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TextBox extends StatelessWidget {
  const _TextBox({required this.value, required this.unit});

  final String value;
  final String unit;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
          decoration: BoxDecoration(
            border: Border.all(
              color: context.colors.color2,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: value.w(500).s(16).c(context.colors.color2),
        ),
        const SizedBox(width: 4),
        unit.w(500).s(16).c(context.colors.color2),
      ],
    );
  }
}
