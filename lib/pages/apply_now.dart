import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class ApplicationForm extends StatefulWidget {
  const ApplicationForm({super.key});

  @override
  _ApplicationFormState createState() => _ApplicationFormState();
}

class _ApplicationFormState extends State<ApplicationForm> {
  final _formKey = GlobalKey<FormState>();

  // Fields
  String _name = '';
  String _email = '';
  String _previousEducation = '';
  String _selectedSpecialization = '';
  List<String> specializations = ['Computer Science', 'Business', 'Design'];

  List<PlatformFile>? _selectedFiles;

  // This function handles file picking
  Future<void> _pickFiles() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'jpg', 'png'],
      allowMultiple: true,
    );

    if (result != null) {
      setState(() {
        _selectedFiles = result.files;
      });
    }
  }

  // This function handles form submission
  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      if (_selectedFiles == null || _selectedFiles!.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please upload at least one document.')),
        );
        return;
      }

      _formKey.currentState!.save();
      print('Name: $_name');
      print('Email: $_email');
      print('Previous Education: $_previousEducation');
      print('Selected Specialization: $_selectedSpecialization');
      print('Uploaded Documents: ${_selectedFiles?.map((f) => f.name).toList()}');

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Application Submitted Successfully!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Color(0xFF3556A7), // Main color for the app
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF3556A7), // Button background
            foregroundColor: Colors.white, // Button text color
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF3556A7)),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF3556A7)),
          ),
          labelStyle: TextStyle(color: Color(0xFF3556A7)),
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Application Form"),
          backgroundColor: Color(0xFF3556A7),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: 'Full Name'),
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter your name' : null,
                  onSaved: (value) => _name = value!,
                ),
                SizedBox(height: 10),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Email'),
                  validator: (value) => value!.isEmpty || !value.contains('@')
                      ? 'Please enter a valid email'
                      : null,
                  onSaved: (value) => _email = value!,
                ),
                SizedBox(height: 10),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Previous Education'),
                  validator: (value) => value!.isEmpty
                      ? 'Please enter your previous education'
                      : null,
                  onSaved: (value) => _previousEducation = value!,
                ),
                SizedBox(height: 10),
                DropdownButtonFormField(
                  decoration: InputDecoration(labelText: 'Specialization'),
                  value: _selectedSpecialization.isNotEmpty
                      ? _selectedSpecialization
                      : null,
                  items: specializations.map((specialization) {
                    return DropdownMenuItem(
                      value: specialization,
                      child: Text(specialization),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedSpecialization = value as String;
                    });
                  },
                  validator: (value) => value == null
                      ? 'Please select a specialization'
                      : null,
                ),
                SizedBox(height: 20),
                Text(
                  'Upload Documents (PDFs or Images)',
                  style: TextStyle(
                      color: Color(0xFF3556A7), fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: _pickFiles,
                  child: Text('Select Files'),
                ),
                if (_selectedFiles != null)
                  Column(
                    children:
                        _selectedFiles!.map((file) => Text(file.name)).toList(),
                  ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _submitForm,
                  child: Text('Submit Application'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

