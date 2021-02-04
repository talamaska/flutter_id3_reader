# flutter_id3_reader

This Flutter plugin reads the id3 metadata from media file

## Usage

```dart
void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> getTag() async {
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      final TagResponse tag = await FlutterId3Reader.getTag('your file path or url here', remote: true/false);
      print('${tag.toString()}');
    } on PlatformException {
      print('Failed to get id3.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: RaisedButton(
            child: Text('get tag'),
            onPressed: () {
              getTag();
            },
          ),
        ),
      ),
    );
  }
}
```
