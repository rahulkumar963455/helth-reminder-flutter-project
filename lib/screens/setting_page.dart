import 'package:flutter/material.dart';
import 'package:health_reminder/providers/setting_provider.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SettingProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: ListView(
        children: <Widget>[
          _buildSectionHeader('Personal Information'),
          _buildGenderSelection(context, provider),
          _buildEditableSettingItem(context, 'Weight', provider.weight, provider.updateWeight),
          _buildTimePickerSettingItem(context, 'Wake-up Time', provider.wakeUpTime, provider.updateWakeUpTime),
          _buildTimePickerSettingItem(context, 'Bedtime', provider.bedTime, provider.updateBedTime),

          _buildSectionHeader('Reminder Settings'),
          _buildSettingItem('Reminder schedule', null),

          _buildSectionHeader('General'),
          _buildEditableSettingItem(context, 'Light or Dark Interface', provider.themeMode, provider.updateThemeMode),

          _buildSectionHeader('Other'),
          _buildSettingItem('Feedback', null),
          _buildSettingItem('Share', null),
          _buildSettingItem('Privacy Policy', null),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildSettingItem(String title, String? value, {Widget? trailing}) {
    return ListTile(
      title: Text(title),
      trailing: trailing ?? (value != null ? Text(value) : null),
      onTap: () {},
    );
  }

  /// **Editable setting for text input fields (e.g., Weight, Theme Mode)**
  Widget _buildEditableSettingItem(
      BuildContext context,
      String title,
      String currentValue,
      Future<void> Function(String) updateFunction,
      ) {
    return ListTile(
      title: Text(title),
      trailing: Text(currentValue),
      onTap: () => _showEditDialog(context, title, currentValue, updateFunction),
    );
  }

  /// **Gender selection dropdown**
  Widget _buildGenderSelection(BuildContext context, SettingProvider provider) {
    return ListTile(
      title: Text("Gender"),
      trailing: DropdownButton<String>(
        value: provider.gender,
        items: ['Male', 'Female'].map((String gender) {
          return DropdownMenuItem<String>(
            value: gender,
            child: Text(gender),
          );
        }).toList(),
        onChanged: (String? newGender) {
          if (newGender != null) {
            provider.updateGender(newGender);
          }
        },
      ),
    );
  }

  /// **Time picker for Wake-up Time & Bedtime**
  Widget _buildTimePickerSettingItem(
      BuildContext context,
      String title,
      String currentValue,
      Future<void> Function(String) updateFunction,
      ) {
    return ListTile(
      title: Text(title),
      trailing: Text(currentValue),
      onTap: () => _selectTime(context, currentValue, updateFunction),
    );
  }

  /// **Dialog for editing text-based settings (Weight, Theme Mode)**
  void _showEditDialog(
      BuildContext context,
      String title,
      String currentValue,
      Future<void> Function(String) updateFunction,
      ) {
    TextEditingController controller = TextEditingController(text: currentValue);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Edit $title'),
        content: TextField(
          controller: controller,
          decoration: InputDecoration(hintText: 'Enter new value'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              updateFunction(controller.text);
              Navigator.pop(context);
            },
            child: Text('Save'),
          ),
        ],
      ),
    );
  }

  /// **Time picker dialog**
  Future<void> _selectTime(
      BuildContext context,
      String currentValue,
      Future<void> Function(String) updateFunction,
      ) async {
    TimeOfDay initialTime = _parseTime(currentValue);
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: initialTime,
    );

    if (pickedTime != null) {
      final String formattedTime = pickedTime.format(context);
      updateFunction(formattedTime);
    }
  }

  /// **Helper function to parse time from string**
  TimeOfDay _parseTime(String timeString) {
    final timeParts = timeString.split(':');
    int hour = int.parse(timeParts[0]);
    int minute = int.parse(timeParts[1].split(' ')[0]);
    if (timeString.contains('PM') && hour != 12) {
      hour += 12;
    } else if (timeString.contains('AM') && hour == 12) {
      hour = 0;
    }
    return TimeOfDay(hour: hour, minute: minute);
  }
}
