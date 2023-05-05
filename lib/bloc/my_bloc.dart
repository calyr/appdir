import 'dart:async';
import 'package:flutter/material.dart';

class MyBloc {
  // Define the sink and stream controllers
  final _myController = StreamController<String>();
  Stream<String> get myStream => _myController.stream;
  Sink<String> get mySink => _myController.sink;

  // Define the business logic
  void processEvent(String event) {
    String newState = 'Processed $event';
    mySink.add(newState);
  }

  // Dispose the controllers
  void dispose() {
    _myController.close();
  }
}