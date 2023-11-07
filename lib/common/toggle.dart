import 'package:flutter/material.dart';

void openDrawer(Function(bool) setState) {
  setState(true);
}

void closeDrawer(Function(bool) setState) {
  setState(false);
}
