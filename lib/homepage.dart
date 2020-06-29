import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:tflite/tflite.dart';
import 'dart:math' as math;
import 'package:flutter/services.dart';

import 'camera.dart';
import 'render.dart';


const String ssd = "Get Started";


class HomePage extends StatefulWidget {
  final List<CameraDescription> cameras;

  HomePage(this.cameras);

  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<dynamic> _recognitions;
  int _imageHeight = 0;
  int _imageWidth = 0;
  String _model = "";

  @override
  void initState() {
    super.initState();
  }

  loadModel() async {
    String res;

    switch (_model) {
      default:
        res = await Tflite.loadModel(
            model: "assets/model_unquant.tflite",
            labels: "assets/labels.txt",);



        break;
    }
    print(res);

  }

  onSelect(model) {
    setState(() {
      _model = model;
    });
    loadModel();
  }

  setRecognitions(recognitions, imageHeight, imageWidth) {
    setState(() {
      _recognitions = recognitions;
      _imageHeight = imageHeight;
      _imageWidth = imageWidth;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    double width = MediaQuery.of(context).size.width;
    SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
    ]);
    return Container(
      child: Scaffold(
      appBar: PreferredSize(preferredSize: Size.fromHeight(30.0) , child: AppBar( centerTitle: true,title: const Text("Fire Detection"))),
      body: _model == ""
          ? Container(
        child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(40.0),
                    child: Container(
                      child:Row(
              
                        children: <Widget>[
                          Icon(Icons.info),
                    Text('Press classify to open camera  and get \nstarted  with classification.',
                    style: TextStyle(fontSize: 20,fontStyle:FontStyle.italic),),
                        ],
                      
                      
                    )),
                  ),
                  
                Padding(
                padding: EdgeInsets.symmetric(vertical: 20,horizontal: width/3),
                child: GestureDetector(
                onTap: () => onSelect(ssd),
                child: Container(
                    width: width/3,
                    height: 60,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.blueGrey,
                          Colors.blueGrey[800],
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          offset: Offset(5, 5),
                          blurRadius: 10,
                        )
                      ],
                    ),
                    child: Center(
                      
                      child: Text(
                        "Classify",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                ),
            ),
                 ),
                  

                  ],
              ),
            )
          : Stack(
              children: [
                Container(child:Camera(
                  widget.cameras,
                  _model,
                  setRecognitions,
                )),
                Render(_recognitions == null ? [] : _recognitions,
                  math.max(_imageHeight, _imageWidth),
                  math.min(_imageHeight, _imageWidth),
                  screen.height,
                  screen.width,

                ),

              ],
            ),
    ));
  }
}
