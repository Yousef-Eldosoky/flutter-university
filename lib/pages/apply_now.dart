import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class ApplicationForm extends StatefulWidget {
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
  String _nationalId = '';
  List<String> specializations = ['Computer Science', 'Business', 'Design'];

  List<PlatformFile>? _selectedFiles;

  // File picker function
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

  // Submit form with validation
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
      print(
          'Uploaded Documents: ${_selectedFiles?.map((f) => f.name).toList()}');

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Application Submitted Successfully!')),
      );
    }
  }

  // Reset the form (useful for "Back" button on a single-page app)
  void _resetForm() {
    setState(() {
      _name = '';
      _email = '';
      _previousEducation = '';
      _selectedSpecialization = '';
      _nationalId = '';
      _selectedFiles = null;
    });
    _formKey.currentState!.reset();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Color(0xFF3556A7),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF3556A7),
            foregroundColor: Colors.white,
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
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 4,
                  blurRadius: 6,
                  offset: Offset(0, 3), // Shadow position
                ),
              ],
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    _buildStyledField(
                      labelText: 'Full Name',
                      icon: Icons.person,
                      initialValue: _name,
                      validator: (value) =>
                          value!.isEmpty ? 'Please enter your name' : null,
                      onSaved: (value) => _name = value!,
                    ),
                    SizedBox(height: 15),
                    _buildStyledField(
                      labelText: 'Email',
                      icon: Icons.email,
                      initialValue: _email,
                      validator: (value) =>
                          value!.isEmpty || !value.contains('@')
                              ? 'Please enter a valid email'
                              : null,
                      onSaved: (value) => _email = value!,
                    ),
                    SizedBox(height: 15),
                    _buildStyledField(
                      labelText: 'Previous Education',
                      icon: Icons.school,
                      initialValue: _previousEducation,
                      validator: (value) => value!.isEmpty
                          ? 'Please enter your previous education'
                          : null,
                      onSaved: (value) => _previousEducation = value!,
                    ),
                    SizedBox(height: 15),
                    _buildStyledField(
                      labelText: 'National ID',
                      icon: Icons.person,
                      initialValue: _nationalId,
                      validator: (value) => value!.isEmpty
                          ? 'Please enter your National ID'
                          : null,
                      onSaved: (value) => _previousEducation = value!,
                    ),
                    SizedBox(height: 15),
                    DropdownButtonFormField(
                      value: _selectedSpecialization.isNotEmpty
                          ? _selectedSpecialization
                          : null,
                      decoration: InputDecoration(
                        labelText: 'Specialization',
                        prefixIcon:
                            Icon(Icons.category, color: Color(0xFF3556A7)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
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
                          color: Color(0xFF3556A7),
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    ElevatedButton.icon(
                      onPressed: _pickFiles,
                      icon: Icon(Icons.file_upload),
                      label: Text('Select Files'),
                    ),
                    if (_selectedFiles != null)
                      Column(
                        children: _selectedFiles!
                            .map((file) => Text(file.name))
                            .toList(),
                      ),
                    SizedBox(height: 20),
                    ElevatedButton.icon(
                      onPressed: _submitForm,
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 12),
                      ),
                      icon: Icon(Icons.send),
                      label: Text('Submit Application'),
                    ),
                    SizedBox(height: 10),
                    ElevatedButton.icon(
                      onPressed: () {
                        if (Navigator.canPop(context)) {
                          Navigator.pop(context); // Navigate back
                        } else {
                          _resetForm(); // Reset the form
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 12),
                      ),
                      icon: Icon(Icons.arrow_back),
                      label: Text('Back'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Helper method for styled text fields
  Widget _buildStyledField({
    required String labelText,
    required IconData icon,
    required String? initialValue,
    required String? Function(String?)? validator,
    required void Function(String?) onSaved,
  }) {
    return TextFormField(
      initialValue: initialValue,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: Icon(icon, color: Color(0xFF3556A7)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      validator: validator,
      onSaved: onSaved,
    );
  }
}
