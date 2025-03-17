import 'package:flutter/material.dart';
import 'package:health_reminder/providers/input_data_provider.dart';
import 'package:provider/provider.dart';
import 'package:health_reminder/screens/main_screen.dart';

class UserInputData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UserDataProvider>(context, listen: true);
    provider.loadUserData(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(left: 10, right: 20,top: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            _buildToggleButton(provider),
            Spacer(),
            _buildCustomTextField(
              controller: provider.nameController,
              label: "Name",
              maxLength: 30,
              prefixIcon: Icons.person,
            ),
            Spacer(),
            _buildCustomTextField(
              controller: provider.ageController,
              label: "Age",
              keyboardType: TextInputType.number,
              prefixIcon: Icons.cake,
            ),
            Spacer(),
            _buildCustomTextField(
              controller: provider.weightController,
              label: "Weight in Kg",
              keyboardType: TextInputType.number,
              prefixIcon: Icons.fitness_center,
            ),
            Spacer(),
            _buildTimeInputField(
              context: context,
              controller: provider.timeController,
              label: 'Wakeup Time',
              provider: provider,
            ),
            Spacer(),
            _buildTimeInputField(
              context: context,
              controller: provider.bedtimeController,
              label: 'Bedtime',
              provider: provider,
            ),
            Spacer(),
            ElevatedButton(
              onPressed: provider.isValid
                  ? () async {
                await provider.saveUserData();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => MainScreen()),
                );
              }
                  : null,
              style: ElevatedButton.styleFrom(
                minimumSize: Size(200, 50),
                backgroundColor: provider.isValid ? Colors.cyan : Colors.grey,
              ),
              child: Text(
                "Login",
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
            Spacer(flex: 4),
          ],
        ),
      ),
    );
  }

  Widget _buildToggleButton(UserDataProvider provider) {
    return ToggleButtons(
      isSelected: [provider.isMale, !provider.isMale],
      onPressed: (int index) {
        provider.toggleGender(index == 0);
      },
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text("Male"),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text("Female"),
        ),
      ],
      color: Colors.black,
      selectedColor: Colors.white,
      fillColor: Colors.blue,
      borderRadius: BorderRadius.circular(20),
      borderWidth: 2,
    );
  }

  Widget _buildCustomTextField({
    required TextEditingController controller,
    String label = "Enter text",
    TextInputType keyboardType = TextInputType.text,
    bool obscureText = false,
    int maxLength = 3,
    IconData? prefixIcon,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      maxLength: maxLength,
      decoration: InputDecoration(
        labelText: label,
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
    required UserDataProvider provider,
    String label = "Select Time",
    IconData icon = Icons.access_time,
  }) {
    return TextField(
      controller: controller,
      readOnly: true,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onTap: () => provider.updateTimeController(controller, context),
    );
  }
}
