import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:testapp/common/extensions/text_extensions.dart';
import 'package:testapp/common/extensions/theme_extensions.dart';
import 'package:testapp/common/widgets/bouncing_button.dart';

class CommonButton extends StatelessWidget {
  const CommonButton._(
    this.text,
    this.loading,
    this.enabled,
    this.onPressed,
    this.radius,
    this.type, {
    super.key,
    this.backgroundColor,
    this.textColor,
    this.icon,
    this.padding,
    this.prefixIcon,
    this.shadow = false,
    this.centerTitle = true,
  });

  final String text;
  final bool loading;
  final bool enabled;
  final VoidCallback? onPressed;
  final double radius;
  final Color? backgroundColor;
  final Color? textColor;
  final String? icon;
  final double? padding;
  final CommonButtonType type;
  final Widget? prefixIcon;
  final bool shadow;
  final bool centerTitle;

  const CommonButton.outlined({
    required String text,
    bool loading = false,
    bool enabled = true,
    bool centreTitle = true,
    VoidCallback? onPressed,
    double radius = 8,
    Color? backgroundColor,
    Color? textColor,
    Key? key,
    String? icon,
    double? padding,
  }) : this._(
          text,
          loading,
          enabled,
          onPressed,
          radius,
          CommonButtonType.outlined,
          backgroundColor: backgroundColor,
          textColor: textColor,
          key: key,
          icon: icon,
          padding: padding,
          centerTitle: centreTitle,
        );

  const CommonButton.elevated({
    required String text,
    bool loading = false,
    bool enabled = true,
    bool centerTitle = true,
    VoidCallback? onPressed,
    Color? backgroundColor,
    Color? textColor,
    String? icon,
    double radius = 12,
    Key? key,
    double? padding,
    bool shadow = false,
  }) : this._(
          backgroundColor: backgroundColor,
          textColor: textColor,
          text,
          loading,
          enabled,
          onPressed,
          radius,
          CommonButtonType.elevated,
          key: key,
          icon: icon,
          padding: padding,
          shadow: shadow,
          centerTitle: centerTitle,
        );

  const CommonButton.text({
    required String text,
    bool loading = false,
    bool enabled = true,
    VoidCallback? onPressed,
    double radius = 0,
    Key? key,
    double? padding,
    Widget? prefixIcon,
  }) : this._(
          text,
          loading,
          enabled,
          onPressed,
          radius,
          CommonButtonType.text,
          key: key,
          padding: padding,
          prefixIcon: prefixIcon,
        );

  VoidCallback? _onPressed() {
    if (!enabled) return null;
    return () {
      if (loading) return;
      onPressed?.call();
    };
  }

  Widget _child(Color color) {
    return loading
        ? Center(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: CircularProgressIndicator(
                strokeWidth: 3,
                backgroundColor: color,
              ),
            ),
          )
        : Padding(
            padding: EdgeInsets.symmetric(
              vertical: padding ?? 12.0,
              horizontal: 4,
            ),
            child: text.isEmpty
                ? Center(
                    child: SvgPicture.asset(icon ?? ''),
                  )
                : Row(
                    children: [
                      Visibility(
                        visible: icon != null,
                        child: Row(
                          children: [
                            SvgPicture.asset(icon ?? ''),
                            const SizedBox(width: 6)
                          ],
                        ),
                      ),
                      Expanded(
                        child: centerTitle
                            ? Center(
                                child: text.w(600).s(16).c(color).copyWith(
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                              )
                            : Padding(
                                padding: const EdgeInsets.only(left: 16),
                                child: text.w(600).s(16).c(color).copyWith(
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                              ),
                      ),
                    ],
                  ),
          );
  }

  Widget _outlined(BuildContext context) {
    return Bouncing(
      onTap: _onPressed(),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          border: Border.all(color: backgroundColor ?? context.colors.primary),
        ),
        child: _child(textColor ?? context.colors.primary),
      ),
    );
  }

  Widget _elevated(BuildContext context) {
    return Container(
      decoration: shadow
          ? BoxDecoration(
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: context.colors.primary,
                  spreadRadius: 10,
                  blurRadius: 16,
                ),
              ],
            )
          : null,
      child: Bouncing(
        onTap: _onPressed(),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius),
            color: enabled
                ? backgroundColor ?? context.colors.primary
                : context.colors.disable,
          ),
          child: _child(
            enabled
                ? textColor ?? context.colors.onPrimary
                : context.colors.primary,
          ),
        ),
      ),
    );
  }

  Widget _text(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.all(Colors.transparent),
      ),
      onPressed: _onPressed(),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
              child: text
                  .w(400)
                  .s(16)
                  .c(context.colors.primary)
                  .copyWith(maxLines: 1, overflow: TextOverflow.ellipsis)),
          const SizedBox(width: 4),
          if (prefixIcon != null) prefixIcon!,
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case CommonButtonType.outlined:
        return _outlined(context);
      case CommonButtonType.elevated:
        return _elevated(context);
      case CommonButtonType.text:
        return _text(context);
    }
  }
}

enum CommonButtonType { outlined, elevated, text }
