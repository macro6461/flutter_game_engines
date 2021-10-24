import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import './flame_game.dart';
import './spritewidget_game.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Game Flame',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page',),
    );
  }
}

class MyHomePage extends StatefulWidget {

  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _whichEngine = 'Flame';

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: LayoutBuilder(
         builder: (ctx, constraints){
           var child;

            if (_whichEngine == 'Flame'){
              child = GameWidget(
                    game: MyFlameGame(),
                  );
            } else if (_whichEngine == 'SpriteWidget'){
              child = MySpriteGame();
            } else {
              child = MySpriteGame();
            }

           return SingleChildScrollView(
              child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
              const Text(
                'Select Game Engine',
              ),
              DropdownButton<String>(
                value: _whichEngine,
                icon: const Icon(Icons.arrow_downward),
                iconSize: 24,
                elevation: 16,
                style: const TextStyle(color: Colors.deepPurple),
                underline: Container(
                  height: 2,
                  color: Colors.deepPurpleAccent,
                ),
                onChanged: (String? newValue) {
                  setState(() {
                    _whichEngine = newValue!;
                  });
                },
                items: <String>['Flame', 'Quill', 'SpriteWidget', 'Feathers', 'Unity']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              Container(
                height: constraints.maxHeight,
                width: constraints.maxWidth,
                child: child
              ),
            ])
      );
         })
      )
    );
  }
}
