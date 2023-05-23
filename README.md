# animated_list_item

A flutter package whitch provide Animation of items in ListView, GridView, SliverList, etc.

<img src="https://github.com/w830207/animated_list_item/blob/main/display/demo.gif?raw=true"/>

# Installing

### Depend on it
Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  animated_list_item: ^1.0.0
```

### Import it

Now in your code, you can use: 

````dart
    import 'package:animated_list_item/animated_list_item.dart';
````

# AnimationType

all types here 👇:
fade,

// flip
flipX,
flipXTop,
flipXBottom,
flipY,
flipYLeft,
flipYRight,

// zoom
zoom,
zoomLeft,
zoomRight,

// rotate
rotate,
rotateLeft,
rotateRight,

// translate
slide,
shakeX,
shakeY,

# Example

preparation 👇
```dart
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
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    );
    _animationController.forward();
  }
```


## flipX

<img src="https://github.com/w830207/animated_list_item/blob/main/display/flipX.gif?raw=true">


```dart
ListView.builder(
  itemCount: list.length,
  itemBuilder: (context, index) {
    return AnimatedListItem(
      index: index,
      length: list.length,
      aniController: _animationController,
      animationType: AnimationType.flipX,
      child: item(index),
    );
  },
);
```

## flipY

<img src="https://github.com/w830207/animated_list_item/blob/main/display/flipY.gif?raw=true">


```dart
ListView.builder(
  itemCount: list.length,
  itemBuilder: (context, index) {
    return AnimatedListItem(
      index: index,
      length: list.length,
      aniController: _animationController,
      animationType: AnimationType.flipY,
      child: item(index),
    );
  },
);
```

## zoom

<img src="https://github.com/w830207/animated_list_item/blob/main/display/zoomIn.gif?raw=true">


```dart
ListView.builder(
  itemCount: list.length,
  itemBuilder: (context, index) {
    return AnimatedListItem(
      index: index,
      length: list.length,
      aniController: _animationController,
      animationType: AnimationType.zoom,
      child: item(index),
    );
  },
);
```

## slide

<img src="https://github.com/w830207/animated_list_item/blob/main/display/slideIn.gif?raw=true">


```dart
ListView.builder(
  itemCount: list.length,
  itemBuilder: (context, index) {
    return AnimatedListItem(
      index: index,
      length: list.length,
      aniController: _animationController,
      animationType: AnimationType.slide,
      startX: 40,
      startY: 60,
      child: item(index),
    );
  },
);
```

**Note:** If you want all items play animation at the same time, you can set their index same value.