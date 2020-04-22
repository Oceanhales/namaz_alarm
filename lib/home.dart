import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:ui_clock_and_alarm/shapes_painter.dart';
import 'package:ui_clock_and_alarm/widgets/alarm_item.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin{

  String _timeString;
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this, initialIndex: 0);
    _tabController.addListener(_handleTabIndex);

    _timeString = _formatDateTime(DateTime.now());
   Timer.periodic(Duration(seconds: 1), (Timer t) => _getTime());
  }

   @override
  void dispose() {
    _tabController.removeListener(_handleTabIndex);
    _tabController.dispose();
    super.dispose();
  }

  void _handleTabIndex() {
    setState(() {});
  }

  void _getTime() {
    final DateTime now = DateTime.now();
    final String formattedDateTime = _formatDateTime(now);
    setState(() {
      _timeString = formattedDateTime;
    });
  }

  String _formatDateTime(DateTime dateTime) {
    return DateFormat('hh:mm').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).primaryColor,
            bottom: TabBar(
              controller: _tabController,
              indicatorColor: Theme.of(context).accentColor,
              indicatorWeight: 4.0,
              tabs: [
                Tab(icon: Icon(Icons.access_time), text: 'Waqt',),
                Tab(icon: Icon(Icons.alarm), text: 'Salat Times'),
                Tab(icon: Icon(Icons.vpn_key), text: 'Namaz'),
                Tab(icon: Icon(Icons.timer), text: 'Tasbih '),
              ],
            ),
          ),
          body: Container(
            color: Theme.of(context).primaryColor,
            child: TabBarView(
              controller: _tabController,
              children: [
                Container(
                  child: Column(
                    children: <Widget>[  
                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: CustomPaint(
                          painter: ShapesPainter(),
                          child: Container(height: MediaQuery.of(context).size.height*.4,),
                        ),
                      ),
                      Text(_timeString.toString(), style: TextStyle(
                          color: Colors.white,
                          fontSize: 50.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'SourceSansPro'
                      ),),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Current Waqt", style: TextStyle(
                            color: Colors.green,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'SourceSansPro'
                        ),),
                      ),
                      Text("Fazar", style: TextStyle(
                          color: Colors.white,
                          fontSize: 40.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'SourceSansPro'
                      ),),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("1 hour 38 minute 17 seconds remaining", style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'SourceSansPro'
                        ),),
                      ),

                    ],
                  ),
                ),
                Container(
                  child: ListView(
                    children: <Widget>[  
                      alarmItem(_timeString, true,"Fazar"),
                      alarmItem(_timeString, false,"Ishrak"),
                      alarmItem(_timeString, false,"Duhr"),
                      alarmItem(_timeString, false,"Asr"),
                      alarmItem(_timeString, false,"Magrib"),
                      alarmItem(_timeString, false,"Auabin"),
                      alarmItem(_timeString, false,"Isha"),
                      alarmItem(_timeString, false,"Tahaddut"),
                    ],
                  ),
                ),
                Icon(Icons.hourglass_empty),
                Icon(Icons.timer),
              ],
            ),
          ),
          floatingActionButton: _bottomButtons(),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        ),
      );
  }

  Widget _bottomButtons() {
    return _tabController.index == 1
      ?FloatingActionButton(
        onPressed: () => Navigator.pushNamed(
            context,
            '/add-alarm'
        ), 
        backgroundColor: Color(0xff65D1BA),
        child: Icon(
          Icons.add,
          size: 20.0,
        ),
      )
      :null;
  }
}