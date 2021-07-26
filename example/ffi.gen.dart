import 'dart:ffi';

@ffiValueCopy  
class MyStruct extends Struct {
  @Int32()
  external int hi;

  @Float()
  external double hi2;

  external Pointer<MyStruct> myStruct;

  external OtherStruct valueStruct;
}

class OtherStruct extends Struct {
  @Int64()
  external int id;
}
