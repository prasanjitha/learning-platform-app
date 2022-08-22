import 'package:flutter/foundation.dart';

@immutable
abstract class StudentSearchPageEvent {}

class InitEvent extends StudentSearchPageEvent {}

class OnSearchTextChangedEvent extends StudentSearchPageEvent {
  final String text;
  OnSearchTextChangedEvent({required this.text});
}
