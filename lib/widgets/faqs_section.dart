
import 'package:flutter/material.dart';

class FaqsSection extends StatelessWidget {
  const FaqsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 10,
        ),
        child: Column(
          children: [
            _buildExpandableSection(
              title: 'Steps to Complete the Application:',
              children: _buildStepList(),
            ),
            _buildExpandableSection(
              title: 'Frequently Asked Questions (FAQs):',
              children: _buildFAQs(),
            ),
            _buildExpandableSection(
              title: 'Tips to Simplify the Application Process:',
              children: _buildTips(),
            ),
          ],
        ),
      ),
    );
  }

  // Build Expandable Section
  Widget _buildExpandableSection({
    required String title,
    required List<Widget> children,
  }) {
    return ExpansionTile(
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.blue,
        ),
      ),
      children: children,
    );
  }

  // Build List of Steps
  List<Widget> _buildStepList() {
    List<String> steps = [
      'Visit the registration page on the app.',
      'Enter your National ID and required details.',
      'Fill in the application form and ensure accuracy.',
      'Upload the required documents in PDF or JPEG format.',
      'Track your application status through the "My Application" page.',
    ];
    return steps
        .map(
          (step) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Text(
              step,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        )
        .toList();
  }

  // Build FAQs Section with New Questions
  List<Widget> _buildFAQs() {
    List<Map<String, String>> faqs = [
      {
        'question': 'What documents are required for application?',
        'answer':
            'National ID, academic certificates, and any additional documents requested.'
      },
      {
        'question': 'How can I track the status of my application?',
        'answer':
            'Log in and go to the "My Application" section to track the status.'
      },
      {
        'question': 'Can I modify my application after submission?',
        'answer': 'Yes, if the modification is within the submission period.'
      },
      {
        'question': 'Can I apply after the deadline?',
        'answer':
            'Applications cannot be accepted after the deadline. All documents must be submitted on time.'
      },
      {
        'question': 'Do I need to submit original documents?',
        'answer':
            'You can submit copies of the documents, but they must be clear and verifiable.'
      },
      {
        'question': 'Can I modify my data after submitting the application?',
        'answer':
            'You can modify some data through the "Edit Application" page if there is a modification period after submission.'
      },
      {
        'question': 'Do I need to pay a fee to apply?',
        'answer':
            'Some programs may require a fee. Please refer to the "Fees" page for more details.'
      },
      {
        'question': 'Can I apply through mobile?',
        'answer':
            'Yes, you can easily submit your application via the app on your mobile device.'
      },
      {
        'question': 'What is the maximum number of documents I can submit?',
        'answer': 'You can upload up to 5 documents per application.'
      },
      {
        'question':
            'Do I need to be registered at the academy to start applying?',
        'answer':
            'Yes, you must have an account at the academy to submit an application.'
      },
    ];

    return faqs
        .map(
          (faq) => ExpansionTile(
            title: Text(
              faq['question']!,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  faq['answer']!,
                  style: const TextStyle(fontSize: 16, color: Colors.black54),
                ),
              ),
            ],
          ),
        )
        .toList();
  }

  // Build Tips Section
  List<Widget> _buildTips() {
    List<String> tips = [
      'Ensure that your attached documents are clear.',
      'Enter your personal information accurately.',
      'Start the application process early to avoid any issues.',
      'Stay updated with notifications regarding your application status.',
    ];
    return tips
        .map(
          (tip) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Text(
              tip,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        )
        .toList();
  }
}
