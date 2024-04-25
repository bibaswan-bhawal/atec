// ignore_for_file: non_constant_identifier_names

import 'package:flutter_svg/flutter_svg.dart';

abstract class AppIcons {
  static const String _assets = 'assets/icons';

  static final SvgPicture home_gray = SvgPicture.asset('$_assets/home_gray.svg');
  static final SvgPicture book_gray = SvgPicture.asset('$_assets/book_gray.svg');
  static final SvgPicture close_circle_gray = SvgPicture.asset('$_assets/close_circle_gray.svg');

  static final SvgPicture home_dark = SvgPicture.asset('$_assets/home_dark.svg');
  static final SvgPicture book_dark = SvgPicture.asset('$_assets/book_dark.svg');

  static final SvgPicture magnify_plus_light = SvgPicture.asset('$_assets/magnify_plus_light.svg');
}
