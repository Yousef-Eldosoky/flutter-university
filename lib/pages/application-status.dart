import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: const Color(0xFF3f51b5),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF3f51b5)),
      ),
      home: const ApplicationStatusPage(),
    );
  }
}

class ApplicationStatusPage extends StatelessWidget {
  const ApplicationStatusPage({super.key});

  final String currentStatus = 'pending';

  Widget buildStatusCard(String status) {
    IconData statusIcon;
    Color statusColor;
    String statusText;
    String statusDescription;

    switch (status) {
      case 'approved':
        statusIcon = Icons.check_circle;
        statusColor = Colors.green;
        statusText = 'Approved';
        statusDescription = 'Your application has been approved!';
        break;
      case 'on_hold':
        statusIcon = Icons.pause_circle_filled;
        statusColor = Colors.orange;
        statusText = 'On Hold';
        statusDescription = 'Your application is currently on hold.';
        break;
      case 'rejected':
        statusIcon = Icons.cancel;
        statusColor = Colors.red;
        statusText = 'Rejected';
        statusDescription = 'Your application has been rejected.';
        break;
      default:
        statusIcon = Icons.hourglass_empty;
        statusColor = Colors.blue;
        statusText = 'Pending';
        statusDescription = 'Your application is being reviewed.';
    }

    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              statusIcon,
              size: 64,
              color: statusColor,
            ),
            const SizedBox(height: 16),
            Text(
              statusText,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: statusColor,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              statusDescription,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Application Status'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 40),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildStatusCard(currentStatus),
          ],
        ),
      ),
    );
  }
}
