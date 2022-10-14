import 'package:flutter/material.dart';
import 'package:flutter_architecture/business/block_factory.dart';
import 'package:flutter_architecture/data/services.dart';
import 'package:flutter_architecture/ui/my_app.dart';

void main() {
  BlocFactory.instance.initialize();
  UserServiceProvider.instance.initialize();
  runApp( MyApp());
}
