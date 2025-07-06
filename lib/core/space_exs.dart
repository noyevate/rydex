import 'package:flutter/material.dart';

extension IntExtention on int? {
  int validate({int value  = 0}) {
    return this ?? value;
  }

  Widget get h => SizedBox(
    height: this?.toDouble(),
  );

  Widget get s => SizedBox(
    width: this?.toDouble(),
  );
}