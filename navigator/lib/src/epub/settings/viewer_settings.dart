// Copyright (c) 2021 Mantano. All rights reserved.
// Unauthorized copying of this file, via any medium is strictly prohibited.
// Proprietary and confidential.

import 'package:mno_commons/utils/jsonable.dart';

class ViewerSettings implements JSONable {
  static const int minFontSize = 50; // in %
  static const int maxFontSize = 300; // in %
  final SyntheticSpreadMode syntheticSpreadMode;
  final ScrollMode scrollMode;
  int fontSize;
  final int columnGap;

  // If true, column gap will not be part of JSON conversion
  bool hasNoStyle;

  ViewerSettings(
      this.syntheticSpreadMode, this.scrollMode, this.fontSize, this.columnGap);

  factory ViewerSettings.defaultSettings({int fontSize = 100}) =>
      ViewerSettings(SyntheticSpreadMode.single, ScrollMode.auto, fontSize, 0);

  ViewerSettings incrFontSize({int delta = 10}) {
    int newFontSize = fontSize + delta;
    newFontSize = newFontSize.clamp(minFontSize, maxFontSize);
    return ViewerSettings(
        this.syntheticSpreadMode, this.scrollMode, newFontSize, this.columnGap);
  }

  ViewerSettings decrFontSize({int delta = 10}) {
    int newFontSize = fontSize - delta;
    newFontSize = newFontSize.clamp(minFontSize, maxFontSize);
    return ViewerSettings(
        this.syntheticSpreadMode, this.scrollMode, newFontSize, this.columnGap);
  }

  bool get scrollViewDoc => scrollMode == ScrollMode.document;

  @override
  Map<String, dynamic> toJson() => {
        "syntheticSpread": _syntheticSpread,
        "scroll": _scroll,
        "enableGPUHardwareAccelerationCSS3D": false,
        "columnGap": columnGap,
      };

  String get _syntheticSpread {
    String syntheticSpread = "";
    switch (syntheticSpreadMode) {
      case SyntheticSpreadMode.auto:
        syntheticSpread = "auto";
        break;
      case SyntheticSpreadMode.double:
        syntheticSpread = "double";
        break;
      case SyntheticSpreadMode.single:
        syntheticSpread = "single";
        break;
    }
    return syntheticSpread;
  }

  String get _scroll {
    String scroll = "";
    switch (scrollMode) {
      case ScrollMode.auto:
        scroll = "auto";
        break;
      case ScrollMode.document:
        scroll = "scroll-doc";
        break;
      case ScrollMode.continuous:
        scroll = "scroll-continuous";
        break;
      case ScrollMode.continuousHorizontal:
        scroll = "scroll-continuous-horizontal";
        break;
    }
    return scroll;
  }

  @override
  String toString() =>
      'ViewerSettings{syntheticSpreadMode: $syntheticSpreadMode, scrollMode: $scrollMode, '
      'fontSize: $fontSize, columnGap: $columnGap, hasNoStyle: $hasNoStyle}';
}

enum SyntheticSpreadMode { auto, double, single }

enum ScrollMode { auto, document, continuous, continuousHorizontal }