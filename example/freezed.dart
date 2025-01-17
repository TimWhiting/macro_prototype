// GENERATED FILE - DO NOT EDIT
//
// This file was generated by applying the following macros to the
// `example/freezed.declarations.dart` file:
//
//   - Instance of '_JsonMacro'
//
// To make changes you should edit the `example/freezed.gen.dart` file;

import 'macros/freezed.dart';

class FreezedData extends FreezedUnion {
  final DateTime time;
  final String info;
  FreezedData(this.time, {required this.info});
}

class FreezedError extends FreezedUnion {
  final String error;
  FreezedError(this.error);
}

class FreezedLoading extends FreezedUnion {
  final Duration time;
  FreezedLoading(this.time);
}

@freezed
class FreezedUnion {
  FreezedUnion();
  factory FreezedUnion.data(DateTime time, {required String info}) =
      FreezedData;
  factory FreezedUnion.error(String error) = FreezedError;
  factory FreezedUnion.loading(Duration time) = FreezedLoading;
}
