// GENERATED FILE - DO NOT EDIT
//
// This file was generated by applying the following macros to the
// `example/observable.types.dart` file:
//
//   - Instance of '_JsonMacro'
//   - Instance of 'ObservableMacro'
//   - Instance of '_DataClass'
//   - Instance of '_FreezedClass'
//
// To make changes you should edit the `example/observable.gen.dart` file;

import 'macros/observable.dart';

class ObservableThing {
  @observable
  String _description;
  String get description => _description;
  set description(String val) {
    print('Setting description to ${val}');
    _description = val;
  }

  ObservableThing(this._description);
}
