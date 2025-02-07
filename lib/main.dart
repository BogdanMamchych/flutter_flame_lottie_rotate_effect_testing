import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/game.dart';
import 'package:flame/geometry.dart';
import 'package:flame/input.dart';
import 'package:flame_lottie/flame_lottie.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    GameWidget(
      game: RotateEffectGame(),
    ),
  );
}

//Тестування ефекту RotateEffect на анімації Lottie JSON;
class RotateEffectGame extends FlameGame {
  //Змінна для зміни сторони руху, щоб наш кубок не втік :)
  bool reset = false;
  @override
  Future<void> onLoad() async {
    //Перегляд позицій компонентів(при бажанні, можете увімкнути)
    debugMode = true;
    //Завантаження анімації та створення 'будівельного' віджету
    final LottieBuilder lottieBuilder = Lottie.asset('assets/win.json');
    //Компонування анімації, щоб Flame використовував анімації 
    final LottieComposition lottieComposition = await loadLottie(lottieBuilder);
    //Створення самого компоненту анімації, цей компонент вже можна добавляти до світу, який вам взбриде в голову :)
    //Також можна тут погратися з position та size та іншими атрибутами на ваш розсуд
    //Тільки запрещаю ставити дуже великі значення, бо наш кубок(який зароблено непосильним трудом) полетить в стратосферу :)
    LottieComponent animation = LottieComponent(lottieComposition,
        position: Vector2.all(250), size: Vector2.all(200), anchor: Anchor.center);
    TestTextBox rotateCupText = TestTextBox("Rotate cup");
    add(animation);
    ButtonComponent rotateCupButton = ButtonComponent(
        position: Vector2(600, 30),
        button: rotateCupText,
        onPressed: () {
          //Тут також не запрещаю гратися :)
          if (reset) {
            animation.add(
                RotateEffect.to(tau / 4, EffectController(duration: 1)));
          } else {
            animation.add(
                RotateEffect.by(-tau / 4, EffectController(duration: 1)));
          }
          reset = !reset;
        });

    add(rotateCupButton);
  }
}

class TestTextBox extends TextBoxComponent {
  TestTextBox(text)
      : super(
          text: text,
          position: Vector2(0, 0),
          size: Vector2(210, 40),
          textRenderer: TextPaint(
            style: TextStyle(
              color: Colors.blue,
              fontSize: 24,
            ),
          ),
        );
}