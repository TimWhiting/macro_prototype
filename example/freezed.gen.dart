import 'macros/freezed.dart';

@freezed
class FreezedUnion {
  FreezedUnion();
  factory FreezedUnion.data(DateTime time, {required String info}) =
      FreezedData;
  factory FreezedUnion.error(String error) = FreezedError;
  factory FreezedUnion.loading(Duration time) = FreezedLoading;
}
