import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_first_station/guess/guess_app_bar.dart';
import 'package:flutter_first_station/guess/result_notice.dart';

class GuessPage extends StatefulWidget {
  const GuessPage({super.key, required this.title});

  final String title;

  @override
  State<GuessPage> createState() => _GuessPageState();
}

class _GuessPageState extends State<GuessPage> with SingleTickerProviderStateMixin {
  int _value = 0;
  bool _guessing = false;
  bool? _isBig;
  final Random _random = Random();

  late AnimationController controller;


  void _generateRandomValue() {
    setState(() {
      _guessing = true;
      _value = _random.nextInt(100);
    });
  }

  final TextEditingController _guessCtrl = TextEditingController();

  void _onCheck() {
    print("=====Check:目标数值:$_value=====${_guessCtrl.text}============");

    int? guessValue = int.tryParse(_guessCtrl.text);

    print("---------输入值: $guessValue");
    if (guessValue == null || !_guessing) return;
    controller.forward(from: 0.5);
    //猜对了
    if (guessValue == _value) {
      print("=====Check:目标数值:$_value=====${_guessCtrl.text}============");
      setState(() {
        _guessing = false;
        _isBig = null;
      });
      return;
    }
    //猜错了
    setState(() {
      _isBig = guessValue > _value;
    });
  }

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this,duration: const Duration(milliseconds: 200));
  }

  @override
  void dispose() {
    _guessCtrl.dispose();
    controller.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GuessAppBar(
        onCheck: _onCheck,
        controller: _guessCtrl,
      ),
      body: Stack(
        children: [
          if(_isBig != null)
            Column(
            children: [
              if(_isBig!)
               ResultNotice(color: Colors.redAccent, info: "大了",controller: controller,),
              const Spacer(),
              if(!_isBig!)
                ResultNotice(color: Colors.blueAccent, info: '小了',controller: controller,)
            ],
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                if (!_guessing) const Text('点击生成随机数值'),
                Text(
                  _guessing ? '**' : '$_value',
                  style: const TextStyle(
                    fontSize: 68,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _guessing ? null : _generateRandomValue,
        backgroundColor: _guessing ? Colors.grey : Colors.blue,
        tooltip: 'Increment',
        child: const Icon(Icons.generating_tokens_outlined),
      ),
    );
  }
}
