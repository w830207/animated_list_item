import 'package:animated_list_item/animated_list_item.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Animated List Item example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Animated List Item example'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  List list = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9];

  Container item(int index) {
    return Container(
      color: Colors.blue,
      margin: const EdgeInsets.all(8),
      alignment: Alignment.center,
      child: Text("$index"),
    );
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 4500),
      vsync: this,
    );
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: ListView.builder(
                      itemCount: list.length,
                      itemBuilder: (context, index) {
                        return AnimatedListItem(
                          index: index,
                          length: list.length,
                          aniController: _animationController,
                          animationType: AnimationType.flipX,
                          child: item(index),
                        );
                      }),
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: list.length,
                      itemBuilder: (context, index) {
                        return AnimatedListItem(
                          index: index,
                          length: list.length,
                          aniController: _animationController,
                          animationType: AnimationType.flipY,
                          child: item(index),
                        );
                      }),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: ListView.builder(
                      itemCount: list.length,
                      itemBuilder: (context, index) {
                        return AnimatedListItem(
                          index: index,
                          length: list.length,
                          aniController: _animationController,
                          animationType: AnimationType.zoomIn,
                          child: item(index),
                        );
                      }),
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: list.length,
                      itemBuilder: (context, index) {
                        return AnimatedListItem(
                          index: index,
                          length: list.length,
                          aniController: _animationController,
                          animationType: AnimationType.slideIn,
                          startX: 40,
                          startY: 60,
                          child: item(index),
                        );
                      }),
                ),
              ],
            ),
          ),
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
