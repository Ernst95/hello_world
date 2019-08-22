import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Start the app with the "/" named route. In this case, the app starts
      // on the FirstScreen widget.
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/second': (context) => SecondScreen(),
        '/passArguments': (context) => PassArgumentsScreen(),
      }

    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    Widget titleSection = Container(
      padding: const EdgeInsets.all(32),
      child: Row(
        children: [
          Expanded(
            /*1*/
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /*2*/
                Container(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    'Princess Vlei',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  'Cape Town, South Africa',
                  style: TextStyle(
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),
          /*3*/
          FavouriteWidget(),
        ],
      ),
    );

    Column _buildButtonColumn(Color color, IconData icon, String label) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: Icon(icon),
            color: color,
            onPressed: () {
              Navigator.pushNamed(context, '/second');
            },
          ),
          Container(
            margin: const EdgeInsets.only(top: 8),
            child: Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: color,
              ),
            ),
          ),
        ],
      );
    }

    Color color = Theme.of(context).primaryColor;

    Widget buttonSection = Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildButtonColumn(color, Icons.call, 'Call'),
          _buildButtonColumn(color, Icons.near_me, 'Route'),
          _buildButtonColumn(color, Icons.share, 'Share'),
        ],
      ),
    );

    Widget textSection = Container(
      padding: const EdgeInsets.all(32),
      child: Text(
        'The Vlei was named after a Khoisan Princess, who, according to local legend. '
        'was abducted by Portuguese sailors while bathing in its waters. '
        'During the years of apartheid, it became one of the few natural areas that “coloured” people could visit, '
        'after they were forcibly removed by the government to housing estates on the Cape Flats. '
        'Though loved by the people, it was neglected by the authorities, '
        'and became further degraded when a road was built through it with little regard for conserving its ecology. ',
        softWrap: true,
      ),
    );

    Widget submitButton = Container(
      child: RaisedButton(
        child: Text('Open Route'),
        onPressed: () {
          Navigator.pushNamed(context, '/second');
        },
      ),
    );

    Widget passButton = Container(
      child: RaisedButton(
        child: Text('Pass Arguments Screen'),
        onPressed: () {
          Navigator.pushNamed(
            context,
            '/passArguments',
            arguments: ScreenArguments(
              'Pass Arguments Screen',
              'This message is extracted in the build method.',
            ),
          );
        },
      ),
    );

    Widget buttonNavigationSection = Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          submitButton,
          passButton,
        ],
      ),
    );

    return Scaffold(
        appBar: AppBar(
          title: Text('Flutter layout demo'),
        ),
        body: ListView(
          children: [
            Image.asset(
              'images/lake.jpg',
              width: 600,
              height: 240,
              fit: BoxFit.cover,
            ),
            titleSection,
            buttonSection,
            textSection,
            buttonNavigationSection,
          ],
        ),
      );
  }
}

class FavouriteWidget extends StatefulWidget {
  @override
  _FavouriteWidgetState createState() => _FavouriteWidgetState();
}

class _FavouriteWidgetState extends State<FavouriteWidget> {
  bool _isFavourited = true;
  int _favouriteCount = 41;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: EdgeInsets.all(0),
          child: IconButton(
            icon: (_isFavourited ? Icon(Icons.star) : Icon(Icons.star_border)),
            color: Colors.red[500],
            onPressed: _toggleFavourite,
          ),
        ),
        SizedBox(
          width: 18,
          child: Container(
            child: Text('$_favouriteCount'),
          ),
        ),
      ],
    );
  }

  void _toggleFavourite() {
    setState(() {
      if (_isFavourited) {
        _favouriteCount -= 1;
        _isFavourited = false;
      } else {
        _favouriteCount += 1;
        _isFavourited = true;
      }
    });
  }

}

class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Second Route'),
      ),
      body: Center(
        child: RaisedButton(
          child: Text('Go back!'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }

}

class ScreenArguments {
  final String title;
  final String message;

  ScreenArguments(this.title, this.message);
}

class PassArgumentsScreen extends StatelessWidget {
  //static const routeName = '/extractArguments';

  final String title;
  final String message;

  const PassArgumentsScreen({
    Key key,
    @required this.title,
    @required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Text(message),
      ),
    );
  }
}
