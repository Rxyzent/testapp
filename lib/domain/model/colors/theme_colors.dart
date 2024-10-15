import 'dart:ui';

import 'package:testapp/domain/model/colors/static_colors.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class ThemeColors {
  Color get primary => StaticColors.cuttySark;

  Color get disable => StaticColors.cuttySark.withOpacity(0.15);

  Color get error => StaticColors.error;

  Color get onPrimary => StaticColors.white;

  Color get black => StaticColors.black;

  Color get white => StaticColors.white;

  Color get window => StaticColors.solitude;

  Color get label => StaticColors.suvaGrey;

  Color get title => StaticColors.black;

  Color get headline => StaticColors.whiteLilac;

  Color get color1 => StaticColors.whiteSmoke;

  Color get color2 => StaticColors.cuttySark;

  Color get color3 => StaticColors.suvaGrey;

  Color get color4 => StaticColors.black;

  Color get color5 => StaticColors.white;

  Color get color6 => StaticColors.pear;

  Color get color7 => StaticColors.cyprus;

  Color get color8 => StaticColors.coldMorning;

  Color get success => StaticColors.success;

  Color get warning => StaticColors.warning;

  Color get danger => StaticColors.danger;

  Color get primary1 => StaticColors.primary;

  Color get info => StaticColors.info;

  Color get muted => StaticColors.muted;
}
