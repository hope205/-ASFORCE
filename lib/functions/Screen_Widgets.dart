import 'package:flutter/material.dart';
import 'network.dart';
import 'package:asforce/Notifications/LocalNotifyManager.dart';
import 'task_data.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'dart:math';
import 'package:asforce/functions/cloud.dart';
import 'package:asforce/functions/network.dart';

CloudFunctions database = CloudFunctions();
Helper Network_help = Helper();
// //this class contains the code for buiding the switch buttons  on screen when the app loads up
// //  it takes the namet of the switch to be built as an input
// class Switchs extends StatelessWidget {
//   final String name;
//
//   Switchs({
//     @required this.name,
//   });
//   @override
//   Widget build(BuildContext context) {
//     //this lines initailises the switch state using its name to 0
//
//     bool stat = Provider.of<Data>(context, listen: true).SwitchState(name);
//
//     return FlutterSwitch(
//       value: stat,
//       onToggle: (val) {
//         //on toggle, it updates the value of the switch state depending
//         //on the users action
//         Provider.of<Data>(context, listen: false)
//             .changStatus(value: val, identity: name);
//       },
//       activeColor: Colors.green,
//       // inactiveColor: Colors.red[200],
//       inactiveColor: Colors.lightBlueAccent,
//
//       // toggleColor: Colors.blueGrey[700],
//       toggleColor: Colors.white,
//     );
//   }
// }

//this class contains the code for buiding the guages  on screen when the app loads up
//  it continue checsk the database for any change in the value of the moisture content
//and updates itself accordingly

class Guages extends StatelessWidget {
  double height;
  final String name;

  Guages({this.height, @required this.name});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      width: 190,
      child: SfRadialGauge(
        axes: <RadialAxis>[
          RadialAxis(
            minimum: 0,
            maximum: 100,
            showLabels: false,
            showTicks: false,
            radiusFactor: 0.8,
            axisLineStyle: AxisLineStyle(
                cornerStyle: CornerStyle.bothCurve,
                color: Colors.black12,
                thickness: 25),
            pointers: <GaugePointer>[
              RangePointer(
                value: height,
                cornerStyle: CornerStyle.bothCurve,
                width: 25,
                sizeUnit: GaugeSizeUnit.logicalPixel,
                gradient: const SweepGradient(
                  colors: <Color>[
                    Color(0xFFCC2B5E),
                    Color(0xFF753A88),
                    Colors.green
                  ],
                  stops: <double>[0.25, 0.50, 0.80],
                ),
              ),
              MarkerPointer(
                  value: height,
                  enableDragging: false,
                  // onValueChanged: onVolumeChanged,
                  markerHeight: 25,
                  markerWidth: 25,
                  markerType: MarkerType.circle,
                  color: Color(0xFF753A88),
                  // color: Color(0xFFCC2B5E),
                  borderWidth: 1,
                  borderColor: Colors.white54)
            ],
            annotations: <GaugeAnnotation>[
              GaugeAnnotation(
                angle: 90,
                axisValue: 1,
                positionFactor: 0.1,
                widget: Text(
                  name == 'Current'
                      ? height.ceil().toString() + 'A'
                      : name == 'Voltage'
                          ? height.ceil().toString() + 'V'
                          : height.ceil().toString() + 'W',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFCC2B5E)),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

//this houses both the switch and the guage widget
class Content extends StatefulWidget {
  final String item;

  Content({
    this.item,
  });
  @override
  _ContentState createState() => _ContentState();
}

class _ContentState extends State<Content> {
  double _volumeValue = 60.6;

  double length = 0.0;
  double height = 0.0;

  // Random _random;
  // static double _value = 10;
  // static String _title = '10';

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        children: [
          // SizedBox(
          //   width: 90,
          // ),
          Container(
            // height: ,
            child: Column(
              children: [
                StreamBuilder(
                  stream: databaseRef.child(widget.item).onValue,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      // return Text('not yet');
                      return Guages(
                        height: 0.0,
                        // Provider.of<Data>(context, listen: false)
                        //     .height_1[widget.item],
                        // height: 0.0,
                        name: widget.item,
                      );
                    } else {
                      int f = snapshot.data.snapshot.value;
                      print(f);
                      // height = ret[widget.item];
                      height = f.toDouble();
                      return Guages(
                        height: height,
                        name: widget.item,
                      );
                    }
                  },
                ),
                SizedBox(
                  height: 2,
                ),
                Text(
                  widget.item,
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
          ),
          Container(
            height: 20,
          ),
        ],
      ),
    );
  }
}
