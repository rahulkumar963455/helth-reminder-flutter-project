// ignore_for_file: sort_child_properties_last, dead_code, no_leading_underscores_for_local_identifiers, use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:health_reminder/screens/main_screen.dart';

class UserInputData extends StatefulWidget {
  const UserInputData({super.key});

  @override
  State<UserInputData> createState() => _UserInputDataState();
}

class _UserInputDataState extends State<UserInputData> {
  // List<bool> for selection state
  List<bool> isSelected = [true, false]; // Default: "Male" selected
  TextEditingController nameController = TextEditingController();
   TextEditingController ageController = TextEditingController();
    TextEditingController weightController = TextEditingController();
    TextEditingController timeController = TextEditingController();
    TextEditingController bedtimeController = TextEditingController();

    void isValid(){
      if(nameController)
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        flexibleSpace: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [const Color.fromARGB(255, 33, 243, 191), const Color.fromARGB(255, 161, 35, 155)], // Gradient colors
          begin: Alignment.topLeft,  // Start point
          end: Alignment.bottomRight, // End point
        ),
      ),
    ),
        title: Text("Health reminder"),
        actions: [
          IconButton(
            icon: Icon(Icons.alarm),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 10,right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20,),
            _buildToggleButton(), // ✅ Corrected function call
            Spacer(),
            _buildCustomTextField(
              controller: nameController,
              keyboardType: TextInputType.text,
              label: "Name",
              maxLength: 30,
              prefixIcon: Icons.person
            ),
            Spacer(),
            _buildCustomTextField(
              controller: ageController,
              keyboardType: TextInputType.number,
              label: "Age",
              prefixIcon: Icons.person
            ),
            Spacer(),
            _buildCustomTextField(
              controller: weightController,
              keyboardType: TextInputType.number,
              label: "Weight In Kg",
              prefixIcon: Icons.person
            ),
           Spacer(),
           _buildTimeInputField(
            context: context, 
            controller: timeController,
            label:'Wakeup time'),

           Spacer(),
           _buildTimeInputField(
            context: context, 
            controller: bedtimeController,
            label:'Bedtime'),

            Spacer(),
            ElevatedButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => MainScreen()));
              },
              style: ElevatedButton.styleFrom(
               minimumSize: Size(200, 50),
               backgroundColor: Colors.cyan
              ),
               child: Text("Login",style: TextStyle(fontSize: 20,color: Colors.white),)),

            Spacer(flex: 4,)
          ],
        ),
      ),
    );
  }

  // ✅ Move _buildToggleButton outside build()
  Widget _buildToggleButton() {
    return ToggleButtons(
      isSelected: isSelected,
      onPressed: (int index) {
        setState(() {
          // Single selection behavior
          for (int i = 0; i < isSelected.length; i++) {
            isSelected[i] = (i == index);
          }
        });
      },
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Text("Male"),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text("Female"),
        ),
      ],
      color: Colors.black,
      selectedColor: Colors.white,
      fillColor: Colors.blue, // Background when selected
      borderRadius: BorderRadius.circular(20),
      borderWidth: 2,
    );
  }
 Widget _buildCustomTextField({
  required TextEditingController controller,
  String label = "Enter text",
  TextInputType keyboardType = TextInputType.text,
  bool obscureText = false,
  int maxLength=3,
  IconData? prefixIcon,
}) {
  return TextField(
    controller: controller,
    keyboardType: keyboardType,
    obscureText: obscureText,
    maxLength: maxLength,
    decoration: InputDecoration(
      label: Text(label),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Colors.grey),
      ),
      prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
      contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
    ),
  );
}

Widget _buildTimeInputField({
  required BuildContext context,
  required TextEditingController controller,
  String label = "Select Time",
  IconData icon = Icons.access_time,
}) {
  return TextField(
    controller: controller,
    readOnly: true, // Prevents manual input
    decoration: InputDecoration(
      label: Text(label),
      prefixIcon: Icon(icon),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
    onTap: () async {
      TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now()
      );

      if (pickedTime != null) {
        // Format Time to AM/PM
        String formattedTime = pickedTime.format(context);
        controller.text = formattedTime; // Update the controller
      }
    },
  );
}


}
