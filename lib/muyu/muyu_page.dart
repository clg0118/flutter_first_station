import 'dart:math';

import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_first_station/muyu/animate_text.dart';
import 'package:flutter_first_station/muyu/count_panel.dart';
import 'package:flutter_first_station/muyu/models/audio_option.dart';
import 'package:flutter_first_station/muyu/muyu_image.dart';
import 'package:flutter_first_station/muyu/options/select_image.dart';
import 'package:flutter_first_station/muyu/record_history.dart';
import 'package:uuid/uuid.dart';

import 'models/image_option.dart';
import 'models/merit_record.dart';
import 'muyu_app_bar.dart';
import 'options/select_audio.dart';

class MuyuPage extends StatefulWidget {
  const MuyuPage({Key, key}) : super(key: key);

  @override
  State<MuyuPage> createState() => _MuyuPageState();
}

class _MuyuPageState extends State<MuyuPage> {
  final Uuid uuid = const Uuid();

  int _counter = 0;
  int _cruValue = 0;
  MeritRecord? _cruRecord;
  final Random _random = Random();

  AudioPool? _audioPool;

  final List<ImageOption> imageOptions = const [
    ImageOption('基础版', 'assets/images/muyu.png', 1, 3),
    ImageOption('尊享版', 'assets/images/muyu2.png', 3, 6),
  ];
  int _activeImageIndex = 0;

  int get knockValue {
    int min = imageOptions[_activeImageIndex].min;
    int max = imageOptions[_activeImageIndex].max;
    return min + _random.nextInt(max + 1 - min);
  }

  void _onSelectImage(int value) {
    Navigator.of(context).pop();
    if (value == _activeImageIndex) return;
    setState(() {
      _activeImageIndex = value;
    });
  }

  String get activeImage => imageOptions[_activeImageIndex].src;

  final List<AudioOption> audioOptions = [
    AudioOption('音效1', 'assets/audio/muyu1.mp3'),
    AudioOption('音效2', 'assets/audio/muyu2.mp3'),
    AudioOption('音效3', 'assets/audio/muyu3.mp3'),
  ];
  int _activeAudioIndex = 0;

  void _onSelectAudio(int value) async {
    Navigator.of(context).pop();
    if (value == _activeAudioIndex) return;
    _activeAudioIndex = value;
    _audioPool = await FlameAudio.createPool(activeAudio, maxPlayers: 1);
  }

  String get activeAudio => audioOptions[_activeAudioIndex].src;

  final List<MeritRecord> _records = [];

  @override
  void initState() {
    super.initState();
    _initAudio();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MuyuAppBar(
        onTapHistory: _toHistory,
      ),
      body: Column(
        children: [
          Expanded(
              child: CountPanel(
                  count: _counter,
                  onTapSwitchAudio: _onTapSwitchAudio,
                  onTapSwitchImage: _onTapSwitchImage)),
          Expanded(
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                MuyuAssetsImage(image: activeImage, onTap: _onKnock),
                if (_cruRecord != null) AnimateText(record: _cruRecord!)
              ],
            ),
          ),
        ],
      ),
    );
  }
  void _toHistory() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => RecordHistory(
          records: _records.reversed.toList(),
        ),
      ),
    );
  }
  void _onTapSwitchAudio() {
    showCupertinoModalPopup(
        context: context,
        builder: (BuildContext context) {
          return AudioOptionPanel(
              audioOptions: audioOptions,
              onSelect: _onSelectAudio,
              activeIndex: _activeAudioIndex);
        });
  }

  void _onTapSwitchImage() {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return ImageOptionPanel(
            imageOptions: imageOptions,
            onSelect: _onSelectImage,
            activeIndex: _activeImageIndex);
      },
    );
  }

  void _initAudio() async {
    _audioPool = await FlameAudio.createPool('muyu_1.mp3', maxPlayers: 1);
  }

  void _onKnock() {
    _audioPool?.start();
    setState(() {
      _cruValue = knockValue;
      _counter += _cruValue;
      String id = uuid.v4();
      _cruRecord = MeritRecord(id, DateTime.now().millisecondsSinceEpoch,
          _cruValue, activeImage, audioOptions[_activeAudioIndex].name);
      _records.add(_cruRecord!);
    });
  }
}


