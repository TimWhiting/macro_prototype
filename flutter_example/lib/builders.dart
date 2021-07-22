import 'package:build/build.dart';
import 'package:macro_builder/builder.dart';

import 'macros/auto_dispose.dart';
import 'macros/functional_widget.dart';
import 'macros/functional_widget2.dart';
import 'macros/render_accessors.dart';

Builder typesBuilder(_) => TypesMacroBuilder([widget]);
Builder declarationsBuilder(_) =>
    DeclarationsMacroBuilder([autoDispose, const RenderAccessors(), widget2]);
Builder definitionsBuilder(_) => DefinitionsMacroBuilder([autoDispose]);
