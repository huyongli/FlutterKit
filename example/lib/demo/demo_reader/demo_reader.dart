import 'package:example/demo/demo_reader/reader_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:laohu_kit/widget/reader/reader_widget.dart';

class DemoReader extends StatefulWidget {

  @override
  _DemoReaderState createState() => _DemoReaderState();
}

class _DemoReaderState extends State<DemoReader> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ReaderWidget(
      builder: () => ReaderFactory(),
      background: Image.asset('assets/images/read_bg.png', fit: BoxFit.cover),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
