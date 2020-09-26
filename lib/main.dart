import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Switch with Shared Pref',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _status = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlutterSwitch(
              width: 125.0,
              height: 55.0,
              valueFontSize: 25.0,
              toggleSize: 45.0,
              value: _status,
              borderRadius: 50.0,
              padding: 8.0,
              showOnOff: true,
              activeTextColor: Colors.black,
              onToggle: (val) async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.setBool('status', val);

                setState(() {
                  _status = val;
                });
              },
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Status is: ${_status.toString()}',
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Status will be saved to Shared Preferences then will be loaded in the next page.',
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SharedPrefPage(),
            ),
          );
        },
        tooltip: 'View Switch with State',
        child: Icon(Icons.add),
      ),
    );
  }
}

class SharedPrefPage extends StatefulWidget {
  @override
  _SharedPrefPage createState() => _SharedPrefPage();
}

class _SharedPrefPage extends State<SharedPrefPage> {
  bool _status = false;

  getStatusFromSharedPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _status = prefs.getBool('status');
    });
  }

  @override
  void initState() {
    getStatusFromSharedPref();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlutterSwitch(
              width: 130,
              height: 55.0,
              toggleSize: 45.0,
              value: _status,
              borderRadius: 30.0,
              toggleColor: Colors.white,
              padding: 8.0,
              onToggle: (val) {
                setState(() {
                  _status = val;
                });
              },
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Status is: ${_status.toString()}',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
