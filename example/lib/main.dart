import 'package:flutter/material.dart';

import 'package:gramola_timeline/gramola_timeline.dart';
import 'package:gramola_timeline/config/stores.dart';

import 'package:flutter/rendering.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    debugPaintSizeEnabled = false;
    debugPaintLayerBordersEnabled = false;
    debugPaintBaselinesEnabled = false;
    debugPaintPointersEnabled = false;

    return new MaterialApp(
      title: 'Gramola Timeline Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'Gramola Timeline Demo Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  void _showSnackbar (String message) {
    final snackbar = new SnackBar(
      content: new Text(message),
    );

    scaffoldKey.currentState.showSnackBar(snackbar);
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController _eventIdFieldController = new TextEditingController();
    final TextEditingController _userIdFieldController = new TextEditingController();
    Container formSection = new Container(
      padding: const EdgeInsets.fromLTRB(20.0, 8.0, 20.0, 16.0),
      child: new Row(
        children: [
          new Expanded(
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                new ListTile(
                  leading: const Icon(Icons.event),
                  title: new TextField(
                    controller: _eventIdFieldController,
                    autocorrect: false,
                    decoration: new InputDecoration(
                      hintText: "Event ID",
                    ),
                  ),
                ),
                new ListTile(
                  leading: const Icon(Icons.person),
                  title: new TextField(
                    controller: _userIdFieldController,
                    autocorrect: false,
                    decoration: new InputDecoration(
                      hintText: "User ID",
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );

    return new Scaffold(
      key: scaffoldKey,
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            formSection,
            new Container(
                padding: const EdgeInsets.fromLTRB(32.0, 28.0, 32.0, 8.0),
                child: new RaisedButton(
                    child: new Text('Show timeline'),
                    color: Theme.of(context).primaryColor,
                    textColor: Colors.white,
                    onPressed: () {
                      Navigator.push(
                        context,
                        new MaterialPageRoute(
                          builder: (context) => new EventTimelineComponent(
                            new TimelineConfiguration(
                              eventId: _eventIdFieldController.text, 
                              userId: _userIdFieldController.text, 
                              //timelineApi: 'http://timeline-gramola-cicd.apps.192.168.50.100.nip.io/api/timeline',
                              //imagesBaseUrl: 'http://files-gramola-cicd.apps.192.168.50.100.nip.io/api/files'
                              timelineApi: 'http://localhost:8001/api/timeline',
                              imagesBaseUrl: 'http://localhost:8001/api/files'
                            )
                          )
                        ),
                      );
                    }
                )
            )
          ],
        ),
      )// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
