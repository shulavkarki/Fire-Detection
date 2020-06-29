import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';



class Render extends StatelessWidget {
  final List<dynamic> results;
  final int previewH;
  final int previewW;
  final double screenH;
  final double screenW;


  Render(this.results,
      this.previewH,
      this.previewW,
      this.screenH,
      this.screenW,);

  @override
  Widget build(BuildContext context) {

    double height = MediaQuery.of(context).size.height;
    double ht = (height/1.5)+20;
    double width = MediaQuery.of(context).size.width;
    
    return MaterialApp(
        
        debugShowCheckedModeBanner: false,
        home:Container(
          width : width,
          child: ListView(
                physics: NeverScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(vertical: ht,horizontal: 25),
                children: results != null
                    ? results.map((res) {
                    SizedBox(height:10);
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 13),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        
                        LinearPercentIndicator(
                        progressColor: Colors.greenAccent,
                        width: width/1.6,
                        lineHeight: 20.0,
                        percent: res["confidence"],
                        center: Text(
                          "${(res['confidence'] * 100).toStringAsFixed(0)}%",
                          style: new TextStyle(fontSize: 12.0),
                        ),),
                        Text(
                            "${res["label"]}",
                            style: TextStyle(
                              color: Colors.greenAccent,
                              fontSize: 18.0,
                              decoration: TextDecoration.none,
                            ),

                          ),
                
                      ],
                    ),
                  );
                }).toList()
                    : [],

              ),
              ),
        );
  }



}