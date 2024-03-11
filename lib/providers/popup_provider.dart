import 'package:flutter/material.dart';

class PopupProvider extends ChangeNotifier {
  double _receivedProgress = 0.0;
  double _sentProgress = 0.0;
  String? _waitingMessage;

  double get receiveProgress => _receivedProgress;
  double get sentProgress => _sentProgress;
  String? get waitingMessage => _waitingMessage;

  void setReceivedProgress(double progressValue) {
    _receivedProgress = progressValue;
    notifyListeners();
  }

  void setSentProgress(double progressValue) {
    _sentProgress = progressValue;
    notifyListeners();
  }

  void setWaitingMessage(String? waitingMessage) {
    _waitingMessage = waitingMessage;
  }
}
