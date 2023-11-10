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

class _GuessPageState extends State<GuessPage> {
  int _value = 0;
  bool _guessing = false;
  bool? _isBig;
  final Random _random = Random();

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
  void dispose() {
    _guessCtrl.dispose();
    super.dispose();
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
              const ResultNotice(color: Colors.redAccent, info: "大了"),
              const Spacer(),
              if(!_isBig!)
              const ResultNotice(color: Colors.blueAccent, info: '小了')
            ],
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                if (!_guessing) const Text('点击生成随机数值'),
                Text(
                  _guessing ? '**' : '$_value',
                  style: Theme.of(context).textTheme.headlineMedium,
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
