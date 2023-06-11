import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pong_game/userinterface/backbutton.dart';

import '../settings.dart';

class ChangeSettings extends StatelessWidget {
  const ChangeSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: Stack(
        children: [
          const CustomBackButton(),
          Center(
              child: Container(
                  alignment: Alignment.center,
                  width: min(MediaQuery.of(context).size.width, 300),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [SensitivitySlider()],
                  ))),
        ],
      ),
    );
  }
}

class SensitivitySlider extends StatefulWidget {
  const SensitivitySlider({super.key});

  @override
  State<SensitivitySlider> createState() => _SensitivitySliderState();
}

class _SensitivitySliderState extends State<SensitivitySlider> {
  double _currentSliderValue = sensitivity;
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      const Padding(
          padding: EdgeInsets.only(left: 25),
          child: Text('Sensitivity', style: TextStyle(color: white))),
      Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        Expanded(
            child: Slider.adaptive(
                value: _currentSliderValue,
                activeColor: primary,
                max: 2,
                onChanged: (double value) {
                  setState(() {
                    sensitivity = value;
                    _currentSliderValue = value;
                  });
                })),
        SizedBox(
            width: 35,
            child: TextField(
                controller: TextEditingController(
                    text: _currentSliderValue.toStringAsFixed(2)),
                style: const TextStyle(color: white),
                keyboardType: TextInputType.number,
                onChanged: (String value) {
                  setState(() {
                    sensitivity = double.parse(value);
                    _currentSliderValue = min(double.parse(value), 2);
                  });
                }))
      ])
    ]);
  }
}
