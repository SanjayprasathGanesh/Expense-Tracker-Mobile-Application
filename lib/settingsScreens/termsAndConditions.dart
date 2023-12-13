import 'package:flutter/material.dart';

class TermsAndConditions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Terms and Policies",style: TextStyle(
          color: Colors.black,
          fontSize: 17.0,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.bold,
        ),),
        backgroundColor: const Color(0xFFffb700),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: const [
            Text(
              '1. Introduction\n\n'
                  'Welcome to the Expense Tracker App. By using our app, you agree to comply with and be bound by the following terms and conditions. If you do not agree to these terms, please do not use the app.',
              style: TextStyle(
                fontSize: 16.0,
                fontFamily: 'Poppins',
                color: Colors.black,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              '2. Use of the App\n\n'
                  '2.1 Eligibility\n'
                  'You must be at least 18 years old to use this app. By using the app, you represent and warrant that you are at least 18 years old.\n\n'
                  '2.2 Account Creation\n'
                  'To access certain features of the app, you may be required to create an account. You agree to provide accurate, current, and complete information during the registration process.',
              style: TextStyle(
                fontSize: 16.0,
                fontFamily: 'Poppins',
                color: Colors.black,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              '3. User Responsibilities\n\n'
                  '3.1 Account Security\n'
                  'You are responsible for maintaining the confidentiality of your account credentials and for all activities that occur under your account. Notify us immediately if you suspect any unauthorized access to your account.',
              style: TextStyle(
                fontSize: 16.0,
                fontFamily: 'Poppins',
                color: Colors.black,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              '4. Data Handling\n\n'
                  '4.1 Collection of Information\n'
                  'We may collect personal information such as your name, email, and other relevant details for account creation and service improvement.\n\n'
                  '4.2 Use of Information\n'
                  'We use the collected information to provide and improve our services, personalize user experience, and communicate with users.\n\n'
                  '4.3 Data Security\n'
                  'We implement reasonable security measures to protect your information from unauthorized access, disclosure, or alteration.\n\n'
                  '4.4 Third-Party Services\n'
                  'We may use third-party services to process payments or analytics. These services may have their own privacy policies.\n\n'
                  '4.5 Consent\n'
                  'By using the app, you consent to the collection, use, and sharing of your information as described in these terms and our Privacy Policy.',
              style: TextStyle(
                fontSize: 16.0,
                fontFamily: 'Poppins',
                color: Colors.black,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              '5. Prohibited Activities\n\n'
                  'You agree not to engage in any of the following activities:\n\n'
                  '5.1 Violating Laws\n'
                  'Violate any applicable laws or regulations.\n\n'
                  '5.2 Interference\n'
                  'Interfere with the proper working of the app.\n\n'
                  '5.3 Unauthorized Access\n'
                  'Attempt to access restricted areas of the app without authorization.\n\n'
                  '5.4 Impersonation\n'
                  'Impersonate another user or person.\n\n'
                  '5.5 Misuse of Information\n'
                  'Use any information obtained from the app for unauthorized purposes.',
              style: TextStyle(
                fontSize: 16.0,
                fontFamily: 'Poppins',
                color: Colors.black,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              '6. Privacy Policy\n\n'
                  'By using the app, you agree to our Privacy Policy. Please review our Privacy Policy to understand how we collect, use, and disclose your information.',
              style: TextStyle(
                fontSize: 16.0,
                fontFamily: 'Poppins',
                color: Colors.black,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              '7. Changes to Terms\n\n'
                  'We reserve the right to modify or revise these terms and conditions at any time. Your continued use of the app after such changes will constitute acceptance of the new terms.',
              style: TextStyle(
                fontSize: 16.0,
                fontFamily: 'Poppins',
                color: Colors.black,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              '8. Termination\n\n'
                  'We may terminate or suspend your account and access to the app without prior notice if we believe that you have violated these terms and conditions.',
              style: TextStyle(
                fontSize: 16.0,
                fontFamily: 'Poppins',
                color: Colors.black,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              '9. Contact Us\n\n'
                  'If you have any questions about these terms and conditions, please contact us at support@expensetrackerapp.com.',
              style: TextStyle(
                fontSize: 16.0,
                fontFamily: 'Poppins',
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
