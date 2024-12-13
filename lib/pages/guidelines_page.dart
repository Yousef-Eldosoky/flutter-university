import 'package:flutter/material.dart';

class GuidelinesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'الإرشادات والتعليمات',
          style: TextStyle(fontSize: 20),
        ),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section 1: Title and Steps
            Text(
              'خطوات إتمام عملية التقديم:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            SizedBox(height: 10),
            ..._buildStepList(),

            Divider(height: 30, thickness: 1),

            // Section 2: FAQs
            Text(
              'الأسئلة الشائعة (FAQs):',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            SizedBox(height: 10),
            ..._buildFAQs(),

            Divider(height: 30, thickness: 1),

            // Section 3: Tips
            Text(
              'نصائح لتسهيل عملية التقديم:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            SizedBox(height: 10),
            ..._buildTips(),
          ],
        ),
      ),
    );
  }

  // Build List of Steps
  List<Widget> _buildStepList() {
    List<String> steps = [
      'قم بزيارة صفحة التسجيل في التطبيق.',
      'أدخل الرقم القومي والبيانات المطلوبة.',
      'املأ نموذج التقديم وتأكد من صحة البيانات.',
      'ارفع المستندات المطلوبة بصيغة PDF أو JPEG.',
      'تابع حالة طلبك من خلال صفحة "طلبي".',
    ];
    return steps
        .map(
          (step) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.check_circle, color: Colors.green),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    step,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        )
        .toList();
  }

  // Build FAQs Section
  List<Widget> _buildFAQs() {
    List<Map<String, String>> faqs = [
      {
        'السؤال': 'ما هي المستندات المطلوبة للتقديم؟',
        'الإجابة': 'بطاقة الهوية، الشهادات الدراسية، وأي مستندات إضافية تُطلب.'
      },
      {
        'السؤال': 'كيف أتابع حالة طلبي؟',
        'الإجابة': 'سجل الدخول وانتقل إلى قسم "طلبي" لمتابعة الحالة.'
      },
      {
        'السؤال': 'هل يمكنني تعديل طلبي بعد إرساله؟',
        'الإجابة': 'نعم، إذا كان التعديل ضمن فترة التقديم المحددة.'
      },
    ];

    return faqs
        .map(
          (faq) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '- ${faq['السؤال']}',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87),
                ),
                SizedBox(height: 5),
                Text(
                  faq['الإجابة']!,
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                ),
              ],
            ),
          ),
        )
        .toList();
  }

  // Build Tips Section
  List<Widget> _buildTips() {
    List<String> tips = [
      'تأكد من وضوح المستندات المرفقة.',
      'أدخل معلوماتك الشخصية بدقة.',
      'ابدأ عملية التقديم مبكرًا لتجنب أي مشاكل.',
      'تابع الإشعارات للحصول على تحديثات حالة الطلب.',
    ];
    return tips
        .map(
          (tip) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.lightbulb, color: Colors.orange),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    tip,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        )
        .toList();
  }
}
