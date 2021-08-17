import 'package:flutter/material.dart';
import '../app.dart';

class SliderItem {
  final String imageUrl;

  SliderItem({
    @required this.imageUrl,
  });
}

final listSlide = [
  SliderItem(
    imageUrl: App.landing1,
  ),
  SliderItem(
    imageUrl: App.landing2,
  ),
  SliderItem(
    imageUrl: App.landing3,
  ),
];
