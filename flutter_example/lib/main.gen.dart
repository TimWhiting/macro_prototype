import 'package:flutter/material.dart';

import 'macros/auto_dispose.dart';
import 'macros/functional_widget.dart';
import 'macros/render_accessors.dart';

void main() {
  runApp(const MyApp());
}

@FunctionalWidget(widgetName: 'MyApp')
Widget _buildApp(BuildContext context,
    {String? appTitle, String? homePageTitle}) {
  return MaterialApp(
      title: appTitle ?? 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MyHomePage(title: homePageTitle ?? 'Flutter Demo Home Page'));
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final disposable = SimpleDisposable();
  int _counter = 0;
  Color _color = Colors.blue;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(super.widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  _color = _color == Colors.blue ? Colors.red : Colors.blue;
                });
              },
              child: SizedBox(
                height: 100,
                width: 100,
                child: MyColoredFill(
                  color: _color,
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }

  @override
  @autoDispose
  void dispose() {
    super.dispose();
  }
}

class SimpleDisposable implements Disposable {
  @override
  void dispose() {
    print('disposing $this');
  }
}

// TODO(goderbauer): This could also be generated by a macro.
class MyColoredFill extends LeafRenderObjectWidget {
  const MyColoredFill({Key? key, required this.color}) : super(key: key);

  final Color color;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return MyColoredFillRenderBox(color: color);
  }

  @override
  void updateRenderObject(BuildContext context,  MyColoredFillRenderBox renderObject) {
    renderObject.color = color;
  }
}

class MyColoredFillRenderBox extends RenderBox {
  MyColoredFillRenderBox({required Color color}) : _color = color;

  @RenderAccessors(needsPaint: true) Color _color;

  @override
  bool get sizedByParent => true;

  @override
  bool hitTestSelf(Offset position) => true;

  @override
  Size computeDryLayout(BoxConstraints constraints) {
    return constraints.biggest;
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    context.canvas.drawRect(offset & size, Paint()..color = color);
  }
}
