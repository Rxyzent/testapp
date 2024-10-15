import 'package:flutter/material.dart';
import 'package:testapp/common/extensions/theme_extensions.dart';
import 'package:testapp/common/gen/assets.gen.dart';

class CustomSwitch extends StatefulWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  final Color? activeColor;
  final Color? inActiveColor;
  final Color? toogleColor;
  final Widget? activeIcon;
  final Widget? inActiveIcon;

  CustomSwitch({
    Key? key,
    required this.value,
    required this.onChanged,
    this.activeColor,
    this.inActiveColor,
    this.activeIcon,
    this.inActiveIcon,
    this.toogleColor,
  }) : super(key: key);

  @override
  _CustomSwitchState createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch>
    with SingleTickerProviderStateMixin {
  Animation? _circleAnimation;
  AnimationController? _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 60));
    _circleAnimation = AlignmentTween(
            begin: widget.value ? Alignment.centerRight : Alignment.centerLeft,
            end: widget.value ? Alignment.centerLeft : Alignment.centerRight)
        .animate(CurvedAnimation(
            parent: _animationController!, curve: Curves.linear));
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController!,
      builder: (context, child) {
        return GestureDetector(
          onTap: () {
            if (_animationController!.isCompleted) {
              _animationController!.reverse();
            } else {
              _animationController!.forward();
            }
            widget.value == false
                ? widget.onChanged(true)
                : widget.onChanged(false);
          },
          child: Container(
            width: 39.0,
            height: 24.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24.0),
              color: _circleAnimation!.value == Alignment.centerLeft
                  ? widget.inActiveColor ?? Colors.grey
                  : widget.activeColor ?? Colors.blue,
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 2.0, bottom: 2.0, right: 2.0, left: 2.0),
              child: Container(
                alignment: widget.value
                    ? ((Directionality.of(context) == TextDirection.rtl)
                        ? Alignment.centerLeft
                        : Alignment.centerRight)
                    : ((Directionality.of(context) == TextDirection.ltr)
                        ? Alignment.centerLeft
                        : Alignment.centerRight),
                child: Container(
                  width: 20.0,
                  height: 20.0,
                  decoration:  BoxDecoration(
                      shape: BoxShape.circle, color:widget.toogleColor ?? Colors.white),
                  child: Center(
                    child: widget.value
                        ? widget.activeIcon ?? const SizedBox.shrink()
                        : widget.inActiveIcon ?? const SizedBox.shrink(),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
