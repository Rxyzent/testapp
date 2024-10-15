import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';

class LifecycleListener extends StatefulWidget {
  const LifecycleListener({super.key, required this.child});

  final Widget child;

  @override
  State<LifecycleListener> createState() => _LifecycleListenerState();
}

class _LifecycleListenerState extends State<LifecycleListener>  with WidgetsBindingObserver{

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }


  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    FlutterBackgroundService().invoke(
      'lifecycle',
      {'resumed': state == AppLifecycleState.resumed},
    );
  }
}
