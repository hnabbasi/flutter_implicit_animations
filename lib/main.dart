import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Implicit Animations Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Implicit Animations'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  int index = 0;
  double _unfocusedHeight = 70;
  double _focusedHeight = 90;
  double _usernameHeight;
  double _passwordHeight;

  Random random = new Random();
  final _colors = [
    Colors.blue.shade300,
    Colors.purple.shade300,
    Colors.orange.shade300,
  ];

  final _usernameController = new TextEditingController();
  final _passwordController = new TextEditingController();

  final _usernameFocusNode = new FocusNode();
  final _passwordFocusNode = new FocusNode();

  @override
  void initState() {
    super.initState();

    _usernameHeight = _unfocusedHeight;
    _passwordHeight = _unfocusedHeight;

    _usernameController.addListener(() {
      setState(() {
        updateColors();
      });
    });
    _passwordController.addListener(() {
      setState(() {
        updateColors();
      });
    });
    _usernameFocusNode.addListener(() {
      setState(() {
        _usernameHeight =
            _usernameFocusNode.hasFocus ? _focusedHeight : _unfocusedHeight;
      });
    });
    _passwordFocusNode.addListener(() {
      setState(() {
        _passwordHeight =
            _passwordFocusNode.hasFocus ? _focusedHeight : _unfocusedHeight;
      });
    });
  }

  updateColors() {
    index = random.nextInt(_colors.length - 1);
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _usernameFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      AnimatedContainer(
        decoration: BoxDecoration(
            gradient:
                LinearGradient(colors: [_colors[index], _colors[index + 1]])),
        duration: Duration(seconds: 1),
      ),
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Spacer(),
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.fromLTRB(30, 0, 30, 5),
            padding: EdgeInsets.all(10),
            child: Text(
              'Log In',
              style: Theme.of(context).primaryTextTheme.headline6,
            ),
          ),
          AnimatedContainer(
            height: _usernameHeight,
            padding: EdgeInsets.fromLTRB(30, 0, 30, 5),
            duration: Duration(milliseconds: 200),
            child: Card(
              child: Padding(
                padding: EdgeInsets.all(4),
                child: TextField(
                  focusNode: _usernameFocusNode,
                  controller: _usernameController,
                  decoration: InputDecoration(
                      hintText: 'username', border: const OutlineInputBorder()),
                ),
              ),
            ),
          ),
          AnimatedContainer(
            height: _passwordHeight,
            padding: EdgeInsets.fromLTRB(30, 0, 30, 5),
            duration: Duration(milliseconds: 200),
            child: Card(
              child: Container(
                padding: EdgeInsets.all(4),
                child: TextField(
                  focusNode: _passwordFocusNode,
                  obscureText: true,
                  controller: _passwordController,
                  decoration: InputDecoration(
                      hintText: 'password', border: const OutlineInputBorder()),
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(30, 30, 30, 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  width: 60,
                  height: 60,
                  child: RaisedButton(
                    child: Icon(Icons.keyboard_arrow_right,
                        color: Colors.blueAccent),
                    color: Colors.white,
                    onPressed: () {
                      _usernameFocusNode.unfocus();
                      _passwordFocusNode.unfocus();
                    },
                    shape: CircleBorder(),
                  ),
                ),
              ],
            ),
          ),
          Spacer(),
          Container(
            padding: EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Sign up',
                    style: Theme.of(context).primaryTextTheme.button),
                Text('Forgot password',
                    style: Theme.of(context).primaryTextTheme.button),
              ],
            ),
          ),
        ],
      ),
    ]);
  }
}
