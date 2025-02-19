// ignore_for_file: deprecated_member_use, non_constant_identifier_names, sort_child_properties_last, avoid_unnecessary_containers, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Health"),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 33, 243, 191),
                Color.fromARGB(255, 161, 35, 155)
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(top: 10),
            child: _buildStepsCard(
              steps: 30000,
              goal: 5000,
              isVisible: true, // Renamed "Check" to "isVisible" for clarity
              cardText: "Today's Steps",
              calories: 300,
              distance: 3000,
              icon: Icons.directions_walk,
              caloriOrMycup: "Calorie",
              distanceOrNextReminder: "Distance",
              calorieIcon: Icons.local_fire_department,
              distanceIcon: Icons.gps_fixed,
              stepsOrMl: 'Steps',
              kcalOrMl: 'kcal',
            ),
          ),
          const SizedBox(height: 10),
          Container(
            margin: const EdgeInsets.only(top: 10),
            child: _buildStepsCard(
              steps: 300,
              goal: 5000,
              isVisible: false,
              cardText: "Water Intake",
              calories: 200,
              distance: 3000,
              icon: Icons.local_drink,
              caloriOrMycup: "My cup",
              distanceOrNextReminder: "Next reminder",
              calorieIcon: Icons.local_drink,
              distanceIcon: Icons.notification_add,
              stepsOrMl: 'ml',
              kcalOrMl: 'ml',
            ),
          ),
          SizedBox(height: 10,),
          _buildCustomGauge(58.0,50)
      
          
        ],
      ),
    );
  }

  // Function to build the "Steps" or "Water Intake" Card
  Widget _buildStepsCard({
    required int steps,
    required int goal,
    required int calories,
    required int distance,
    required IconData icon,
    required String cardText,
    required String caloriOrMycup,
    required String distanceOrNextReminder,
    required String stepsOrMl,
    required IconData calorieIcon,
    required IconData distanceIcon,
    required bool isVisible, // Renamed from "Check"
    required String kcalOrMl,
  }) {

    double progress = (steps / goal).clamp(0.0, 1.0); // Ensure progress is between 0-1
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 5,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header: Title + Share Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    cardText,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  if(isVisible)
                  GestureDetector(
                    onTap: () {
                      
                    },
                    child: const Text(
                      "Share",
                      style: TextStyle(color: Colors.orange, fontSize: 18),
                    ),
                  )
          ],
              ),
            ),
            const SizedBox(height: 50),

            // Circular Progress + Steps Count
            Row(
              children: [
                // Circular Progress Bar
                Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: 80,
                      height: 80,
                      child: CircularProgressIndicator(
                        value: progress,
                        strokeWidth: 8,
                        valueColor: const AlwaysStoppedAnimation<Color>(Colors.cyan),
                        backgroundColor: Colors.grey[300]!,
                      ),
                    ),
                    Icon(icon, color: Colors.cyan, size: 30),
                  ],
                ),
                const SizedBox(width: 150,),

                // Step Count + Goal
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [
                      Text(
                      "$steps",
                      style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 5,),
                    Text(
                      stepsOrMl,
                      style: const TextStyle(color: Color.fromARGB(255, 26, 25, 25), fontSize: 15),
                    ),
                    ],),
                    const SizedBox(height: 5),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.cyan.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Goal $goal",
                            style: const TextStyle(color: Colors.cyan, fontSize: 15),
                          ),
                          GestureDetector(
                            child: const Icon(Icons.edit, size: 15, color: Colors.cyan),
                            onTap: () {
                            
                            },
                          ),
                        
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 50),
            // Calorie & Distance Row
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildInfoRow(calorieIcon, caloriOrMycup, "$calories $kcalOrMl"),
                  isVisible == true?
                  _buildInfoRow(distanceIcon, distanceOrNextReminder, "$distance m"):
                  _buildInfoRow(distanceIcon, distanceOrNextReminder, 'None >')
                ],
              ),
            ),
            isVisible == true  ? SizedBox() :
            Container(
              margin: EdgeInsets.only(left: 6,top: 40),
              child: ElevatedButton(onPressed: (){}, 
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.cyan,
                minimumSize: Size(350, 45),
                ),
              child: Text("DRINK 1 CUP",style: TextStyle(
                fontSize: 20,
                color: const Color.fromARGB(255, 248, 241, 241)
              ),)),
            )
          ],
        ),
      ),
    );
  }

  // Function to build Info Rows (Calories & Distance)
  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, color: Colors.grey, size: 35),
        const SizedBox(width: 5),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: const TextStyle(color: Color.fromARGB(255, 77, 76, 76), fontSize: 15)),
            Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ],
    );
  }
  Widget _buildCustomGauge(double value, int weight) {
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: Card(
      child: Column( 
        crossAxisAlignment: CrossAxisAlignment.center,   
        children: [
          Text("My Weight", style: TextStyle(
            fontSize: 20,
          ),),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children:[ Text(weight.toString(),style: TextStyle(
              fontSize: 50
            ),),
            SizedBox(width: 5,),
            Text("Kg",style: TextStyle(
              fontSize: 20
            ),)
            ]
          ),
          Container(
            margin: EdgeInsets.only(left: 40,right: 40),
              child: SfRadialGauge(
              axes: <RadialAxis>[
              RadialAxis(
                minimum: 0,
                maximum: 100,
                startAngle: 180,
                endAngle: 0,
                showLabels: false,
                showTicks: false,
                axisLineStyle: AxisLineStyle(
                  thickness: 15,
                ),
                ranges: <GaugeRange>[
                  GaugeRange(startValue: 0, endValue: 25, color: Colors.red, startWidth: 15, endWidth: 15),
                  GaugeRange(startValue: 25, endValue: 50, color: Colors.orange, startWidth: 15, endWidth: 15),
                  GaugeRange(startValue: 50, endValue: 75, color: Colors.yellow, startWidth: 15, endWidth: 15),
                  GaugeRange(startValue: 75, endValue: 100, color: Colors.green, startWidth: 15, endWidth: 15),
                ],
                pointers: <GaugePointer>[
                  MarkerPointer(
                    value: value,
                    markerHeight: 20.0,
                    markerOffset: 10,
                    markerWidth: 20.0,
                    color: Colors.purpleAccent
                    ),
                ],
                annotations: <GaugeAnnotation>[
                  GaugeAnnotation(
                    widget: Text("Light", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                    positionFactor: 1.2,
                    angle: 180,
                  ),
                  GaugeAnnotation(
                    widget: Text("Heavy", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                    positionFactor: 1.2,
                    angle: 0,
                  ),
                ],
              ),
            ],
          ),
          ),
        ]
      ),
    ),
  );
}
}
