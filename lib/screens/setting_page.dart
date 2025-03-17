import 'package:flutter/material.dart';
class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: ListView(
        children: <Widget>[
          _buildSectionHeader('Personal information'),
          _buildSettingItem('Gender', 'Male'),
          _buildSettingItem('Weight', '57 kg'),
          _buildSettingItem('Wake-up time', '06:00 am'),
          _buildSettingItem('Bedtime', '10:00 pm'),
          _buildSectionHeader('Reminder settings'),

         _buildSettingItem('Reminder schedule', null),
      //    _buildSettingItem('Reminder sound', null),
        //  _buildSettingItem('Reminder mode', 'As device settings'),
         // _buildSettingItem('Further reminder', 'Still remind when your goal is achieved', trailing: Switch(value: true, onChanged: (value) {})),

         // _buildSectionHeader('General'),
           _buildSettingItem('Light or dark interface', 'Default'),
         //  _buildSettingItem('Unit', 'kg, ml'),
         //  _buildSettingItem('Intake goal', '1720 ml'),
         //  _buildSettingItem('Language', 'Default'),


          _buildSectionHeader('Other'),
          // _buildSettingItem(
          //   'Hide tips on how to drink water',
          //   null,
          //   trailing: Switch(value: true, onChanged: (value) {}),
          // ),
          // _buildSettingItem('Why does Drink Water Reminder not work?', null),
          // _buildSettingItem('Reset data', null),
          _buildSettingItem('Feedback', null),
          _buildSettingItem('Share', null),
          _buildSettingItem('Privacy policy', null),
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
      onTap: () {
        // Handle tap on the setting item
      },
    );
  }
}