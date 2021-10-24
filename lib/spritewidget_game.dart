import 'package:flutter/painting.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:spritewidget/spritewidget.dart';
import 'package:flutter/gestures.dart';

class SpriteSquare extends NodeWithSize {
  
  Color color;
  Function handler;
  double left;
  double top;

  SpriteSquare(size, this.color, this.handler, this.top, this.left) : super(size){
    userInteractionEnabled = true;
  }

  @override handleEvent(SpriteBoxEvent event) {
    handler(event);
    return true;
  }

  @override
    Future<void> paint(Canvas canvas) async {
      canvas.drawRect(
        Rect.fromLTWH(left, top, size.height, size.width),
        Paint()..color = color
      );
    }
}

class MySpriteGame extends StatelessWidget {

  final _background = SpriteSquare(
    const Size(400.0, 400.0), 
    const Color(0xFF000000), 
    (){}, 
    0,
    0 
  );

  MySpriteGame({Key? key}) : super(key: key);

  handleAdd(SpriteBoxEvent event) {
    print(event.pointerEvent.localPosition.dx);
    final _whitesquare = SpriteSquare(
      const Size(50.0, 50.0), 
      const Color(0xFFFFFFFF), 
      handleRemoveSelf, 
      event.pointerEvent.localPosition.dx + 50, event.pointerEvent.localPosition.dy + 50,
    );
    _background.addChild(_whitesquare);
    return true;
  }

  handleRemoveSelf(SpriteBoxEvent event){
    print('hello');
    return true;
  }

  @override
  Widget build(BuildContext context) {
    _background.handler = handleAdd;
  	return 
          SpriteWidget(
            _background
          );
  }
}