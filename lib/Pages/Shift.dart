import 'package:baby_receptionist/Design/Shade.dart';
import 'package:baby_receptionist/Design/Strings.dart';
import 'package:baby_receptionist/Pages/PettyCashEnd.dart';
import 'package:baby_receptionist/Pages/PettyCashStart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class ShiftScreen extends StatefulWidget {
  @override
  _ShiftScreenState createState() => _ShiftScreenState();
}

class _ShiftScreenState extends State<ShiftScreen> {
  final StopWatchTimer _stopWatchTimer = StopWatchTimer();
  final _isHours= true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.titleShift),
        centerTitle: false,
        backgroundColor: Shade.globalAppBarColor,
        elevation: 0.0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            StreamBuilder<int>(
              stream: _stopWatchTimer.rawTime,
              initialData: _stopWatchTimer.rawTime.value,
              builder: (context , snapshot) {
                final value = snapshot.data;
                final displaytime = StopWatchTimer.getDisplayTime(value, hours: _isHours);
              return Text(
                displaytime, style: const TextStyle(
                fontSize: 40.0,
                fontWeight: FontWeight.bold,
              ),
              );
              }
            ),
            SizedBox(
              height: 150.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                RaisedButton(
                  onPressed: (){
                    setState(() {
                      _stopWatchTimer.onExecute.add(StopWatchExecute.start);
                    });
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PettyCashStart()),
                    );
                  },
                  color: Shade.elevatorButtonBackgroundStart,
                  shape: CircleBorder(
                      side: BorderSide(color: Colors.orange[300])
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(40.0),
                    child: Text(
                      "Start",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                  ),
                ),
                RaisedButton(
                  onPressed: (){
                    _stopWatchTimer.onExecute.add(StopWatchExecute.stop);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PettyCashEnd()),
                    );
                  },
                  color: Shade.elevatorButtonBackgroundStop,
                  shape: CircleBorder(
                      side: BorderSide(color: Colors.orange[300])
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(40.0),
                    child: Text(
                      "Stop",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      )
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _stopWatchTimer.dispose();
  }
  }
