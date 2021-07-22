import 'package:macro_builder/definition.dart';
import 'package:macro_builder/src/analyzer.dart';
import 'package:analyzer/dart/ast/ast.dart' as ast;
import 'package:analyzer/dart/element/element.dart' as analyzer;

const widget2 = FunctionalWidget2(ResolvedAST(null));

extension on analyzer.ParameterElement {
  TypeReference get typeRef =>
      AnalyzerTypeReference(type.element! as analyzer.TypeDefiningElement,
          originalReference: type);
}

class FunctionalWidget2 implements ClassDeclarationMacro {
  final ResolvedAST buildMethod;

  const FunctionalWidget2(this.buildMethod);

  @override
  void visitClassDeclaration(
      ClassDeclaration declaration, ClassDeclarationBuilder builder) {
    final build = buildMethod.ast;

    if (build is! ast.FunctionExpression) {
      throw ArgumentError(
          'Build Method is not a Function Expression ${build.runtimeType}');
    }
    final positionalParams =
        build.parameters!.parameterElements.where((p) => p!.isPositional);
    if (positionalParams.isEmpty ||
        positionalParams.first!.type.getDisplayString(withNullability: true) !=
            'BuildContext') {
      throw ArgumentError(
          'FunctionalWidget functions must have a BuildContext argument as the '
          'first positional argument');
    }
    final namedParams = {
      for (var p = 0; p < build.parameters!.parameters.length; p++)
        if (!build.parameters!.parameterElements[p]!.isPositional)
          build.parameters!.parameters[p]:
              build.parameters!.parameterElements[p]
    };

    var positionalFieldParams = positionalParams.skip(1);
    var fields = <Code>[
      for (var param in positionalFieldParams)
        Declaration('final ${param!.typeRef.toCode()} ${param.name};'),
      for (var param in namedParams.values)
        Declaration('final ${param!.typeRef.toCode()} ${param.name};'),
    ];

    var constructorArgs = <Code>[
      for (var param in positionalFieldParams)
        Fragment('this.${param!.name}, '),
      Fragment('{'),
      for (var param in namedParams.keys)
        Fragment(
            '${param.isRequired ? 'required ' : ''}this.${param.identifier!.name}, '),
      Fragment('Key? key, }'),
    ];

    var widgetName = declaration.name;
    var constructor = Declaration.fromParts(
        ['const $widgetName(', ...constructorArgs, ') : super(key: key);']);

    var method = Declaration.fromParts([
      '''
@override
Widget build(BuildContext context) ${build.body.toSource()}
'''
    ]);

    builder.addToClass(Declaration.fromParts([
      ...fields,
      constructor,
      method,
    ]));
  }
}
